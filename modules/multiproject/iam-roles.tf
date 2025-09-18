### Project-Scoped IAM for Multi-Project Access

### Custom Roles (created in each target project)

# Specifically grant permissions to read storage objects
# This is a reduction from the storageAdmin role to grant read only access
resource "google_project_iam_custom_role" "storage_reader_role" {
  for_each = toset(var.target_project_ids)

  project     = each.value
  role_id     = "UpwindStorageReader_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-storage-reader"
  description = "Custom role for Upwind Management Service Account to read storage buckets."

  permissions = module.iam.storage_read_permissions
}

# Give the management service account the basic viewer role on each target project
# We will grant more permissions if Cloud Scanners are enabled
resource "google_project_iam_member" "upwind_management_sa_project_viewer_role_member" {
  for_each = toset(var.target_project_ids)

  project = each.value
  role    = "roles/viewer"
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant custom storage reader role to management SA on each target project
resource "google_project_iam_member" "upwind_management_sa_storage_reader_role_member" {
  for_each = toset(var.target_project_ids)

  project = each.value
  role    = google_project_iam_custom_role.storage_reader_role[each.key].id
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant Cloud Asset Inventory permissions on each target project
resource "google_project_iam_member" "upwind_management_sa_asset_viewer_role_member" {
  for_each = toset(var.target_project_ids)

  project = each.value
  role    = "roles/cloudasset.viewer"
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Required for DSPM functionality when cloudscanners are enabled
resource "google_project_iam_member" "cloudscanner_sa_storage_reader_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.storage_reader_role[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}
