locals {
  # Select dev or prod AWS account based on auth endpoint
  is_dev             = strcontains(var.upwind_auth_endpoint, "upwind.dev") || strcontains(var.upwind_integration_endpoint, "upwind.dev")
  upwind_aws_account = local.is_dev ? "437279811180" : "627244208106"
  timestamp          = formatdate("YYYYMMDD-hhmm", timestamp())
}

# This pool needs a timestamp, as GCP uses soft-deletion for WIF pools
# This allows us to create a new pool in an apply-destroy-apply cycle
resource "google_iam_workload_identity_pool" "main" {
  workload_identity_pool_id = "upwind-${local.org_id_truncated}-pool-${local.timestamp}"
  display_name              = "Upwind Identity Pool"
  description               = "Identity pool for external Upwind workloads"
  disabled                  = false

  lifecycle {
    # Ignore changes to the pool ID after creation
    # This prevents recreation on subsequent applies while allowing initial creation with timestamp
    ignore_changes = [workload_identity_pool_id]

    # Create before destroy to handle soft deletion gracefully
    create_before_destroy = true
  }
}

resource "google_iam_workload_identity_pool_provider" "aws" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.main.workload_identity_pool_id
  workload_identity_pool_provider_id = "upwind-${local.org_id_truncated}-aws-provider"
  display_name                       = "Upwind AWS Provider"
  description                        = "Identity pool provider for Upwind AWS workloads"

  attribute_mapping = {
    "google.subject"        = "assertion.arn"
    "attribute.aws_account" = "assertion.account"
  }

  attribute_condition = "assertion.account == '${local.upwind_aws_account}'"

  aws {
    account_id = local.upwind_aws_account
  }
}

# Management SA access
resource "google_service_account_iam_member" "management_workload_identity" {
  service_account_id = google_service_account.upwind_management_sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/attribute.aws_account/${local.upwind_aws_account}"
  depends_on         = [google_service_account.upwind_management_sa]
}

# Service Account Token Creator for impersonation
resource "google_service_account_iam_member" "management_token_creator" {
  service_account_id = google_service_account.upwind_management_sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/attribute.aws_account/${local.upwind_aws_account}"
  depends_on         = [google_service_account.upwind_management_sa]
}

# Cloudscanner SA access
resource "google_service_account_iam_member" "cloudscanner_workload_identity" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_sa[0].id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/attribute.aws_account/${local.upwind_aws_account}"
  depends_on         = [google_service_account.cloudscanner_sa]
}

# Service Account Token Creator for cloudscanner impersonation
resource "google_service_account_iam_member" "cloudscanner_token_creator" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_sa[0].id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/attribute.aws_account/${local.upwind_aws_account}"
  depends_on         = [google_service_account.cloudscanner_sa]
}