# Organization onboarding outputs
output "organization_service_account_email" {
  description = "The email address of the organization service account"
  value       = module.upwind_organization_onboarding.upwind_management_service_account_email
}

output "organization_service_account_name" {
  description = "The name of the organization service account"
  value       = module.upwind_organization_onboarding.upwind_management_service_account_name
}

output "organization_service_account_unique_id" {
  description = "The unique ID of the organization service account"
  value       = module.upwind_organization_onboarding.upwind_management_service_account_unique_id
}

output "organizational_credentials" {
  description = "The organizational credentials for pending onboarding"
  value       = module.upwind_organization_onboarding.org_creds
}

output "pending_organizations" {
  description = "The organizations pending onboarding"
  value       = module.upwind_organization_onboarding.pending_orgs
}

# Summary outputs

output "organization_onboarded" {
  description = "Whether the organization was successfully onboarded"
  value       = true
}

output "post_onboarding_setup_completed" {
  description = "Whether post-onboarding setup was completed (if optional resources were created)"
  value       = var.create_optional_resources
}
