variable "deployment_permissions" {
  description = "List of IAM permissions for deployment operations."
  type        = list(string)
  default = [
    # Compute Engine resource creation permissions
    "compute.instanceTemplates.create",
    "compute.instanceTemplates.delete",
    "compute.instanceTemplates.get",
    "compute.instanceGroupManagers.create",
    "compute.instanceGroupManagers.delete",
    "compute.instanceGroupManagers.get",
    "compute.instanceGroupManagers.update",
    "compute.instanceGroups.delete",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
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
    # Required for Terraform to check operation status
    "compute.regionOperations.get",
    # Required basic service usage
    "serviceusage.services.use"
  ]
}

variable "cloudscanner_basic_permissions" {
  description = "List of IAM permissions for basic CloudScanner operations."
  type        = list(string)
  default = [
    # Basic permissions for CloudScanner operation
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

variable "cloudscanner_scaler_permissions" {
  description = "List of IAM permissions for CloudScanner Scaler operations."
  type        = list(string)
  default = [
    # Permissions for the CloudScanner Scaler
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

variable "cloudscanner_secret_access_permissions" {
  description = "List of IAM permissions for CloudScanner secret access."
  type        = list(string)
  default = [
    # Permissions for accessing secrets in Secret Manager
    "secretmanager.versions.access",
    "secretmanager.versions.list",
    "secretmanager.secrets.get",
    "secretmanager.secrets.list",
  ]
}

variable "cloudscanner_instance_template_mgmt_permissions" {
  description = "List of IAM permissions for CloudScanner instance template management."
  type        = list(string)
  default = [
    "compute.instanceTemplates.get",
    "compute.instanceTemplates.create",
    "compute.instanceTemplates.delete",
    "compute.instanceTemplates.useReadOnly",
  ]
}

variable "cloudscanner_instance_template_test_creation_permissions" {
  description = "List of IAM permissions for CloudScanner instance template test creation."
  type        = list(string)
  default = [
    "compute.instances.create",
    "compute.instances.setMetadata",
    "compute.instances.setLabels",
    "compute.disks.create",
  ]
}

variable "disk_writer_permissions" {
  description = "List of IAM permissions for disk writer role."
  type        = list(string)
  default = [
    "compute.disks.create",
    "compute.disks.delete",
    "compute.disks.setLabels",
    "compute.disks.use",
  ]
}

variable "compute_service_agent_minimal_permissions" {
  description = "List of IAM permissions for minimal compute service agent role."
  type        = list(string)
  default = [
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

variable "storage_read_permissions" {
  description = "List of IAM permissions for storage read access."
  type        = list(string)
  default = [
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
    "storage.objects.getIamPolicy",
    "storage.objects.list",
  ]
}

variable "iam_read_role_permissions" {
  description = "List of IAM permissions for read-only access across GCP services."
  type        = list(string)
  default = [
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

variable "snapshot_reader_permissions" {
  description = "List of IAM permissions for reading snapshots."
  type        = list(string)
  default = [
    # Read-only permissions for discovery
    "compute.disks.get",
    "compute.disks.list",
    "compute.disks.createSnapshot", # Cannot be restricted, we don't know target disk names
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

variable "snapshot_creator_permissions" {
  description = "List of IAM permissions for creating and deleting snapshots."
  type        = list(string)
  default = [
    "compute.snapshots.create",
    "compute.snapshots.setLabels",
    "compute.snapshots.useReadOnly"
  ]
}

variable "snapshot_deleter_permissions" {
  description = "List of IAM permissions for deleting snapshots."
  type        = list(string)
  default = [
    "compute.snapshots.delete",
  ]
}

variable "storage_object_reader_permissions" {
  description = "List of IAM permissions for storage object reader role."
  type        = list(string)
  default = [
    "storage.objects.get",
    "storage.buckets.get",
    "storage.buckets.list",
  ]
}

variable "cloud_run_permissions" {
  description = "List of IAM permissions for Cloud Run roles."
  type        = list(string)
  default = [
    "artifactregistry.repositories.downloadArtifacts",
    "artifactregistry.dockerimages.get",
  ]
}
