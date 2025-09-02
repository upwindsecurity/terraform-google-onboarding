
moved {
  from = google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role
  to   = module.iam.google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_basic_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_basic_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_scaler_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_scaler_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_secret_access_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_secret_access_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role
}

moved {
  from = google_project_iam_custom_role.disk_writer
  to   = module.iam.google_project_iam_custom_role.disk_writer
}

moved {
  from = google_project_iam_custom_role.compute_service_agent_minimal
  to   = module.iam.google_project_iam_custom_role.compute_service_agent_minimal
}

### IAM Members

# Required for the management service account to deploy the CloudScanner resources
resource "google_project_iam_member" "upwind_management_sa_cloudscanner_deployment_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role.name
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Custom role for IAM management with minimal required permissions
# Read-only IAM role for service account and role management
resource "google_organization_iam_custom_role" "upwind_management_sa_iam_read_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerIamReadRole_${local.resource_suffix_underscore}"
  title       = "upwind-mgmt-${local.resource_suffix_hyphen}-iam-read"
  description = "Read permissions for IAM management"
  permissions = [
    # Service account and key read permissions
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "iam.serviceAccountKeys.get",
    "iam.serviceAccountKeys.list",

    # Role read permissions
    "resourcemanager.projects.getIamPolicy",
    "iam.roles.get",
    "iam.roles.list"
  ]
}

# Custom role for snapshot management
resource "google_organization_iam_custom_role" "snapshot_reader" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerSnapshotReader_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Reader"
  description = "Read-only access to all compute resources for discovery"

  permissions = [
    # Read-only permissions for discovery
    "compute.disks.get",
    "compute.disks.list",
    "compute.disks.createSnapshot", # This cannot be restricted, we cannot know the name of the target disk
    "compute.snapshots.get",
    "compute.snapshots.list",
    "compute.instances.get",
    "compute.instances.list",
    "compute.diskTypes.get",
    "compute.diskTypes.list",
    "compute.projects.get",
    "resourcemanager.projects.get",
    "compute.zoneOperations.get",
    "compute.globalOperations.get",
    "compute.regionOperations.get",
    "iam.serviceAccounts.getAccessToken",
  ]
}

resource "google_organization_iam_custom_role" "snapshot_creator" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerSnapshotCreator_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Creator"
  description = "Snapshot Create operations in any project"

  permissions = [
    "compute.snapshots.create",
    "compute.snapshots.setLabels",
    "compute.snapshots.useReadOnly"
  ]
}

resource "google_organization_iam_custom_role" "snapshot_deleter" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerSnapshotDeleter_${local.resource_suffix_underscore}"
  title       = "Upwind Snapshot Deleter"
  description = "Delete operations restricted to Upwind-managed resources"

  permissions = [
    # Write operations - restricted by IAM condition
    "compute.snapshots.delete",
  ]
}

# Grants access to storage bucket objects for DSPM functionality
resource "google_organization_iam_custom_role" "storage_object_reader" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerStorageObjectReader_${local.resource_suffix_underscore}"
  title       = "Upwind Storage Object Reader"
  description = "Read-only access to storage objects"

  permissions = [
    "storage.objects.get",
  ]
}

# Assign the read IAM role to the management service account (unconditional)
resource "google_organization_iam_member" "upwind_management_sa_iam_read_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.upwind_management_sa_iam_read_role[0].id
  member = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Allow scaler to impersonate scanner SA AND allow Compute Engine service to use scanner SA for VM operations
resource "google_service_account_iam_binding" "scaler_and_compute_can_use_cloudscanner" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = module.iam.cloudscanner_sa.id
  role               = "roles/iam.serviceAccountUser"
  members = [
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}",
    "serviceAccount:${data.google_project.current.number}@cloudservices.gserviceaccount.com"
  ]
}

resource "google_project_iam_member" "cloudscanner_sa_basic_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.cloudscanner_basic_role.name
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"
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
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.storage_object_reader[0].name
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
  ]
}

# Limit disk creation/deletion permissions to Upwind named disks only in orchestrator project
resource "google_project_iam_binding" "cloudscanner_disk_writer_role_binding" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.disk_writer.name
  members = [
    "serviceAccount:${module.iam.cloudscanner_sa.email}",
    "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
  ]
  condition {
    # Limit disk creation/deletion permissions to Upwind named disks only in orchestrator project
    title      = "Upwind Cloud Scanner Disk Writer"
    expression = "resource.name.extract('disks/{disk}').startsWith('vol-snap-')"
  }
}

# Required for Cloud Run scanning
resource "google_organization_iam_custom_role" "cloudscanner_cloud_run_role" {
  count   = var.enable_cloudscanners ? 1 : 0
  org_id  = data.google_organization.org.org_id
  role_id = "CloudScannerCloudRunRole_${local.resource_suffix_underscore}"
  title   = "upwind-role-${local.resource_suffix_hyphen}-cloud-run"
  permissions = [
    "artifactregistry.repositories.downloadArtifacts",
    "artifactregistry.dockerimages.get",
  ]
}

resource "google_organization_iam_member" "cloudscanner_cloud_run_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.cloudscanner_cloud_run_role[0].name
  member = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

