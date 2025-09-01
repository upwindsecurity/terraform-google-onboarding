locals {
  all_apis = concat(
    var.upwind_apis,
    var.upwind_posture_apis,
    var.enable_cloudscanners ? var.upwind_cloudscanner_apis : []
  )
}

resource "google_project_service" "apis" {
  for_each = toset([
    for pair in setproduct(var.project_ids, local.all_apis) :
    "${pair[0]}:${pair[1]}"
  ])

  project = split(":", each.key)[0]
  service = split(":", each.key)[1]

  disable_dependent_services = false
  disable_on_destroy         = false
}
