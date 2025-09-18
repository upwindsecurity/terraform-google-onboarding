### Folder-Level IAM for Multi-Project Access via Folder Inheritance

### Custom Roles (created at folder level for inheritance)

# Storage reader role (organization-wide, applied to folders)
resource "google_organization_iam_custom_role" "storage_reader_role" {
  org_id      = var.gcp_organization_id
  role_id     = "UpwindFolderStorageReader_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-storage-reader"
  description = "Custom role for Upwind Management Service Account to read storage buckets across folders."

  permissions = module.iam.storage_read_permissions
}

# Give the management service account the basic viewer role on each target folder
resource "google_folder_iam_member" "upwind_management_sa_folder_viewer_role_member" {
  for_each = toset(var.target_folder_ids)

  folder = each.value
  role   = "roles/viewer"
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant custom storage reader role to management SA on each target folder
resource "google_folder_iam_member" "upwind_management_sa_storage_reader_role_member" {
  for_each = toset(var.target_folder_ids)

  folder = each.value
  role   = google_organization_iam_custom_role.storage_reader_role.id
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant Cloud Asset Inventory permissions on each target folder
resource "google_folder_iam_member" "upwind_management_sa_asset_viewer_role_member" {
  for_each = toset(var.target_folder_ids)

  folder = each.value
  role   = "roles/cloudasset.viewer"
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Required for DSPM functionality when cloudscanners are enabled
resource "google_folder_iam_member" "cloudscanner_sa_storage_reader_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.storage_reader_role.id
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}
