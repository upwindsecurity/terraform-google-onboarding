# Organization-only example: Onboard entire organization to Upwind
module "upwind_organization_onboarding" {
  source = "../../modules/folder"

  target_folder_ids = var.target_folder_ids

  # Required Upwind configuration
  upwind_organization_id = var.upwind_organization_id
  upwind_client_id       = var.upwind_client_id
  upwind_client_secret   = var.upwind_client_secret

  # Required Google Cloud configuration
  gcp_organization_id         = var.gcp_organization_id
  upwind_orchestrator_project = var.upwind_orchestrator_project
  workload_identity_trusted_account = "111111111111"

  # Optional configuration
  enable_cloudscanners                = true
  scanner_client_id                   = var.scanner_client_id
  scanner_client_secret               = var.scanner_client_secret
  google_service_account_display_name = "Upwind Security Service Account - Multiproject"
  workload_identity_pool_project      = var.workload_identity_pool_project
  resource_suffix                     = var.resource_suffix
  is_dev                              = var.is_dev
  labels = {
    environment = "dev"
    creator     = "test"
  }
}
