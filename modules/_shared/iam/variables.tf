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

variable "google_service_account_display_name" {
  description = "Display name for the management service account"
  type        = string
}
