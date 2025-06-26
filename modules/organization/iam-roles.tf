### IAM Roles
# Nothing custom required for non-cloudscanner operations

### IAM Members

# Give the management service account the basic viewer role
# We will grant more permissions if Cloud Scanners are enabled
resource "google_organization_iam_member" "upwind_management_sa_org_viewer_role_member" {
  org_id = data.google_organization.org.org_id
  role   = "roles/viewer"
  member = "serviceAccount:${google_service_account.upwind_management_sa.email}"
}

# Specifically grant permissions to read storage objects
# This is a reduction from the storageAdmin role to grant read only access
resource "google_organization_iam_custom_role" "upwind_management_sa_storage_reader_role" {
  org_id = data.google_organization.org.org_id
  role_id = "UpwindStorageReader_${var.resource_suffix}"
  title   = "Upwind Management SA Storage Reader"
  description = "Custom role for Upwind Management Service Account to read storage buckets."

  permissions = [
    "storage.buckets.get",
    "storage.buckets.getIamPolicy",
    "storage.buckets.getIpFilter",
    "storage.buckets.list",
    "storage.buckets.listEffectiveTags",
    "storage.buckets.listTagBindings",
    "storage.bucketOperations.get",
    "storage.bucketOperations.list",
    "storage.folders.get",
    "storage.folders.list",
    "storage.managedFolders.get",
    "storage.managedFolders.getIamPolicy",
    "storage.managedFolders.list",
    "storage.objects.get",
    "storage.objects.getIamPolicy",
    "storage.objects.list",
  ]
}

resource "google_organization_iam_member" "upwind_management_sa_storage_reader_role_member" {
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.upwind_management_sa_storage_reader_role.id
  member = "serviceAccount:${google_service_account.upwind_management_sa.email}"
}