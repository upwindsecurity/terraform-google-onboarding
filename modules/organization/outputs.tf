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

output "upwind_workload_identity_pool_id" {
  description = "The ID of the Upwind Workload Identity Pool."
  value       = google_iam_workload_identity_pool.main.workload_identity_pool_id
}

output "workload_identity_provider_name" {
  description = "Full path name of the workload identity pool provider"
  value       = "projects/${data.google_project.current.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.main.workload_identity_pool_id}/providers/${google_iam_workload_identity_pool_provider.aws.workload_identity_pool_provider_id}"
}