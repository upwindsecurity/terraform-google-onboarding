### Cloudscanner Specific IAM Roles

# Used by the management service account to deploy the cloudscanner resources
resource "google_project_iam_custom_role" "upwind_management_sa_cloudscanner_deployment_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  project     = local.project
  role_id     = "CloudScannerDeploymentRole_${local.resource_suffix_underscore}"
  title       = "upwind-mgmt-${local.resource_suffix_hyphen}-cs-deployment"
  description = "Minimum permissions required to deploy the Cloudscanner resources"
  permissions = [
    # Compute Engine resource creation permissions
    "compute.instanceTemplates.create",
    "compute.instanceTemplates.get",
    "compute.instanceTemplates.delete",
    "compute.instanceGroupManagers.create",
    "compute.instanceGroupManagers.get",
    "compute.instanceGroupManagers.delete",
    "compute.instanceGroups.delete",
    "compute.instances.create",
    "compute.instances.get",
    "compute.instances.delete",
    "compute.instances.setMetadata",
    "compute.instances.setTags",
    "compute.instances.setLabels",
    "compute.disks.create",
    "compute.disks.get",
    "compute.disks.delete",

    # Networking resource creation permissions
    "compute.networks.create",
    "compute.networks.get",
    "compute.networks.updatePolicy",
    "compute.networks.delete",
    "compute.subnetworks.create",
    "compute.subnetworks.get",
    "compute.subnetworks.use",
    "compute.subnetworks.delete",
    "compute.routers.create",
    "compute.routers.get",
    "compute.routers.update", # For creating NAT on the router
    "compute.routers.delete",
    "compute.firewalls.create",
    "compute.firewalls.get",
    "compute.firewalls.delete",

    # Cloud Run creation permissions
    "run.jobs.create",
    "run.jobs.get",
    "run.jobs.delete",

    # Cloud Scheduler creation permissions
    "cloudscheduler.jobs.create",
    "cloudscheduler.jobs.get",
    "cloudscheduler.jobs.enable",
    "cloudscheduler.jobs.delete",

    # IAM permissions for setting up project bindings
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy",

    # Service Account reference permission
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.actAs", # Required to assign a service account to instances
    "iam.serviceAccounts.getIamPolicy",
    "iam.serviceAccounts.setIamPolicy",
    "iam.serviceAccounts.getAccessToken", # For service account token operations

    # Required for Terraform to check operation status
    "compute.regionOperations.get",

    # Required basic service usage
    "serviceusage.services.use"
  ]
}

# Used for basic cloudscanner operation
resource "google_project_iam_custom_role" "cloudscanner_basic_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  project     = local.project
  role_id     = "CloudScannerBasicRole_${local.resource_suffix_underscore}"
  title       = "upwind-cs-${local.resource_suffix_hyphen}-basic"
  description = "Minimum permissions required for Cloudscanner operations"

  permissions = [
    "compute.disks.create",
    "compute.disks.delete",
    "compute.disks.createSnapshot",
    "compute.disks.get",
    "compute.disks.list",
    "compute.disks.setLabels",
    "compute.disks.use",
    "compute.instances.attachDisk",
    "compute.instances.detachDisk",
    "compute.instances.get",
    "compute.instances.list",
    "compute.snapshots.create",
    "compute.snapshots.delete",
    "compute.snapshots.get",
    "compute.snapshots.setLabels",
    "compute.snapshots.useReadOnly",
    "compute.zoneOperations.get",
    "compute.globalOperations.get",
    "iam.serviceAccounts.actAs",
  ]
}

# Used by the CloudScanner Scaler to scale the CloudScanner Instance Groups
resource "google_project_iam_custom_role" "cloudscanner_scaler_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  role_id     = "CloudScannerScalerRole_${local.resource_suffix_underscore}"
  project     = local.project
  title       = "upwind-cs-${local.resource_suffix_hyphen}-scaler-base"
  description = "Minimum permissions required for Cloudscanner Scaler operations"

  permissions = [
    "compute.instanceGroups.get",  # Required to query the status of the instance group. Should be constrained to CS MIGs.
    "compute.instanceGroups.list", # Required to query the status of the instance group. Should be constrained to CS MIGs.
    "compute.instanceGroups.update",
    "compute.instanceGroupManagers.get",
    "compute.instanceGroupManagers.list",
    "compute.instanceGroupManagers.update", # Required to change the target size and remove instances from instance group. Should be constrained to CS MIGs.
    "compute.zoneOperations.get",           # The internal implementation queries the zone operations when removing disks.
    "compute.globalOperations.get",         # The internal implementation queries the global operations when removing snapshots.
    "compute.subnetworks.get",
    "compute.subnetworks.use",
  ]
}

# Ability to access the Upwind Client ID and Secret
resource "google_project_iam_custom_role" "cloudscanner_secret_access_role" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role_id = "CloudScannerSecretAccessRole_${local.resource_suffix_underscore}"
  title   = "upwind-cs-${local.resource_suffix_hyphen}-secret-access"

  permissions = [
    "secretmanager.versions.list",
    "secretmanager.versions.access",
  ]
}

