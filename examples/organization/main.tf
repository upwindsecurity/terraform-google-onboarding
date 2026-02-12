# Organization-only example: Onboard entire organization to Upwind
module "upwind_organization_onboarding" {
  source = "../../modules/organization"

  # Required Upwind configuration
  upwind_organization_id = "org_example12345"
  upwind_client_id       = "client_example12345"
  upwind_client_secret   = "your-client-secret-here"

  # Required Google Cloud configuration
  gcp_organization_id         = "123456789012"
  upwind_orchestrator_project = "my-upwind-orchestrator"
  workload_identity_trusted_account = "111111111111"

  # Optional configuration
  enable_cloudscanners                = true
  scanner_client_id                   = "scanner_client_example12345"
  scanner_client_secret               = "your-scanner-client-secret-here"
  google_service_account_display_name = "Upwind Security Service Account - Org"
  resource_suffix                     = "abcdef1234"
}

# Example of post-onboarding setup
resource "null_resource" "post_onboarding_setup" {
  count = var.create_optional_resources ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'Upwind organization onboarding completed successfully'"
  }

  depends_on = [
    module.upwind_organization_onboarding
  ]
}
