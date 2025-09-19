### Project-Scoped Organization-Level CloudScanner Roles
# These replace organization-level custom roles and bindings

### Custom Roles created in each target project

# Generic operations role for CloudScanner
resource "google_organization_iam_custom_role" "upwind_cloudscanner_operations_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerOperationsRole_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-cloudscanner-operations"
  description = "Generic Operations role for CloudScanner"
  permissions = concat(
    module.iam.iam_read_role_permissions,
    module.iam.snapshot_reader_permissions,
    module.iam.snapshot_creator_permissions,
    module.iam.cloud_run_permissions,
    module.iam.storage_read_permissions,
    var.enable_dspm_scanning ? module.iam.storage_object_reader_permissions : [],
  )
}

# Snapshot deleter role (per project)
resource "google_project_iam_custom_role" "upwind_cloudscanner_snapshot_deleter_role" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project     = each.value
  role_id     = "CloudScannerSnapshotDeleter_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-snapshot-deleter"
  description = "Delete operations restricted to Upwind-managed resources"

  permissions = module.iam.snapshot_deleter_permissions
}

### Project-Level IAM Bindings

# Grant compute viewer role to CloudScanner SA on each target project
resource "google_project_iam_member" "upwind_cloudscanner_sa_compute_viewer_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Required to get disks and snapshots of target instances across projects
resource "google_project_iam_binding" "upwind_cloudscanner_operations_role_binding" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.cloudscanner_operations_role[each.key].id
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]
}

# Scaler SA permissions
resource "google_project_iam_binding" "upwind_cloudscanner_snapshot_deleter_role_binding" {
  for_each = var.enable_cloudscanners ? toset(var.target_project_ids) : toset([])

  project = each.value
  role    = google_project_iam_custom_role.cloudscanner_snapshot_deleter_role[each.key].id
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]
  condition {
    # Limit deletion permissions to snapshots we generate only
    title      = "Upwind Cloud Scanner Snapshot Deleter"
    expression = "resource.name.extract('snapshots/{snapshot}').startsWith('snap-')"
  }
}
