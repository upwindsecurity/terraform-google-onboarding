### Folder-Level CloudScanner Roles

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

# Snapshot reader role for compute resources discovery (organization-wide)
resource "google_organization_iam_custom_role" "upwind_cloudscanner_snapshot_deleter_role" {
  count = var.enable_cloudscanners ? 1 : 0

  org_id      = var.gcp_organization_id
  role_id     = "CloudScannerSnapshotDeleter_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-snapshot-deleter"
  description = "Delete operations restricted to Upwind-managed resources"

  permissions = module.iam.snapshot_deleter_permissions
}

### Folder-Level IAM Bindings (inherited by all projects in folder)

# Grant compute viewer role to CloudScanner SA on each target folder
resource "google_folder_iam_member" "upwind_cloudscanner_sa_compute_viewer_role_member" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = "roles/compute.viewer"
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Grant snapshot reader role to CloudScanner and Scaler SAs on each target folder
resource "google_folder_iam_binding" "upwind_cloudscanner_operations_role_binding" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.cloudscanner_operations_role[0].id
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]
}

# Grant snapshot deleter role with conditions
resource "google_folder_iam_binding" "upwind_cloudscanner_snapshot_deleter_role_binding" {
  for_each = var.enable_cloudscanners ? toset(var.target_folder_ids) : toset([])

  folder = each.value
  role   = google_organization_iam_custom_role.cloudscanner_snapshot_deleter_role[0].id
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]

  condition {
    title      = "Upwind Cloud Scanner Snapshot Deleter"
    expression = "resource.name.extract('snapshots/{snapshot}').startsWith('snap-')"
  }
}
