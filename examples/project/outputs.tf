# Outputs from the project onboarding module
output "service_account_email" {
  description = "The email address of the created service account"
  value       = module.upwind_project_onboarding.google_service_account_email
}

output "service_account_name" {
  description = "The name of the created service account"
  value       = module.upwind_project_onboarding.google_service_account_name
}

output "project_id" {
  description = "The GCP project ID where the service account was created"
  value       = module.upwind_project_onboarding.google_service_account_project
}
