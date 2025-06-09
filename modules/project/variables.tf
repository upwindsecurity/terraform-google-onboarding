# region upwind

variable "upwind_organization_id" {
  description = "The identifier of the Upwind organization to integrate with."
  type        = string
}

variable "upwind_client_id" {
  description = "The client ID used for authentication with the Upwind Authorization Service."
  type        = string
}

variable "upwind_client_secret" {
  description = "The client secret for authentication with the Upwind Authorization Service."
  type        = string
}

variable "upwind_region" {
  type        = string
  description = "Which Upwind region to communicate with. 'us' or 'eu'"
  default     = "us"

  validation {
    condition     = var.upwind_region == "us" || var.upwind_region == "eu"
    error_message = "upwind_region must be either 'us' or 'eu'."
  }
}

variable "upwind_auth_endpoint" {
  description = "The Authentication API endpoint."
  type        = string
  default     = "https://auth.upwind.io"
}

variable "upwind_integration_endpoint" {
  description = "The Integration API endpoint."
  type        = string
  default     = "https://integration.upwind.io"
}

variable "upwind_skip_http" {
  description = "Controls whether HTTP requests should be skipped. Affects all HTTP requests."
  type        = bool
  default     = false
}

# endregion upwind

# region google

variable "google_service_account_id_prefix" {
  description = "The prefix of the service account ID. Changing this forces a new service account to be created."
  type        = string
  default     = "upwind"
}

variable "google_service_account_display_name" {
  description = "The display name for the service account."
  type        = string
  default     = "Upwind Security Service Account"
}

variable "google_service_account_roles" {
  description = "The roles that should be attached to the service account."
  type        = list(string)
  default     = ["roles/viewer"]
}

# endregion google
