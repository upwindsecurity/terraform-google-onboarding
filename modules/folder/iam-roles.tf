### Folder-Level IAM for Multi-Project Access via Folder Inheritance

# Custom role for Storage reader and IAM management with minimal required permissions
resource "google_organization_iam_custom_role" "upwind_management_sa_operations_role" {
  org_id      = data.google_organization.org.org_id
  role_id     = "UpwindOperations_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-operations"
  description = "Generic operations role for Upwind"
  permissions = concat(
    module.iam.storage_read_permissions,
    var.enable_cloudscanners ? module.iam.iam_read_role_permissions : [],
  )
}

# Give the management service account the basic viewer role on each target folder
resource "google_folder_iam_member" "upwind_management_sa_folder_viewer_role_member" {
  for_each = toset(var.target_folder_ids)

  folder = each.value
  role   = "roles/viewer"
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant custom storage reader role to management SA on each target folder
resource "google_folder_iam_member" "upwind_management_sa_operations_role_member" {
  for_each = toset(var.target_folder_ids)

  folder = each.value
  role   = google_organization_iam_custom_role.upwind_management_sa_operations_role.id
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant Cloud Asset Inventory permissions on each target folder
resource "google_folder_iam_member" "upwind_management_sa_asset_viewer_role_member" {
  for_each = toset(var.target_folder_ids)

  folder = each.value
  role   = "roles/cloudasset.viewer"
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}
