### Secrets used by Cloudscanners

resource "google_secret_manager_secret" "upwind_client_id" {
  secret_id = "upwind-client-id-${local.resource_suffix_hyphen}"
  project   = local.project
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "upwind_client_secret" {
  secret_id = "upwind-client-secret-${local.resource_suffix_hyphen}"
  project   = local.project
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "scanner_client_id" {
  count     = var.enable_cloudscanners ? 1 : 0
  secret_id = "upwind-scanner-client-id-${local.resource_suffix_hyphen}"
  project   = local.project
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "scanner_client_secret" {
  count     = var.enable_cloudscanners ? 1 : 0
  secret_id = "upwind-scanner-client-secret-${local.resource_suffix_hyphen}"
  project   = local.project
  replication {
    auto {}
  }
}

# Create an empty secret but apply the user-defined labels to the resource
resource "google_secret_manager_secret" "terraform_labels" {
  secret_id = "upwind-default-labels-${local.resource_suffix_hyphen}"
  project   = local.project

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "upwind_client_id_v1" {
  secret         = google_secret_manager_secret.upwind_client_id.id
  secret_data_wo = var.upwind_client_id
}

resource "google_secret_manager_secret_version" "upwind_client_secret_v1" {
  secret         = google_secret_manager_secret.upwind_client_secret.id
  secret_data_wo = var.upwind_client_secret
}

resource "google_secret_manager_secret_version" "scanner_client_id_v1" {
  count          = var.enable_cloudscanners ? 1 : 0
  secret         = google_secret_manager_secret.scanner_client_id[0].id
  secret_data_wo = var.scanner_client_id
}

resource "google_secret_manager_secret_version" "scanner_client_secret_v1" {
  count          = var.enable_cloudscanners ? 1 : 0
  secret         = google_secret_manager_secret.scanner_client_secret[0].id
  secret_data_wo = var.scanner_client_secret
}

resource "google_secret_manager_secret_version" "terraform_labels_v1" {
  secret         = google_secret_manager_secret.terraform_labels.id
  secret_data_wo = "labels-stored-as-resource-metadata"
}