# Grants permission for Cloudscanners to manage their own instance templates
resource "google_project_iam_custom_role" "cloudscanner_instance_template_mgmt_role" {
  count   = var.enable_cloudscanners ? 1 : 0
  role_id = "CloudScannerInstTmplMgmtRole_${local.resource_suffix_underscore}"
  project = local.project
  title   = "upwind-cs-${local.resource_suffix_hyphen}-instance-template-mgmt"

  permissions = [
    "compute.instanceTemplates.get",
    "compute.instanceTemplates.create",
    "compute.instanceTemplates.delete",
    "compute.instanceTemplates.useReadOnly",
  ]
}

# Grants permission for Cloudscanners to test create their own instance templates when updating the template
resource "google_project_iam_custom_role" "cloudscanner_instance_template_test_creation_role" {
  count   = var.enable_cloudscanners ? 1 : 0
  role_id = "CloudScannerInstTmplTestCreationRole_${local.resource_suffix_underscore}"
  project = local.project
  title   = "upwind-cs-${local.resource_suffix_hyphen}-instance-template-mgmt-test-creation"

  permissions = [
    "compute.instances.create",
    "compute.instances.setMetadata",
    "compute.instances.setLabels",
    "compute.disks.create",
  ]
}

### IAM Members

# Required for the management service account to deploy the CloudScanner resources
resource "google_project_iam_member" "upwind_management_sa_cloudscanner_deployment_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role[0].name
  member  = "serviceAccount:${google_service_account.upwind_management_sa.email}"
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

# Write IAM role for setting IAM policies
resource "google_organization_iam_custom_role" "upwind_management_sa_iam_write_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  org_id      = data.google_organization.org.org_id
  role_id     = "CloudScannerIamWriteRole_${local.resource_suffix_underscore}"
  title       = "upwind-mgmt-${local.resource_suffix_hyphen}-iam-write"
  description = "Write permissions for IAM management with conditions"
  permissions = [
    "resourcemanager.projects.setIamPolicy"
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
    "storage.buckets.getIamPolicy",
    "storage.buckets.get",
    "storage.buckets.list",
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

resource "google_project_iam_custom_role" "disk_writer" {
  count       = var.enable_cloudscanners ? 1 : 0
  project     = local.project
  role_id     = "CloudScannerDiskWriter_${local.resource_suffix_underscore}"
  title       = "Upwind Disk Writer"
  description = "Disk Write operations in orchestrator project"

  permissions = [
    "compute.disks.create",
    "compute.disks.delete",
    "compute.disks.setLabels",
    "compute.disks.use",
  ]
}

# Assign the read IAM role to the management service account (unconditional)
resource "google_organization_iam_member" "upwind_management_sa_iam_read_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.upwind_management_sa_iam_read_role[0].id
  member = "serviceAccount:${google_service_account.upwind_management_sa.email}"
}

# Assign the write IAM role to the management service account (conditional)
resource "google_organization_iam_member" "upwind_management_sa_iam_write_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.upwind_management_sa_iam_write_role[0].id
  member = "serviceAccount:${google_service_account.upwind_management_sa.email}"

  condition {
    title       = "CloudScanner Role Bindings Only"
    description = "Only allow binding of CloudScanner custom roles"
    expression  = "resource.name.startsWith('CloudScanner')"
  }
}

# Allow scaler to impersonate scanner SA AND allow Compute Engine service to use scanner SA for VM operations
resource "google_service_account_iam_binding" "scaler_and_compute_can_use_cloudscanner" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_sa[0].id
  role               = "roles/iam.serviceAccountUser"
  members = [
    "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}",
    "serviceAccount:${data.google_project.current.number}@cloudservices.gserviceaccount.com"
  ]
}

resource "google_project_iam_member" "cloudscanner_sa_basic_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_basic_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}"
}

# Required to get instances across projects
resource "google_organization_iam_member" "upwind_cloudscanner_sa_compute_viewer_role_member" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = "roles/compute.viewer"
  member = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}"
}

# Required to get disks and snapshots of target instances across projects
resource "google_organization_iam_binding" "upwind_cloudscanner_snapshot_reader_role_binding" {
  count  = var.enable_cloudscanners ? 1 : 0
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.snapshot_reader[0].name
  members = [
    "serviceAccount:${google_service_account.cloudscanner_sa[0].email}",
    "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}"
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
    "serviceAccount:${google_service_account.cloudscanner_sa[0].email}",
    "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}"
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
    "serviceAccount:${google_service_account.cloudscanner_sa[0].email}",
    "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}"
  ]
  condition {
    # Limit storage deletion permissions to snapshots we generate only
    title      = "Upwind Cloud Scanner Snapshot Writer"
    expression = "resource.name.extract('projects/.*/global/snapshots/(snap-.*)') != ''"
  }
}

