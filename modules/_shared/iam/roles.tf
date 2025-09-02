### Cloudscanner Specific IAM Roles

# Used by the management service account to deploy the cloudscanner resources
resource "google_project_iam_custom_role" "upwind_management_sa_cloudscanner_deployment_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  project     = var.upwind_orchestrator_project
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
    "compute.instanceGroupManagers.update",
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
    "compute.disks.createSnapshot",
    "compute.disks.get",
    "compute.disks.list",
    "compute.instances.attachDisk",
    "compute.instances.detachDisk",
    "compute.instances.get",
    "compute.instances.list",
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