resource "google_project_iam_member" "cloudscanner_sa_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.cloudscanner_scaler_role.name
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}" # CloudScanner VMs
}

resource "google_project_iam_member" "cloudscanner_scaler_sa_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.cloudscanner_scaler_role.name
  member  = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}" # CloudScanner Scaler (Cloud Run)"
}

# Only grant access to the Upwind Client ID and Secret
resource "google_project_iam_member" "upwind_management_sa_secret_access_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.cloudscanner_secret_access_role.name
  member  = "serviceAccount:${module.iam.upwind_management_sa.email}"

  condition {
    # Limit secret access permissions to all versions of Upwind CloudScanner credentials only
    title      = "Upwind CloudScanner Credentials Access"
    expression = "resource.name.startsWith('${google_secret_manager_secret.scanner_client_id[0].name}') || resource.name.startsWith('${google_secret_manager_secret.scanner_client_secret[0].name}')"
  }
}

# Only grant access to the Upwind Scanner Client ID and Secret
resource "google_project_iam_member" "cloudscanner_secret_access_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.cloudscanner_secret_access_role.name
  member  = "serviceAccount:${module.iam.cloudscanner_sa.email}"

  condition {
    # Limit secret access permissions to all versions of Upwind CloudScanner credentials only
    title      = "Upwind CloudScanner Credentials Access"
    expression = "resource.name.startsWith('${google_secret_manager_secret.scanner_client_id[0].name}') || resource.name.startsWith('${google_secret_manager_secret.scanner_client_secret[0].name}')"
  }
}

resource "google_project_iam_member" "cloudscanner_scaler_secret_access_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.cloudscanner_secret_access_role.name
  member  = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}" # CloudScanner Scaler (Cloud Run)"

  condition {
    # Limit secret access permissions to all versions of Upwind CloudScanner credentials only
    title      = "Upwind CloudScanner Credentials Access"
    expression = "resource.name.startsWith('${google_secret_manager_secret.scanner_client_id[0].name}') || resource.name.startsWith('${google_secret_manager_secret.scanner_client_secret[0].name}')"
  }
}

resource "google_project_iam_member" "cloudscanner_scaler_sa_run_invoker" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project

  # This predefined role contains 'run.jobs.run' and 'run.routes.invoke' permissions only so no need for custom role
  role   = "roles/run.invoker"
  member = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"

  condition {
    # Limit invocation permissions to the scaler function only
    title = "Upwind CloudScanner Function Execution"

    # Currently it does not appear to be possible to set conditions such that the service account can invoke the scheduled job.
    # As per https://cloud.google.com/run/docs/reference/iam/roles, the run.invoker role is the minimal set of roles required for a
    # Service Account to invoke a Cloud Run Job
    expression = ""
  }
}

resource "google_project_iam_member" "cloudscanner_instance_template_mgmt_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role.name
  member  = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}" # Cloud Scanner Scaler (Cloud Run)"

  condition {
    # Limit the use of the roles to cloudscanner only instance templates
    title      = "Upwind Cloud Scanner Instance Template Management"
    expression = "resource.name.extract('instanceTemplates/{template}').startsWith('upwind-tpl-')"
  }
}

resource "google_project_iam_member" "cloudscanner_instance_template_test_creation_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role.name
  member  = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}" # Cloud Scanner Scaler (Cloud Run)"

  condition {
    # Upgrading templates performs a 'dry-run' of instance creation, limit to resources using this pattern
    title      = "Upwind Cloud Scanner Instance Template Upgrade"
    expression = "resource.name.endsWith('-0000')"
  }
}

# Allows the CloudScanner to impersonate the CloudScanner Scaler Service Account
resource "google_service_account_iam_member" "cloudscanner_impersonate_scaler" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = module.iam.cloudscanner_scaler_sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Allows the Google Cloud Run service agent to manage Cloud Run jobs
resource "google_project_iam_member" "cloudrun_service_agent" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = "roles/run.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.current.number}@serverless-robot-prod.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "compute_service_agent_minimal" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = module.iam.google_project_iam_custom_role.compute_service_agent_minimal.name
  member  = "serviceAccount:${data.google_project.current.number}@cloudservices.gserviceaccount.com"
}

# Allow management SA to create tokens for scanner SA
resource "google_service_account_iam_member" "management_can_impersonate_scanner" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = module.iam.cloudscanner_sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Allow management SA to create tokens for scaler SA
resource "google_service_account_iam_member" "management_can_impersonate_scaler" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = module.iam.cloudscanner_scaler_sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${module.iam.upwind_management_sa.email}"
}

# Allow scanner SA to create tokens for scaler SA
resource "google_service_account_iam_member" "scanner_can_impersonate_scaler" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = module.iam.cloudscanner_scaler_sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${module.iam.cloudscanner_sa.email}"
}

# Allow scaler SA to create tokens for scanner SA
resource "google_service_account_iam_member" "scaler_can_impersonate_scanner" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = module.iam.cloudscanner_sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${module.iam.cloudscanner_scaler_sa.email}"
}

# Allow Cloud Scheduler to impersonate scaler SA
resource "google_service_account_iam_member" "cloudscheduler_can_impersonate_scaler" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = module.iam.cloudscanner_scaler_sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:service-${data.google_project.current.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}
