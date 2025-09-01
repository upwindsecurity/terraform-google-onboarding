# region upwind
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

variable "resource_suffix" {
  description = "The suffix to append to all resources created by this module."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{0,10}$", var.resource_suffix))
    error_message = "The resource suffix must be alphanumeric and cannot exceed 10 characters."
  }
}

variable "upwind_organization_id" {
  description = "The identifier of the Upwind organization to integrate with."
  type        = string

  validation {
    condition     = can(regex("org_[a-zA-Z0-9]{1,}", var.upwind_organization_id))
    error_message = "The Upwind organization ID must start with 'org_' followed by alphanumeric characters."
  }
}

variable "upwind_client_id" {
  description = "The client ID used for authentication with the Upwind Authorization Service."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{1,}", var.upwind_client_id))
    error_message = "The Upwind client ID must be alphanumeric."
  }
}

variable "upwind_client_secret" {
  description = "The client secret for authentication with the Upwind Authorization Service."
  type        = string
  sensitive   = true
}

variable "scanner_client_id" {
  description = "The client ID used for authentication with the Upwind Cloudscanner Service."
  type        = string
  default     = ""

  validation {
    condition     = var.scanner_client_id == "" || (can(regex("^[a-zA-Z0-9]{1,}", var.scanner_client_id)))
    error_message = "The Upwind scanner client ID must be empty or alphanumeric."
  }
}

variable "scanner_client_secret" {
  description = "The client secret for authentication with the Upwind Cloudscanner Service."
  type        = string
  sensitive   = true
  default     = ""
}

variable "is_dev" {
  description = "Flag to indicate if the environment is a development environment."
  type        = bool
  default     = false
}

# endregion upwind

# region google

variable "gcp_organization_id" {
  description = "The GCP organization ID."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{1,}", var.gcp_organization_id))
    error_message = "The GCP organization ID must be numeric."
  }
}

variable "upwind_orchestrator_project" {
  description = "The orchestrator project where Upwind resources are created."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.upwind_orchestrator_project))
    error_message = "The Upwind orchestrator project ID must be 6-30 characters, lowercase letters, numbers or hyphens, must start with a letter, and cannot end with a hyphen."
  }
}

variable "workload_identity_pool_project" {
  description = "The project where the workload identity pool is created. Defaults to the orchestrator project if not specified."
  type        = string
  default     = ""

  validation {
    condition     = var.workload_identity_pool_project == "" || can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.workload_identity_pool_project))
    error_message = "The Workload Identity Pool project ID must be 6-30 characters, lowercase letters, numbers or hyphens, must start with a letter, and cannot end with a hyphen."
  }
}

variable "enable_cloudscanners" {
  description = "Enable the creation of cloud scanners."
  type        = bool
  default     = false
}

variable "enable_dspm_scanning" {
  description = "Enable DSPM scanning by cloud scanners"
  type        = bool
  default     = true
}

variable "google_service_account_display_name" {
  description = "The display name for the service account."
  type        = string
  default     = "Upwind Security Service Account"
  validation {
    condition     = length(var.google_service_account_display_name) >= 1 && length(var.google_service_account_display_name) <= 100
    error_message = "Service account display name must be between 1 and 100 characters."
  }
}

variable "enable_all_project_apis" {
  description = "Enable APIs on all projects in the organization"
  type        = bool
  default     = true
}

variable "project_apis_to_enable" {
  description = "Specific project IDs to enable APIs on (used when enable_all_project_apis is false)"
  type        = list(string)
  default     = []
}
# endregion google
