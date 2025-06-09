resource "google_project_service" "enable_apis" {
  for_each = toset(concat(
    var.upwind_apis,
    var.upwind_posture_apis,
    var.enable_cloudscanners ? var.upwind_cloudscanner_apis : []
  ))

  project = local.project
  service = each.value

  disable_dependent_services = false
  disable_on_destroy         = false
}
