locals {
  # All active projects in the organization
  all_org_project_ids = [
    for project in data.google_projects.org_projects.projects :
    project.project_id
    if project.lifecycle_state == "ACTIVE"
  ]

  # Determine which projects to enable APIs on
  target_project_ids = var.enable_all_project_apis ? local.all_org_project_ids : var.project_apis_to_enable
}

# Get all projects in the organization
data "google_projects" "org_projects" {
  filter = "parent.id:${var.gcp_organization_id}"
}

# Use shared APIs module with project:api format
module "shared_apis" {
  source = "../_shared/apis"

  project_ids               = local.target_project_ids
  enable_cloudscanners      = var.enable_cloudscanners
}
