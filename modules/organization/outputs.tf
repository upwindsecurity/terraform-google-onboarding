output "upwind_management_service_account_name" {
  description = "The name of the Upwind Management Service Account."
  value       = google_service_account.upwind_management_sa.name
}

output "upwind_management_service_account_display_name" {
  description = "The display name of the Upwind Management Service Account."
  value       = google_service_account.upwind_management_sa.display_name
}

output "upwind_management_service_account_email" {
  description = "The email address of the Upwind Management Service Account."
  value       = google_service_account.upwind_management_sa.email
}

output "upwind_management_service_account_unique_id" {
  description = "The unique ID of the Upwind Management Service Account."
  value       = google_service_account.upwind_management_sa.unique_id
}

output "upwind_management_service_account_project" {
  description = "The project ID of the Upwind Management Service Account."
  value       = google_service_account.upwind_management_sa.project
}

output "org_creds" {
  description = "The organizational credentials for the organizations pending onboarding."
  value       = local.raw_credentials
}

output "pending_orgs" {
  description = "The organizational credentials for the organizations pending onboarding."
  value       = local.pending_onboarding_orgs
}
