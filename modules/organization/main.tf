locals {
  project = var.upwind_orchestrator_project
  # Sanitize the org_id to be used in resource names
  # SA names can't have underscores and have a small limit on length...
  # Additionally they have to end with a lowercase letter or number......
  org_id_sanitized = replace(lower(var.upwind_organization_id), "org_", "")
  # Since we need to accommodate a custom suffix defined by the user, we actually need to reduce this length further
  # Else, we can't have nice naming formats with purposeful prefixes
  org_id_truncated = substr(local.org_id_sanitized, max(0, length(local.org_id_sanitized) - 5), 5)
  # Due to length limits, we can allow a 10 character suffix:
  # upwind-scaler- is the longest base = 14 chars
  # org_id_truncated = 5 chars
  # resource_suffix = 10 chars with a hyphen
  resource_suffix_hyphen     = format("%s%s", local.org_id_truncated, var.resource_suffix == "" ? "" : "-${var.resource_suffix}")
  resource_suffix_underscore = format("%s%s", local.org_id_truncated, var.resource_suffix == "" ? "" : "_${var.resource_suffix}")
}

provider "google" {
  project = local.project
}

data "google_organization" "org" {
  organization = var.gcp_organization_id
}
