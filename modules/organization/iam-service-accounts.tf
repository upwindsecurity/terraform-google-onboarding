### IAM Service Accounts

# account_id is limited to 30 characters, so on renaming this will need some consideration
# temporary name prefix of test- to be updated to upwind-

# The service account to configure all automatic deployment of Cloudscanners
resource "google_service_account" "upwind_management_sa" {
  project      = local.project
  account_id   = format("upwind-mgmt-%s", local.resource_suffix_hyphen)
  display_name = var.google_service_account_display_name
  description  = "Service account with access to the organisation"

  lifecycle {
    precondition {
      condition     = length(local.resource_suffix_hyphen) <= 16
      error_message = "Service account ID cannot exceed 30 characters."
    }
  }
}

# The service account key for the management service account
resource "google_service_account_key" "upwind_management_sa_key" {
  service_account_id = google_service_account.upwind_management_sa.name
}

### CloudScanner Service Accounts

# The main service account for the CloudScanner to use across all projects
resource "google_service_account" "cloudscanner_sa" {
  count        = var.enable_cloudscanners ? 1 : 0
  project      = local.project
  account_id   = format("upwind-cs-%s", local.resource_suffix_hyphen)
  display_name = "Upwind CloudScanner Cross Account Service Account"
  description  = "Service account used by CloudScanners to perform scans across multiple projects"

  lifecycle {
    precondition {
      condition     = length(local.resource_suffix_hyphen) <= 16
      error_message = "Service account ID cannot exceed 30 characters."
    }
  }
}

# The service account which will be used to run the scaler function
resource "google_service_account" "cloudscanner_scaler_sa" {
  count        = var.enable_cloudscanners ? 1 : 0
  project      = local.project
  account_id   = format("upwind-scaler-%s", local.resource_suffix_hyphen)
  display_name = "Upwind CloudScanner Scaler Service Account"
  description  = "Service account used to manage the scaling of CloudScanners"

  lifecycle {
    precondition {
      condition     = length(local.resource_suffix_hyphen) <= 16
      error_message = "Service account ID cannot exceed 30 characters."
    }
  }
}
