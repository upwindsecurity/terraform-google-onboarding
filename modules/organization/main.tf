locals {
  project = var.upwind_orchestrator_project
  # Sanitize the org_id to be used in resource names
  # SA names can't have underscores and have a small limit on length...
  # Additionally they have to end with a lowercase letter or number......
  org_id_sanitized = replace(lower(var.upwind_organization_id), "org_", "")
  # Since we need to accommodate a custom suffix defined by the user, we actually need to reduce this length further
  # Else, we can't have nice naming formats with purposeful prefixes
  org_id_truncated = substr(local.org_id_sanitized, max(0, length(local.org_id_sanitized) - 5), 5)
  # Due to length limits, we can allow a 10 character suffix:
  # upwind-scaler- is the longest base = 14 chars
  # org_id_truncated = 5 chars
  # resource_suffix = 10 chars with a hyphen
  resource_suffix_hyphen             = format("%s%s", local.org_id_truncated, var.resource_suffix == "" ? "" : "-${var.resource_suffix}")
  resource_suffix_underscore         = format("%s%s", local.org_id_truncated, var.resource_suffix == "" ? "" : "_${var.resource_suffix}")
  google_service_account_private_key = sensitive(jsondecode(base64decode(google_service_account_key.upwind_management_sa_key.private_key)))

  # Only one GCP organization for now, to expand in future
  gcp_org_ids = [var.gcp_organization_id]

  # Create a map of existing organizational credentials
  raw_credentials = jsondecode(data.http.upwind_get_organizational_credentials_request.response_body)
  organizational_credentials = {
    for cc in local.raw_credentials :
    lower(tostring(cc.gcpOrganizationId)) => true
    if can(cc.gcpOrganizationId)
  }

  # Gather GCP orgs pending onboarding, i.e. those that do not have existing credentials
  pending_onboarding_orgs = [
    for gcp_org in local.gcp_org_ids : gcp_org
    if lookup(local.organizational_credentials, gcp_org, false) == false
  ]

  # Only create credentials if there are pending organizations and we're not in destroy mode
  create_credentials = length(local.pending_onboarding_orgs) > 0 && var.create_organizational_credentials

  # Determine integration endpoint based on region
  auth_endpoint        = var.upwind_region == "us" ? var.upwind_auth_endpoint : replace(var.upwind_auth_endpoint, ".upwind.", ".eu.upwind.")
  integration_endpoint = var.upwind_region == "us" ? var.upwind_integration_endpoint : replace(var.upwind_integration_endpoint, ".upwind.", ".eu.upwind.")
}

provider "google" {
  project = local.project
}

data "google_organization" "org" {
  organization = var.gcp_organization_id
}

data "http" "upwind_get_organizational_credentials_request" {
  method = "GET"

  url = format(
    "%s/v1/organizations/%s/organizational-credentials/gcp",
    local.integration_endpoint,
    var.upwind_organization_id,
  )

  request_headers = {
    "Content-Type"  = "application/json"
    "Authorization" = format("Bearer %s", local.upwind_access_token)
  }

  retry {
    attempts = 3
  }

  lifecycle {
    precondition {
      condition     = local.upwind_access_token != null
      error_message = "Unable to obtain access token. Please verify your client ID and client secret. Response: ${data.http.upwind_get_access_token_request.response_body}."
    }
  }
}

# Post the Service Account credentials to Upwind
# tflint-ignore: terraform_unused_declarations
data "http" "upwind_create_credentials_request" {
  # Note that this uses a list of orgs but we only expect one for now
  for_each = local.create_credentials ? toset(local.pending_onboarding_orgs) : []

  method = "POST"
  url = format(
    "%s/v1/organizations/%s/organizational-accounts/gcp/onboard",
    local.integration_endpoint,
    var.upwind_organization_id,
  )

  request_headers = {
    "Content-Type"  = "application/json"
    "Authorization" = format("Bearer %s", local.upwind_access_token)
  }

  request_body = jsonencode(
    {
      "create_credentials_request" = {
        "provider" = {
          "name"       = "gcp",
          "project_id" = google_service_account.upwind_management_sa.project,
        },
        "spec" = {
          "client_id"      = local.google_service_account_private_key.client_id,
          "client_email"   = local.google_service_account_private_key.client_email,
          "private_key"    = local.google_service_account_private_key.private_key,
          "private_key_id" = local.google_service_account_private_key.private_key_id,
        },
      },
      "gcp_organization_id" = each.value,
    }
  )

  retry {
    attempts = 3
  }

  lifecycle {
    precondition {
      condition     = local.upwind_access_token != null
      error_message = "Unable to obtain access token. Please verify your client ID and client secret. Error: ${try(data.http.upwind_get_access_token_request.response_body, null)}"
    }
    postcondition {
      condition     = self.status_code == 201
      error_message = "HTTP request failed with status code ${self.status_code}, ${self.response_body}"
    }
  }
}

