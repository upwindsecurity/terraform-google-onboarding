module "iam" {
  source = "../_shared/iam"

  upwind_organization_id      = var.upwind_organization_id
  upwind_orchestrator_project = var.upwind_orchestrator_project
  upwind_client_id            = var.upwind_client_id
  upwind_client_secret        = var.upwind_client_secret
  scanner_client_id           = var.scanner_client_id
  scanner_client_secret       = var.scanner_client_secret
  resource_suffix             = var.resource_suffix
  enable_cloudscanners        = var.enable_cloudscanners
  labels                      = var.labels

  google_service_account_display_name = var.google_service_account_display_name
  workload_identity_pool_project      = var.workload_identity_pool_project
  workload_identity_trusted_account   = var.workload_identity_trusted_account
  is_dev                              = var.is_dev
}
