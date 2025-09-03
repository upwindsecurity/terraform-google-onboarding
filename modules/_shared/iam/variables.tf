### region google

variable "google_service_account_display_name" {
  description = "Display name for the management service account"
  type        = string
}

### endregion google

### region secrets

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

# endregion secrets

# region workload identity federation
variable "workload_identity_pool_project" {
  description = "The project where the workload identity pool is created. Defaults to the orchestrator project if not specified."
  type        = string
  default     = ""

  validation {
    condition     = var.workload_identity_pool_project == "" || can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.workload_identity_pool_project))
    error_message = "The Workload Identity Pool project ID must be 6-30 characters, lowercase letters, numbers or hyphens, must start with a letter, and cannot end with a hyphen."
  }
}

# endregion workload identity federation

# region upwind

variable "upwind_organization_id" {
  description = "The identifier of the Upwind organization to integrate with."
  type        = string

  validation {
    condition     = can(regex("org_[a-zA-Z0-9]{1,}", var.upwind_organization_id))
    error_message = "The Upwind organization ID must start with 'org_' followed by alphanumeric characters."
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

variable "resource_suffix" {
  description = "The suffix to append to all resources created by this module."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{0,10}$", var.resource_suffix))
    error_message = "The resource suffix must be alphanumeric and cannot exceed 10 characters."
  }
}

variable "enable_cloudscanners" {
  description = "Enable CloudScanner resources"
  type        = bool
  default     = true
}

variable "is_dev" {
  description = "Flag to indicate if the environment is a development environment."
  type        = bool
  default     = false
}

variable "labels" {
  description = "A map of labels to apply to all resources"
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for k, v in var.labels :
      can(regex("^[a-z0-9_-]{1,63}$", k)) && can(regex("^[a-z0-9_-]{0,63}$", v))
    ])
    error_message = "Invalid labels found: ${join(", ", [for k, v in var.labels : !can(regex("^[a-z0-9_-]{1,63}$", k)) || !can(regex("^[a-z0-9_-]{0,63}$", v)) ? "'${k}=${v}'" : ""])}. Label keys must be 1-63 characters and label values must be 0-63 characters of lowercase letters, numbers, underscores, or hyphens."
  }
}

variable "default_labels" {
  description = "Default labels applied to all resources (can be overridden)"
  type        = map(string)
  default = {
    managed_by = "terraform"
    component  = "upwind"
  }
  validation {
    condition = alltrue([
      for k, v in var.default_labels :
      can(regex("^[a-z0-9_-]{1,63}$", k)) && can(regex("^[a-z0-9_-]{0,63}$", v))
    ])
    error_message = "Invalid default labels found: ${join(", ", [for k, v in var.default_labels : !can(regex("^[a-z0-9_-]{1,63}$", k)) || !can(regex("^[a-z0-9_-]{0,63}$", v)) ? "'${k}=${v}'" : ""])}. Label keys must be 1-63 characters and label values must be 0-63 characters of lowercase letters, numbers, underscores, or hyphens."
  }
}

# endregion upwind
