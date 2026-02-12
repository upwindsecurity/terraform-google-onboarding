# ️DEPRECATION WARNING
# This module is deprecated and will no longer receive updates.
# Please migrate to the 'organization' or 'multiproject' module:
# https://registry.terraform.io/modules/upwindsecurity/onboarding/google

locals {
  google_service_account_private_key = jsondecode(base64decode(google_service_account_key.sak.private_key))
}

# Check block for deprecation warning - shows during terraform plan and apply
# Check blocks are available in Terraform 1.5.0+
# This check intentionally fails to display the deprecation warning and prevent applies
# Set skip_deprecation_warning = true to bypass this check
check "deprecation_warning" {
  assert {
    condition     = var.skip_deprecation_warning
    error_message = <<-EOT
╔═══════════════════════════════════════════════════════════════════════════════╗
║                             DEPRECATION WARNING                               ║
╠═══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║  The 'project' module is DEPRECATED and will no longer receive updates.       ║
║                                                                               ║
║  Please migrate to one of the newer modules:                                  ║
║  • organization: https://registry.terraform.io/modules/upwindsecurity/        ║
║                  onboarding/google/latest/submodules/organization             ║
║  • multiproject: https://registry.terraform.io/modules/upwindsecurity/        ║
║                  onboarding/google/latest/submodules/multiproject             ║
║                                                                               ║
║  These modules provide better functionality, improved security, and           ║
║  ongoing support.                                                             ║
║                                                                               ║
║  To proceed with this deprecated module, set skip_deprecation_warning = true  ║
║                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════╝
    EOT
  }
}

resource "random_id" "uid" {
  byte_length = 4
}

resource "google_service_account" "sa" {
  account_id   = format("%s-%s", var.google_service_account_id_prefix, random_id.uid.hex)
  display_name = var.google_service_account_display_name
}

resource "google_service_account_key" "sak" {
  service_account_id = google_service_account.sa.name
}

resource "google_project_iam_member" "pam" {
  for_each = toset(var.google_service_account_roles)
  role     = each.value
  project  = google_service_account.sa.project
  member   = format("serviceAccount:%s", google_service_account.sa.email)
}

# tflint-ignore: terraform_unused_declarations
data "http" "upwind_create_credentials_request" {
  count = var.upwind_skip_http ? 0 : 1

  method = "POST"
  url = format(
    "%s/v1/organizations/%s/set-credentials",
    var.upwind_region == "us" ? var.upwind_integration_endpoint :
    var.upwind_region == "eu" ? replace(var.upwind_integration_endpoint, ".upwind.", ".eu.upwind.") :
    var.upwind_region == "me" ? replace(var.upwind_integration_endpoint, ".upwind.", ".me.upwind.") :
    var.upwind_integration_endpoint,
    var.upwind_organization_id,
  )

  request_headers = {
    "Content-Type"  = "application/json"
    "Authorization" = format("Bearer %s", local.upwind_access_token)
  }

  request_body = jsonencode(
    {
      "provider" = {
        "name"       = "gcp",
        "project_id" = google_service_account.sa.project,
      },
      "spec" = {
        "client_id"      = local.google_service_account_private_key.client_id,
        "client_email"   = local.google_service_account_private_key.client_email,
        "private_key"    = local.google_service_account_private_key.private_key,
        "private_key_id" = local.google_service_account_private_key.private_key_id,
      }
    }
  )

  retry {
    attempts = 3
  }

  lifecycle {
    precondition {
      condition     = local.upwind_access_token != null
      error_message = "Unable to obtain access token. Please verify your client ID and client secret. Error: ${try(data.http.upwind_get_access_token_request[0].response_body, null)}"
    }
  }
}
