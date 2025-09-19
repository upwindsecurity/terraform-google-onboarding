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

# Snapshot deleter role separate to limit delete permissions to named resources
resource "google_organization_iam_custom_role" "upwind_cloudscanner_snapshot_deleter_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerSnapshotDeleter_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-snapshot-deleter"
  description = "Delete operations restricted to Upwind-managed resources"

  permissions = module.iam.snapshot_deleter_permissions
}

# Required to get instances across projects
resource "google_organization_iam_member" "upwind_cloudscanner_sa_compute_viewer_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = "roles/compute.viewer"
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Required to get disks and snapshots of target instances across projects
resource "google_organization_iam_binding" "upwind_cloudscanner_operations_role_binding" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.cloudscanner_operations_role[0].name
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]
}

# Limit snapshot deletion permissions to Upwind-generated snapshots only
resource "google_organization_iam_binding" "upwind_cloudscanner_snapshot_deleter_role_binding" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.cloudscanner_snapshot_deleter_role[0].name
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]
  condition {
    # Limit storage deletion permissions to snapshots we generate only
    title      = "Upwind Cloud Scanner Snapshot Deleter"
    expression = "resource.name.extract('snapshots/{snapshot}').startsWith('snap-')"
  }
}
