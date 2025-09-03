### Folder-Level CloudScanner Roles
# These provide permissions that inherit to all projects under the folder

### Custom Roles created at folder level for inheritance

# IAM read role for service account and role management (organization-wide)
resource "google_organization_iam_custom_role" "upwind_management_sa_iam_read_role" {
  count = var.enable_cloudscanners ? 1 : 0

  org_id      = var.gcp_organization_id
  role_id     = "CloudScannerFolderIamRead_${local.resource_suffix_underscore}"
  title       = "upwind-mgmt-${local.resource_suffix_hyphen}-iam-read-folder"
  description = "Read permissions for IAM management across folders"
  permissions = module.iam.iam_read_role_permissions
}

# Snapshot reader role for compute resources discovery (organization-wide)
resource "google_organization_iam_custom_role" "snapshot_reader" {
  count = var.enable_cloudscanners ? 1 : 0

  org_id      = var.gcp_organization_id
  role_id     = "CloudScannerFolderSnapshotReader_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Reader (Folder)"
  description = "Read-only access to all compute resources for discovery across folders"

  permissions = module.iam.snapshot_reader_permissions
}

# Snapshot creator role (organization-wide)
resource "google_organization_iam_custom_role" "snapshot_creator" {
  count = var.enable_cloudscanners ? 1 : 0

  org_id      = var.gcp_organization_id
  role_id     = "CloudScannerFolderSnapshotCreator_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Creator (Folder)"
  description = "Snapshot Create operations across folder projects"

  permissions = module.iam.snapshot_creator_permissions
}

# Snapshot deleter role (organization-wide)
resource "google_organization_iam_custom_role" "snapshot_deleter" {
  count = var.enable_cloudscanners ? 1 : 0

  org_id      = var.gcp_organization_id
  role_id     = "CloudScannerFolderSnapshotDeleter_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Deleter (Folder)"
  description = "Delete operations restricted to Upwind-managed resources across folders"

  permissions = module.iam.snapshot_deleter_permissions
}

# Storage object reader role (organization-wide)
resource "google_organization_iam_custom_role" "storage_object_reader" {
  count = var.enable_cloudscanners && var.enable_dspm ? 1 : 0

  org_id      = var.gcp_organization_id
  role_id     = "CloudScannerFolderStorageObjectReader_${local.resource_suffix_underscore}"
  title       = "Upwind Storage Object Reader (Folder)"
  description = "Read-only access to storage objects across folders"

  permissions = module.iam.storage_object_reader_permissions
}

# Cloud Run scanning role (organization-wide)
resource "google_organization_iam_custom_role" "cloudscanner_cloud_run_role" {
  count = var.enable_cloudscanners ? 1 : 0

  org_id      = var.gcp_organization_id
  role_id     = "CloudScannerFolderCloudRun_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-cloud-run-folder"
  description = "CloudScanner permissions for Cloud Run scanning across folders"
  permissions = module.iam.cloud_run_permissions
}

### Folder-Level IAM Bindings (inherited by all projects in folder)

# Assign IAM read role to management service account on each target folder
resource "google_folder_iam_member" "upwind_management_sa_iam_read_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.upwind_management_sa_iam_read_role[0].id
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant compute viewer role to CloudScanner SA on each target folder
resource "google_folder_iam_member" "upwind_cloudscanner_sa_compute_viewer_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = "roles/compute.viewer"
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Grant snapshot reader role to CloudScanner and Scaler SAs on each target folder
resource "google_folder_iam_member" "cloudscanner_snapshot_reader" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.snapshot_reader[0].id
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

resource "google_folder_iam_member" "scaler_snapshot_reader" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.snapshot_reader[0].id
  member = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
}

# Grant snapshot creator role to CloudScanner and Scaler SAs on each target folder
resource "google_folder_iam_member" "cloudscanner_snapshot_creator_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.snapshot_creator[0].id
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

resource "google_folder_iam_member" "scaler_snapshot_creator_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.snapshot_creator[0].id
  member = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
}

# Grant snapshot deleter role with conditions
resource "google_folder_iam_member" "cloudscanner_snapshot_deleter_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.snapshot_deleter[0].id
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"

  condition {
    title      = "Upwind Cloud Scanner Snapshot Writer"
    expression = "resource.name.extract('snapshots/{snapshot}').startsWith('snap-')"
  }
}

resource "google_folder_iam_member" "scaler_snapshot_deleter_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.snapshot_deleter[0].id
  member = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"

  condition {
    title      = "Upwind Cloud Scanner Snapshot Writer"
    expression = "resource.name.extract('snapshots/{snapshot}').startsWith('snap-')"
  }
}

# Grant storage object reader role to CloudScanner SA on each target folder
resource "google_folder_iam_member" "cloudscanner_sa_storage_object_reader_role_member" {
  for_each = var.enable_cloudscanners && var.enable_dspm ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.storage_object_reader[0].id
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Grant Cloud Run role to CloudScanner SA on each target folder
resource "google_folder_iam_member" "cloudscanner_cloud_run_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.cloudscanner_cloud_run_role[0].id
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}
