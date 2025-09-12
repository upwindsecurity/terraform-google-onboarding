# Organization onboarding outputs
output "organization_service_account_email" {
  description = "The email address of the organization service account"
  value       = module.upwind_organization_onboarding.upwind_management_service_account_email
}

output "organization_service_account_display_name" {
  description = "The name of the organization service account"
  value       = module.upwind_organization_onboarding.upwind_management_service_account_display_name
}

output "organization_service_account_unique_id" {
  description = "The unique ID of the organization service account"
  value       = module.upwind_organization_onboarding.upwind_management_service_account_unique_id
}

output "organization_service_account_project" {
  description = "The project of the organization service account"
  value       = module.upwind_organization_onboarding.upwind_management_service_account_project
}

output "organization_service_account_name" {
  description = "The name of the organization service account"
  value       = module.upwind_organization_onboarding.upwind_management_service_account_name
}

output "workload_identity_provider_name" {
  description = "Full path name of the workload identity pool provider"
  value       = module.upwind_organization_onboarding.workload_identity_provider_name
}
