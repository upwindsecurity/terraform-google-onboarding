# Custom role for IAM management with minimal required permissions
# Read-only IAM role for service account and role management
resource "google_organization_iam_custom_role" "upwind_management_sa_iam_read_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerIamReadRole_${local.resource_suffix_underscore}"
  title       = "upwind-mgmt-${local.resource_suffix_hyphen}-iam-read"
  description = "Read permissions for IAM management"
  permissions = module.iam.iam_read_role_permissions
}

# Custom role for snapshot management
resource "google_organization_iam_custom_role" "snapshot_reader" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerSnapshotReader_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Reader"
  description = "Read-only access to all compute resources for discovery"

  permissions = module.iam.snapshot_reader_permissions
}

resource "google_organization_iam_custom_role" "snapshot_creator" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerSnapshotCreator_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Creator"
  description = "Snapshot Create operations in any project"

  permissions = module.iam.snapshot_creator_permissions
}

resource "google_organization_iam_custom_role" "snapshot_deleter" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerSnapshotDeleter_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Deleter"
  description = "Delete operations restricted to Upwind-managed resources"

  permissions = module.iam.snapshot_deleter_permissions
}

# Grants access to storage bucket objects for DSPM functionality
resource "google_organization_iam_custom_role" "storage_object_reader" {
  count       = var.enable_cloudscanners && var.enable_dspm_scanning ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerStorageObjectReader_${local.resource_suffix_underscore}"
  title       = "Upwind Storage Object Reader"
  description = "Read-only access to storage objects"

  permissions = module.iam.storage_object_reader_permissions
}

# Required for Cloud Run scanning
resource "google_organization_iam_custom_role" "cloudscanner_cloud_run_role" {
  count   = var.enable_cloudscanners ? 1 : 0
  org_id  = data.google_organization.org.org_id
  role_id = "CloudScannerCloudRunRole_${local.resource_suffix_underscore}"
  title   = "upwind-role-${local.resource_suffix_hyphen}-cloud-run"
  permissions = module.iam.cloud_run_permissions
}


# Assign the read IAM role to the management service account (unconditional)
resource "google_organization_iam_member" "upwind_management_sa_iam_read_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.upwind_management_sa_iam_read_role[0].id
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Required to get instances across projects
resource "google_organization_iam_member" "upwind_cloudscanner_sa_compute_viewer_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = "roles/compute.viewer"
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Required to get disks and snapshots of target instances across projects
resource "google_organization_iam_binding" "upwind_cloudscanner_snapshot_reader_role_binding" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.snapshot_reader[0].name
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]
}

# Required for CloudScanner to create snapshots in any project
# Snapshot creation happens in the same project as the source disk
# so we need to allow snapshot creation in all projects
resource "google_organization_iam_binding" "cloudscanner_snapshot_creator_role_binding" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.snapshot_creator[0].name
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]

  condition {
    # snapshot creation is tested against project. Allow snapshot creation in all projects
    title      = "Upwind Cloud Scanner Snapshot Creator"
    expression = ""
  }
}

# Limit snapshot deletion permissions to Upwind-generated snapshots only
resource "google_organization_iam_binding" "cloudscanner_scaler_snapshot_deleter_role_binding" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.snapshot_deleter[0].name
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]
  condition {
    # Limit storage deletion permissions to snapshots we generate only
    title      = "Upwind Cloud Scanner Snapshot Writer"
    expression = "resource.name.extract('snapshots/{snapshot}').startsWith('snap-')"
  }
}

resource "google_organization_iam_binding" "cloudscanner_sa_storage_object_reader_role_binding" {
  count  = var.enable_cloudscanners  && var.enable_dspm_scanning ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.storage_object_reader[0].name
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
  ]
}

resource "google_organization_iam_member" "cloudscanner_cloud_run_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.cloudscanner_cloud_run_role[0].name
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}
