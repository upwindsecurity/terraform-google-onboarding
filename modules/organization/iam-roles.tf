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

# Specifically grant permissions to read storage objects
# This is a reduction from the storageAdmin role to grant read only access
resource "google_organization_iam_custom_role" "storage_reader_role" {
  org_id      = data.google_organization.org.org_id
  role_id     = "UpwindStorageReader_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-storage-reader"
  description = "Custom role for Upwind Management Service Account to read storage buckets."

  permissions = module.iam.storage_read_permissions
}

resource "google_organization_iam_member" "upwind_management_sa_storage_reader_role_member" {
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.storage_reader_role.id
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant Cloud Asset Inventory permissions for customer-asset-collector across all projects
resource "google_organization_iam_member" "upwind_management_sa_asset_viewer_role_member" {
  org_id = data.google_organization.org.org_id
  role   = "roles/cloudasset.viewer"
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Required for DSPM functionality when cloudscanners are enabled
resource "google_organization_iam_member" "cloudscanner_sa_storage_reader_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.storage_reader_role.id
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}