# tflint-ignore: terraform_unused_declarations
resource "null_resource" "upwind_patch_credentials_request" {
  # Note that this uses a list of orgs but we only expect one for now
  for_each = local.create_credentials ? toset(local.pending_onboarding_orgs) : []

  triggers = {
    organization_id        = each.value
    project                = google_service_account.upwind_management_sa.project
    endpoint               = local.integration_endpoint
    upwind_organization_id = var.upwind_organization_id
  }

  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash
      set -e

      for i in {1..3}; do
        echo "Attempt $i: Sending PATCH request..."

        response_file=$(mktemp)

        status_code=$(curl -s -w "%%{http_code}" -o "$response_file" \
          -X PATCH \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${local.upwind_access_token}" \
          -d '{"gcp_organization_id": "${each.value}", "admin_cloud_account_id": "${google_service_account.upwind_management_sa.project}"}' \
          "${local.integration_endpoint}/v1/organizations/${var.upwind_organization_id}/organizational-credentials/gcp/admin-account-id")

        response_body=$(cat "$response_file")
        echo "$status_code" > "${path.module}/patch_status_code.txt"
        echo "$response_body" > "${path.module}/patch_response_body.txt"
        rm "$response_file"

        if [ "$status_code" = "200" ]; then
          echo "Request successful with 200"
          exit 0
        fi

        echo "Attempt $i failed with status code $status_code"
        if [ $i -lt 3 ]; then
          echo "Retrying in 5 seconds..."
          sleep 5
        fi
      done

      echo "All retry attempts failed. Last status code: $status_code"
      exit 0
    EOT
  }

  depends_on = [
    data.http.upwind_create_credentials_request[0],
  ]

  lifecycle {
    precondition {
      condition     = local.upwind_access_token != null
      error_message = "Unable to obtain access token. Please verify your client ID and client secret."
    }
  }
}

data "local_file" "patch_status_code" {
  count      = local.create_credentials && fileexists("${path.module}/patch_status_code.txt") ? 1 : 0
  filename   = "${path.module}/patch_status_code.txt"
  depends_on = [null_resource.upwind_patch_credentials_request[0]]
}

data "local_file" "patch_response_body" {
  count      = local.create_credentials && fileexists("${path.module}/patch_response_body.txt") ? 1 : 0
  filename   = "${path.module}/patch_response_body.txt"
  depends_on = [null_resource.upwind_patch_credentials_request[0]]
}

# tflint-ignore: terraform_unused_declarations
resource "null_resource" "verify_patch_request" {
  count = local.create_credentials && fileexists("${path.module}/patch_status_code.txt") && fileexists("${path.module}/patch_response_body.txt") ? 1 : 0
  triggers = {
    status_code   = trimspace(data.local_file.patch_status_code[0].content)
    response_body = data.local_file.patch_response_body[0].content
  }

  lifecycle {
    postcondition {
      condition     = self.triggers.status_code == "200"
      error_message = "API request failed with status code ${self.triggers.status_code}. Response: ${self.triggers.response_body}"
    }
  }

  depends_on = [null_resource.upwind_patch_credentials_request[0]]
}

# tflint-ignore: terraform_unused_declarations
resource "null_resource" "cleanup_patch_request" {
  count = local.create_credentials && fileexists("${path.module}/patch_status_code.txt") && fileexists("${path.module}/patch_response_body.txt") ? 1 : 0
  triggers = {
    status_code   = trimspace(data.local_file.patch_status_code[0].content)
    response_body = data.local_file.patch_response_body[0].content
  }

  provisioner "local-exec" {
    command = "rm ${path.module}/patch_status_code.txt ${path.module}/patch_response_body.txt"
  }

  depends_on = [null_resource.verify_patch_request[0]]
}
