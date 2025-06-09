# Google Cloud provider configuration
provider "google" {
  project = "your-gcp-project-id" # Replace with your actual GCP project ID
  region  = "us-central1"         # Replace with your preferred region
}

# Basic example: Onboard a single Google Cloud project to Upwind
module "upwind_project_onboarding" {
  source = "../../modules/project"

  # Required Upwind configuration
  upwind_organization_id = "org_example12345"
  upwind_client_id       = "client_example12345"
  upwind_client_secret   = "your-client-secret-here"

  # Optional configuration
  upwind_region = "us"

  # Google Cloud configuration
  google_service_account_display_name = "Upwind Security Service Account"
}

# Example of post-onboarding setup
resource "null_resource" "post_onboarding_setup" {
  provisioner "local-exec" {
    command = "echo 'Upwind project onboarding completed successfully'"
  }

  depends_on = [
    module.upwind_project_onboarding
  ]
}
