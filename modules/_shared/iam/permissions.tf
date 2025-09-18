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
