output "enabled_apis" {
  description = "Map of enabled APIs by project:api key"
  value = {
    for key, service in google_project_service.apis :
    key => {
      project = service.project
      service = service.service
    }
  }
}

output "projects_with_apis" {
  description = "List of projects that had APIs enabled"
  value       = var.project_ids
}

output "api_count" {
  description = "Total number of project:api combinations enabled"
  value       = length(google_project_service.apis)
}
