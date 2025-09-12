output "upwind_management_service_account_name" {
  description = "The name of the Upwind Management Service Account."
  value       = module.iam.upwind_management_sa.name
}

output "upwind_management_service_account_display_name" {
  description = "The display name of the Upwind Management Service Account."
  value       = module.iam.upwind_management_sa.display_name
}

output "upwind_management_service_account_email" {
  description = "The email address of the Upwind Management Service Account."
  value       = module.iam.upwind_management_sa.email
}

output "upwind_management_service_account_unique_id" {
  description = "The unique ID of the Upwind Management Service Account."
  value       = module.iam.upwind_management_sa.unique_id
}

output "upwind_management_service_account_project" {
  description = "The project ID of the Upwind Management Service Account."
  value       = module.iam.upwind_management_sa.project
}

output "upwind_workload_identity_pool_id" {
  description = "The ID of the Upwind Workload Identity Pool."
  value       = module.iam.google_iam_workload_identity_pool.workload_identity_pool_id
}

output "workload_identity_provider_name" {
  description = "Full path name of the workload identity pool provider"
  value       = "projects/${data.google_project.current.number}/locations/global/workloadIdentityPools/${module.iam.google_iam_workload_identity_pool.workload_identity_pool_id}/providers/${module.iam.google_iam_workload_identity_pool_provider.workload_identity_pool_provider_id}"
}

output "all_folder_projects" {
  description = "List of all folder projects"
  value       = local.all_folder_projects
}

output "folder_projects_map" {
  description = "Map of folder IDs to their respective project IDs"
  value = {
    for folder_id in var.target_folder_ids :
    folder_id => [
      for project in data.google_projects.folder_projects[folder_id].projects : project.project_id
    ]
  }
}

output "organization_custom_roles" {
  description = "Organization-level custom roles created for folder access"
  value = {
    storage_reader_role = google_organization_iam_custom_role.storage_reader_role.id
    cloudscanner_roles = var.enable_cloudscanners ? {
      iam_read_role              = google_organization_iam_custom_role.upwind_management_sa_iam_read_role[0].id
      snapshot_reader_role       = google_organization_iam_custom_role.snapshot_reader[0].id
      snapshot_creator_role      = google_organization_iam_custom_role.snapshot_creator[0].id
      snapshot_deleter_role      = google_organization_iam_custom_role.snapshot_deleter[0].id
      cloud_run_role             = google_organization_iam_custom_role.cloudscanner_cloud_run_role[0].id
      storage_object_reader_role = var.enable_dspm ? google_organization_iam_custom_role.storage_object_reader[0].id : null
    } : null
  }
}