# Limit disk creation/deletion permissions to Upwind named disks only in orchestrator project
resource "google_project_iam_binding" "cloudscanner_disk_writer_role_binding" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.disk_writer[0].name
  members = [
    "serviceAccount:${google_service_account.cloudscanner_sa[0].email}",
    "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}"
  ]
  condition {
    # Limit disk creation/deletion permissions to Upwind named disks only in orchestrator project
    title      = "Upwind Cloud Scanner Disk Writer"
    expression = "resource.name.extract('projects/${local.project}/zones/.*/disks/(vol-snap-.*)') != ''"
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
  member = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}"
}

resource "google_project_iam_member" "cloudscanner_sa_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_scaler_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}" # CloudScanner VMs
}

resource "google_project_iam_member" "cloudscanner_scaler_sa_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_scaler_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}" # CloudScanner Scaler (Cloud Run)"
}

# Only grant access to the Upwind Client ID and Secret
resource "google_project_iam_member" "upwind_management_sa_secret_access_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_secret_access_role[0].name
  member  = "serviceAccount:${google_service_account.upwind_management_sa.email}"

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
  role    = google_project_iam_custom_role.cloudscanner_secret_access_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}"

  condition {
    # Limit secret access permissions to all versions of Upwind CloudScanner credentials only
    title      = "Upwind CloudScanner Credentials Access"
    expression = "resource.name.startsWith('${google_secret_manager_secret.scanner_client_id[0].name}') || resource.name.startsWith('${google_secret_manager_secret.scanner_client_secret[0].name}')"
  }
}

resource "google_project_iam_member" "cloudscanner_scaler_secret_access_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_secret_access_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}" # CloudScanner Scaler (Cloud Run)"

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
  member = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}"

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
  role    = google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}" # Cloud Scanner Scaler (Cloud Run)"

  condition {
    # Limit the use of the roles to cloudscanner only instance templates
    title      = "Upwind Cloud Scanner Instance Template Management"
    expression = "resource.name.extract('projects/${local.project}/regions/.*/instanceTemplates/(upwind-tpl-.*)') != ''"
  }
}

resource "google_project_iam_member" "cloudscanner_instance_template_test_creation_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}" # Cloud Scanner Scaler (Cloud Run)"

  condition {
    # Upgrading templates performs a 'dry-run' of instance creation, limit to resources using this pattern
    title      = "Upwind Cloud Scanner Instance Template Upgrade"
    expression = "resource.name.endsWith('-0000')"
  }
}

# Allows the CloudScanner to impersonate the CloudScanner Scaler Service Account
resource "google_service_account_iam_member" "cloudscanner_impersonate_scaler" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_scaler_sa[0].id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}"
}

# Allows the Google Cloud Run service agent to manage Cloud Run jobs
resource "google_project_iam_member" "cloudrun_service_agent" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = "roles/run.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.current.number}@serverless-robot-prod.iam.gserviceaccount.com"
}

# Required when scaling up the Instance Group as the Compute Engine service agent
# is the entity that performs the scaling operations
resource "google_project_iam_custom_role" "compute_service_agent_minimal" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role_id = "ComputeServiceAgentMinimal_${local.resource_suffix_underscore}"
  title   = "Minimal Compute Service Agent Permissions"

  permissions = [
    "compute.disks.create",
    "compute.disks.use",
    "compute.instances.create",
    "compute.instances.use",
    "compute.instances.delete",
    "compute.instances.setLabels",
    "compute.instances.setTags",
    "compute.instances.setMetadata",
    "compute.instances.setServiceAccount",
    "compute.subnetworks.use",
    "compute.instanceGroups.update"
  ]
}

resource "google_project_iam_member" "compute_service_agent_minimal" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.compute_service_agent_minimal[0].name
  member  = "serviceAccount:${data.google_project.current.number}@cloudservices.gserviceaccount.com"
}

# Allow management SA to create tokens for scanner SA
resource "google_service_account_iam_member" "management_can_impersonate_scanner" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_sa[0].id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.upwind_management_sa.email}"
}

# Allow management SA to create tokens for scaler SA
resource "google_service_account_iam_member" "management_can_impersonate_scaler" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_scaler_sa[0].id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.upwind_management_sa.email}"
}

# Allow scanner SA to create tokens for scaler SA
resource "google_service_account_iam_member" "scanner_can_impersonate_scaler" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_scaler_sa[0].id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}"
}

# Allow scaler SA to create tokens for scanner SA
resource "google_service_account_iam_member" "scaler_can_impersonate_scanner" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_sa[0].id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}"
}

# Allow Cloud Scheduler to impersonate scaler SA
resource "google_service_account_iam_member" "cloudscheduler_can_impersonate_scaler" {
  count              = var.enable_cloudscanners ? 1 : 0
  service_account_id = google_service_account.cloudscanner_scaler_sa[0].id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:service-${data.google_project.current.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}