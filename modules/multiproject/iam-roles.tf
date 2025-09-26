### Project-Scoped IAM for Multi-Project Access

### Custom Roles (created in each target project)

# Custom role for Storage reader and IAM management with minimal required permissions
resource "google_project_iam_custom_role" "upwind_management_sa_operations_role" {
  for_each = toset(var.target_project_ids)

  project     = each.value
  role_id     = "UpwindOperations_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-operations"
  description = "Generic operations role for Upwind"
  permissions = concat(
    module.iam.storage_read_permissions,
    var.enable_cloudscanners ? module.iam.iam_read_role_permissions : [],
  )
}

### IAM Members

# Give the management service account the basic viewer role on each target project
# We will grant more permissions if Cloud Scanners are enabled
resource "google_project_iam_member" "upwind_management_sa_project_viewer_role_member" {
  for_each = toset(var.target_project_ids)

  project = each.value
  role    = "roles/viewer"
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant custom operations role to management SA on each target project
resource "google_project_iam_member" "upwind_management_sa_operations_role_member" {
  for_each = toset(var.target_project_ids)

  project = each.value
  role    = google_project_iam_custom_role.upwind_management_sa_operations_role[each.key].id
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant Cloud Asset Inventory permissions on each target project
resource "google_project_iam_member" "upwind_management_sa_asset_viewer_role_member" {
  for_each = toset(var.target_project_ids)

  project = each.value
  role    = "roles/cloudasset.viewer"
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"
}
