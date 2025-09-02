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

### IAM Members

output "google_project_iam_member" {
  description = "The IAM role bindings at the project level."
  value = {
    upwind_management_sa_cloudscanner_deployment_role_member = var.enable_cloudscanners ? google_project_iam_member.upwind_management_sa_cloudscanner_deployment_role_member[0] : null
    upwind_management_sa_secret_access_role_member           = var.enable_cloudscanners ? google_project_iam_member.upwind_management_sa_secret_access_role_member[0] : null
    cloudrun_service_agent                                   = var.enable_cloudscanners ? google_project_iam_member.cloudrun_service_agent[0] : null
    compute_service_agent_minimal                            = var.enable_cloudscanners ? google_project_iam_member.compute_service_agent_minimal[0] : null
    cloudscanner_instance_template_mgmt_member               = var.enable_cloudscanners ? google_project_iam_member.cloudscanner_instance_template_mgmt_member[0] : null
    cloudscanner_instance_template_test_creation_member      = var.enable_cloudscanners ? google_project_iam_member.cloudscanner_instance_template_test_creation_member[0] : null
    cloudscanner_sa_basic_role_member                        = var.enable_cloudscanners ? google_project_iam_member.cloudscanner_sa_basic_role_member[0] : null
    cloudscanner_sa_scaler_role_member                       = var.enable_cloudscanners ? google_project_iam_member.cloudscanner_sa_scaler_role_member[0] : null
    cloudscanner_scaler_sa_run_invoker                       = var.enable_cloudscanners ? google_project_iam_member.cloudscanner_scaler_sa_run_invoker[0] : null
    cloudscanner_scaler_sa_scaler_role_member                = var.enable_cloudscanners ? google_project_iam_member.cloudscanner_scaler_sa_scaler_role_member[0] : null
    cloudscanner_scaler_secret_access_scaler_role_member     = var.enable_cloudscanners ? google_project_iam_member.cloudscanner_scaler_secret_access_scaler_role_member[0] : null
    cloudscanner_secret_access_role_member                   = var.enable_cloudscanners ? google_project_iam_member.cloudscanner_secret_access_role_member[0] : null
  }
}

output "google_project_iam_binding" {
  description = "The IAM bindings at the project level."
  value = {
    cloudscanner_disk_writer_role_binding = var.enable_cloudscanners ? google_project_iam_binding.cloudscanner_disk_writer_role_binding[0] : null
  }
}

output "google_service_account_iam_binding" {
  description = "The IAM bindings for service accounts."
  value = {
    scaler_and_compute_can_use_cloudscanner = var.enable_cloudscanners ? google_service_account_iam_binding.scaler_and_compute_can_use_cloudscanner[0] : null
    cloudscanner_impersonate_scaler         = var.enable_cloudscanners ? google_service_account_iam_member.cloudscanner_impersonate_scaler[0] : null
    management_can_impersonate_scanner      = var.enable_cloudscanners ? google_service_account_iam_member.management_can_impersonate_scanner[0] : null
    management_can_impersonate_scaler       = var.enable_cloudscanners ? google_service_account_iam_member.management_can_impersonate_scaler[0] : null
    scanner_can_impersonate_scaler          = var.enable_cloudscanners ? google_service_account_iam_member.scanner_can_impersonate_scaler[0] : null
    scaler_can_impersonate_scanner          = var.enable_cloudscanners ? google_service_account_iam_member.scaler_can_impersonate_scanner[0] : null
    cloudscheduler_can_impersonate_scaler   = var.enable_cloudscanners ? google_service_account_iam_member.cloudscheduler_can_impersonate_scaler[0] : null
  }
}

### Secrets

output "google_secret_manager_secret" {
  description = "The secrets created in Secret Manager."
  value = {
    upwind_client_id      = google_secret_manager_secret.upwind_client_id
    upwind_client_secret  = google_secret_manager_secret.upwind_client_secret
    scanner_client_id     = var.enable_cloudscanners ? google_secret_manager_secret.scanner_client_id : null
    scanner_client_secret = var.enable_cloudscanners ? google_secret_manager_secret.scanner_client_secret : null
  }
}

### Workload Identity Federation

output "google_iam_workload_identity_pool" {
  description = "The Workload Identity Pool created."
  value       = google_iam_workload_identity_pool.main
}

output "google_iam_workload_identity_pool_provider" {
  description = "The Workload Identity Pool Provider created."
  value       = google_iam_workload_identity_pool_provider.aws
}

### Permissions

output "storage_read_permissions" {
  description = "List of IAM permissions for storage read access."
  value       = var.storage_read_permissions
}

output "iam_read_role_permissions" {
  description = "List of IAM permissions for read-only access role."
  value       = var.iam_read_role_permissions
}

output "snapshot_reader_permissions" {
  description = "List of IAM permissions for snapshot reader role."
  value       = var.snapshot_reader_permissions
}

output "snapshot_creator_permissions" {
  description = "List of IAM permissions for snapshot creator role."
  value       = var.snapshot_creator_permissions
}

output "snapshot_deleter_permissions" {
  description = "List of IAM permissions for snapshot deleter role."
  value       = var.snapshot_deleter_permissions
}

output "storage_object_reader_permissions" {
  description = "List of IAM permissions for storage object reader role."
  value       = [
    "storage.objects.get",
  ]
}

output "cloud_run_permissions" {
  description = "List of IAM permissions for Cloud Run role."
  value       = var.cloud_run_permissions
}

### Labels

output "labels" {
  description = "Labels applied to all resources."
  value       = var.labels
}

output "default_labels" {
  description = "Default labels applied to all resources (can be overridden)."
  value       = var.default_labels
}
