### IAM Service Accounts
moved {
  from = google_service_account.upwind_management_sa
  to   = module.iam.google_service_account.upwind_management_sa
}

moved {
  from = google_service_account.cloudscanner_sa
  to   = module.iam.google_service_account.cloudscanner_sa
}

moved {
  from = google_service_account.cloudscanner_scaler_sa
  to   = module.iam.google_service_account.cloudscanner_scaler_sa
}

module "iam" {
  source = "../_shared/iam"

  upwind_organization_id      = var.upwind_organization_id
  upwind_orchestrator_project = var.upwind_orchestrator_project
  resource_suffix             = var.resource_suffix
  enable_cloudscanners        = var.enable_cloudscanners

  google_service_account_display_name = var.google_service_account_display_name
}
