variable "target_folder_ids" {
  description = "List of target folder IDs for onboarding"
  type        = list(string)
  default     = []
}

variable "upwind_organization_id" {
  description = "The Upwind organization ID."
  type        = string
}

variable "upwind_client_id" {
  description = "The client ID used for authentication with the Upwind Authorization Service."
  type        = string
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

variable "gcp_organization_id" {
  description = "The GCP organization ID."
  type        = string
}

variable "upwind_orchestrator_project" {
  description = "The orchestrator project where Upwind resources are created."
  type        = string
}

variable "workload_identity_pool_project" {
  description = "The project where the workload identity pool is created. Defaults to the orchestrator project if not specified."
  type        = string
}

variable "resource_suffix" {
  description = "A suffix to append to resource names to ensure uniqueness."
  type        = string
}
