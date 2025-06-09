output "google_service_account_name" {
  description = "The fully-qualified name of the service account."
  value       = google_service_account.sa.name
}

output "google_service_account_display_name" {
  description = "The display name of the service account."
  value       = google_service_account.sa.display_name
}

output "google_service_account_email" {
  description = "The email address of the service account."
  value       = google_service_account.sa.email
}

output "google_service_account_unique_id" {
  description = "The unique ID of the service account."
  value       = google_service_account.sa.unique_id
}

output "google_service_account_project" {
  description = "The project ID of the service account."
  value       = google_service_account.sa.project
}
