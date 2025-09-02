### Service Accounts

output "upwind_management_sa" {
  description = "The Upwind Management Service Account details."
  value       = google_service_account.upwind_management_sa
}

output "cloudscanner_sa" {
  description = "The Cloudscanner Service Account details."
  value       = var.enable_cloudscanners ? google_service_account.cloudscanner_sa[0] : null
}

output "cloudscanner_scaler_sa" {
  description = "The Cloudscanner Scaler Service Account details."
  value       = var.enable_cloudscanners ? google_service_account.cloudscanner_scaler_sa[0] : null
}

### IAM Custom Roles

output "google_project_iam_custom_role" {
  description = "The custom IAM roles created at the project level."
  value = {
    upwind_management_sa_cloudscanner_deployment_role = var.enable_cloudscanners ? google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role[0] : null
    cloudscanner_basic_role                           = var.enable_cloudscanners ? google_project_iam_custom_role.cloudscanner_basic_role[0] : null
    cloudscanner_scaler_role                          = var.enable_cloudscanners ? google_project_iam_custom_role.cloudscanner_scaler_role[0] : null
    cloudscanner_secret_access_role                   = var.enable_cloudscanners ? google_project_iam_custom_role.cloudscanner_secret_access_role[0] : null
    cloudscanner_instance_template_mgmt_role          = var.enable_cloudscanners ? google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role[0] : null
    cloudscanner_instance_template_test_creation_role = var.enable_cloudscanners ? google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role[0] : null
    compute_service_agent_minimal                     = var.enable_cloudscanners ? google_project_iam_custom_role.compute_service_agent_minimal[0] : null
    disk_writer                                       = var.enable_cloudscanners ? google_project_iam_custom_role.disk_writer[0] : null
  }
}
