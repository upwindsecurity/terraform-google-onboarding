### Custom Roles

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

### IAM Members

# Give the management service account the basic viewer role
# We will grant more permissions if Cloud Scanners are enabled
resource "google_organization_iam_member" "upwind_management_sa_org_viewer_role_member" {
  org_id = data.google_organization.org.org_id
  role   = "roles/viewer"
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

resource "google_organization_iam_member" "upwind_management_sa_folder_viewer_role_member" {
  org_id = data.google_organization.org.org_id
  role   = "roles/resourcemanager.folderViewer"
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Assign the operations role to the management service account (unconditional)
resource "google_organization_iam_member" "upwind_management_sa_operations_role_member" {
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.upwind_management_sa_operations_role.id
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant Cloud Asset Inventory permissions for customer-asset-collector across all projects
resource "google_organization_iam_member" "upwind_management_sa_asset_viewer_role_member" {
  org_id = data.google_organization.org.org_id
  role   = "roles/cloudasset.viewer"
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}
