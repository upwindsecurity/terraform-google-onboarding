### Project-Scoped Organization-Level CloudScanner Roles
# These replace organization-level custom roles and bindings

### Custom Roles created in each target project

# IAM read role for service account and role management (per project)
resource "google_project_iam_custom_role" "upwind_management_sa_iam_read_role" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project     = each.value
  role_id     = "CloudScannerIamReadRole_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-iam-read"
  description = "Read permissions for IAM management"
  permissions = module.iam.iam_read_role_permissions
}

# Snapshot reader role for compute resources discovery (per project)
resource "google_project_iam_custom_role" "snapshot_reader" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project     = each.value
  role_id     = "CloudScannerSnapshotReader_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-snapshot-reader"
  description = "Read-only access to all compute resources for discovery"

  permissions = module.iam.snapshot_reader_permissions
}

# Snapshot creator role (per project)
resource "google_project_iam_custom_role" "snapshot_creator" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project     = each.value
  role_id     = "CloudScannerSnapshotCreator_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-snapshot-creator"
  description = "Snapshot Create operations in project"

  permissions = module.iam.snapshot_creator_permissions
}

# Snapshot deleter role (per project)
resource "google_project_iam_custom_role" "snapshot_deleter" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project     = each.value
  role_id     = "CloudScannerSnapshotDeleter_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-snapshot-deleter"
  description = "Delete operations restricted to Upwind-managed resources"

  permissions = module.iam.snapshot_deleter_permissions
}

# Storage object reader role (per project)
resource "google_project_iam_custom_role" "storage_object_reader" {
  for_each = var.enable_cloudscanners && var.enable_dspm ? toset(var.target_project_ids) : toset([])

  project     = each.value
  role_id     = "CloudScannerStorageObjectReader_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-storage-object-reader"
  description = "Read-only access to storage objects"

  permissions = module.iam.storage_object_reader_permissions
}

# Cloud Run scanning role (per project)
resource "google_project_iam_custom_role" "cloudscanner_cloud_run_role" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project     = each.value
  role_id     = "CloudScannerCloudRunRole_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-cloud-run"
  description = "CloudScanner permissions for Cloud Run scanning"
  permissions = module.iam.cloud_run_permissions
}


### Project-Level IAM Bindings

# Assign IAM read role to management service account on each target project
resource "google_project_iam_member" "upwind_management_sa_iam_read_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.upwind_management_sa_iam_read_role[each.key].id
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Grant compute viewer role to CloudScanner SA on each target project
resource "google_project_iam_member" "upwind_cloudscanner_sa_compute_viewer_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Grant snapshot reader role to CloudScanner and Scaler SAs on each target project
# Required to get disks and snapshots of target instances across projects
# CloudScanner SA permissions
resource "google_project_iam_member" "cloudscanner_snapshot_reader" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.snapshot_reader[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Scaler SA permissions
resource "google_project_iam_member" "scaler_snapshot_reader" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.snapshot_reader[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
}

# Grant snapshot creator role to CloudScanner and Scaler SAs on each target project
# Required for CloudScanner to create snapshots in any project
# Snapshot creation happens in the same project as the source disk
# so we need to allow snapshot creation in all projects
# CloudScanner SA snapshot creator permissions
resource "google_project_iam_member" "cloudscanner_snapshot_creator_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.snapshot_creator[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Scaler SA snapshot creator permissions
resource "google_project_iam_member" "scaler_snapshot_creator_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.snapshot_creator[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
}

# CloudScanner SA snapshot deleter permissions with condition
resource "google_project_iam_member" "cloudscanner_snapshot_deleter_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.snapshot_deleter[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"

  condition {
    # Limit deletion permissions to snapshots we generate only
    title      = "Upwind Cloud Scanner Snapshot Writer"
    expression = "resource.name.extract('snapshots/{snapshot}').startsWith('snap-')"
  }
}

# Scaler SA snapshot deleter permissions with condition
resource "google_project_iam_member" "scaler_snapshot_deleter_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.snapshot_deleter[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"

  condition {
    # Limit deletion permissions to snapshots we generate only
    title      = "Upwind Cloud Scanner Snapshot Writer"
    expression = "resource.name.extract('snapshots/{snapshot}').startsWith('snap-')"
  }
}

# Grant storage object reader role to CloudScanner SA on each target project
resource "google_project_iam_member" "cloudscanner_sa_storage_object_reader_role_member" {
  for_each = var.enable_cloudscanners && var.enable_dspm ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.storage_object_reader[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Grant Cloud Run role to CloudScanner SA on each target project
resource "google_project_iam_member" "cloudscanner_cloud_run_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.cloudscanner_cloud_run_role[each.key].id
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}
