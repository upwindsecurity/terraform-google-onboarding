variable "project_ids" {
  description = "List of project IDs to enable APIs for"
  type        = list(string)
}

variable "upwind_apis" {
  description = "List of GCP APIs to enable for Upwind Operations."
  type        = list(string)
  default = [
    "cloudasset.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "container.googleapis.com",
    "sts.googleapis.com",
    "storageinsights.googleapis.com",
  ]
}

variable "upwind_posture_apis" {
  description = "List of GCP APIs to enable for Upwind Posture."
  type        = list(string)
  default = [
    "accessapproval.googleapis.com",
    "admin.googleapis.com",
    "alloydb.googleapis.com",
    "apikeys.googleapis.com",
    "bigquery.googleapis.com",
    "dataproc.googleapis.com",
    "dns.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudkms.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "redis.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
    "essentialcontacts.googleapis.com",
    "serviceusage.googleapis.com",
  ]
}

variable "upwind_cloudscanner_apis" {
  description = "List of GCP APIs to enable for Upwind Cloud Scanners."
  type        = list(string)
  default = [
    "secretmanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "compute.googleapis.com",
    "run.googleapis.com",
    "cloudscheduler.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ]
}

variable "enable_cloudscanners" {
  description = "Enable the creation of cloud scanners."
  type        = bool
  default     = false
}
