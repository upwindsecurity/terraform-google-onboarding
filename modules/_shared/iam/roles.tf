### Cloudscanner Specific IAM Roles

# Used by the management service account to deploy the cloudscanner resources
resource "google_project_iam_custom_role" "upwind_management_sa_cloudscanner_deployment_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  project     = local.project
  role_id     = "CloudScannerDeploymentRole_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-cs-deployment"
  description = "Minimum permissions required to deploy the Cloudscanner resources"
  permissions = var.deployment_permissions
}

# Used for basic cloudscanner operation
resource "google_project_iam_custom_role" "cloudscanner_basic_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  project     = local.project
  role_id     = "CloudScannerBasicRole_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-basic"
  description = "Minimum permissions required for Cloudscanner operations"

  permissions = var.cloudscanner_basic_permissions
}

# Used by the CloudScanner Scaler to scale the CloudScanner Instance Groups
resource "google_project_iam_custom_role" "cloudscanner_scaler_role" {
  count       = var.enable_cloudscanners ? 1 : 0
  role_id     = "CloudScannerScalerRole_${local.resource_suffix_underscore}"
  project     = local.project
  title       = "upwind-role-${local.resource_suffix_hyphen}-scaler-base"
  description = "Minimum permissions required for Cloudscanner Scaler operations"

  permissions = var.cloudscanner_scaler_permissions
}

# Ability to access the Upwind Client ID and Secret
resource "google_project_iam_custom_role" "cloudscanner_secret_access_role" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role_id = "CloudScannerSecretAccessRole_${local.resource_suffix_underscore}"
  title   = "upwind-role-${local.resource_suffix_hyphen}-secret-access"

  permissions = var.cloudscanner_secret_access_permissions
}

# Grants permission for Cloudscanners to manage their own instance templates
resource "google_project_iam_custom_role" "cloudscanner_instance_template_mgmt_role" {
  count   = var.enable_cloudscanners ? 1 : 0
  role_id = "CloudScannerInstTmplMgmtRole_${local.resource_suffix_underscore}"
  project = local.project
  title   = "upwind-role-${local.resource_suffix_hyphen}-instance-template-mgmt"

  permissions = var.cloudscanner_instance_template_mgmt_permissions
}

# Grants permission for Cloudscanners to test create their own instance templates when updating the template
resource "google_project_iam_custom_role" "cloudscanner_instance_template_test_creation_role" {
  count   = var.enable_cloudscanners ? 1 : 0
  role_id = "CloudScannerInstTmplTestCreationRole_${local.resource_suffix_underscore}"
  project = local.project
  title   = "upwind-role-${local.resource_suffix_hyphen}-instance-template-mgmt-test-creation"

  permissions = var.cloudscanner_instance_template_test_creation_permissions
}

resource "google_project_iam_custom_role" "disk_writer" {
  count       = var.enable_cloudscanners ? 1 : 0
  project     = local.project
  role_id     = "CloudScannerDiskWriter_${local.resource_suffix_underscore}"
  title       = "upwind-role-${local.resource_suffix_hyphen}-disk-writer"
  description = "Disk Write operations in orchestrator project"

  permissions = var.disk_writer_permissions
}

# Required when scaling up the Instance Group as the Compute Engine service agent
# is the entity that performs the scaling operations
resource "google_project_iam_custom_role" "compute_service_agent_minimal" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role_id = "ComputeServiceAgentMinimal_${local.resource_suffix_underscore}"
  title   = "upwind-role-${local.resource_suffix_hyphen}-compute-service-agent-minimal"

  permissions = var.compute_service_agent_minimal_permissions
}

### IAM Members

# Required for the management service account to deploy the CloudScanner resources
resource "google_project_iam_member" "upwind_management_sa_cloudscanner_deployment_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role[0].name
  member  = "serviceAccount:${google_service_account.upwind_management_sa.email}"
}

resource "google_project_iam_member" "cloudscanner_sa_basic_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_basic_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}"
}

resource "google_project_iam_member" "cloudscanner_sa_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_scaler_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}" # CloudScanner VMs
}

resource "google_project_iam_member" "cloudscanner_scaler_sa_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_scaler_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}" # CloudScanner Scaler (Cloud Run)"
}

# Only grant access to the Upwind Client ID and Secret
resource "google_project_iam_member" "upwind_management_sa_secret_access_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_secret_access_role[0].name
  member  = "serviceAccount:${google_service_account.upwind_management_sa.email}"

  condition {
    # Limit secret access permissions to all versions of Upwind CloudScanner credentials only
    title      = "Upwind CloudScanner Credentials Access"
    expression = "resource.name.startsWith('${google_secret_manager_secret.scanner_client_id[0].name}') || resource.name.startsWith('${google_secret_manager_secret.scanner_client_secret[0].name}')"
  }
}

# Only grant access to the Upwind Scanner Client ID and Secret
resource "google_project_iam_member" "cloudscanner_secret_access_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_secret_access_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_sa[0].email}"

  condition {
    # Limit secret access permissions to all versions of Upwind CloudScanner credentials only
    title      = "Upwind CloudScanner Credentials Access"
    expression = "resource.name.startsWith('${google_secret_manager_secret.scanner_client_id[0].name}') || resource.name.startsWith('${google_secret_manager_secret.scanner_client_secret[0].name}')"
  }
}

resource "google_project_iam_member" "cloudscanner_scaler_secret_access_scaler_role_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_secret_access_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}" # CloudScanner Scaler (Cloud Run)"

  condition {
    # Limit secret access permissions to all versions of Upwind CloudScanner credentials only
    title      = "Upwind CloudScanner Credentials Access"
    expression = "resource.name.startsWith('${google_secret_manager_secret.scanner_client_id[0].name}') || resource.name.startsWith('${google_secret_manager_secret.scanner_client_secret[0].name}')"
  }
}

resource "google_project_iam_member" "cloudscanner_scaler_sa_run_invoker" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project

  # This predefined role contains 'run.jobs.run' and 'run.routes.invoke' permissions only so no need for custom role
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}"

  condition {
    # Limit invocation permissions to the scaler function only
    title = "Upwind CloudScanner Function Execution"

    # Currently it does not appear to be possible to set conditions such that the service account can invoke the scheduled job.
    # As per https://cloud.google.com/run/docs/reference/iam/roles, the run.invoker role is the minimal set of roles required for a
    # Service Account to invoke a Cloud Run Job
    expression = ""
  }
}

resource "google_project_iam_member" "cloudscanner_instance_template_mgmt_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}" # Cloud Scanner Scaler (Cloud Run)"

  condition {
    # Limit the use of the roles to cloudscanner only instance templates
    title      = "Upwind Cloud Scanner Instance Template Management"
    expression = "resource.name.extract('instanceTemplates/{template}').startsWith('upwind-tpl-')"
  }
}

resource "google_project_iam_member" "cloudscanner_instance_template_test_creation_member" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role[0].name
  member  = "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}" # Cloud Scanner Scaler (Cloud Run)"

  condition {
    # Upgrading templates performs a 'dry-run' of instance creation, limit to resources using this pattern
    title      = "Upwind Cloud Scanner Instance Template Upgrade"
    expression = "resource.name.endsWith('-0000')"
  }
}



# Limit disk creation/deletion permissions to Upwind named disks only in orchestrator project
resource "google_project_iam_binding" "cloudscanner_disk_writer_role_binding" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.disk_writer[0].name
  members = [
    "serviceAccount:${google_service_account.cloudscanner_sa[0].email}",
    "serviceAccount:${google_service_account.cloudscanner_scaler_sa[0].email}"
  ]
  condition {
    # Limit disk creation/deletion permissions to Upwind named disks only in orchestrator project
    title      = "Upwind Cloud Scanner Disk Writer"
    expression = "resource.name.extract('disks/{disk}').startsWith('vol-snap-')"
  }
}

# Allows the Google Cloud Run service agent to manage Cloud Run jobs
resource "google_project_iam_member" "cloudrun_service_agent" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = "roles/run.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.current.number}@serverless-robot-prod.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "compute_service_agent_minimal" {
  count   = var.enable_cloudscanners ? 1 : 0
  project = local.project
  role    = google_project_iam_custom_role.compute_service_agent_minimal[0].name
  member  = "serviceAccount:${data.google_project.current.number}@cloudservices.gserviceaccount.com"
}

resource "google_secret_manager_secret_iam_member" "terraform_labels_viewer" {
  project   = local.project
  secret_id = google_secret_manager_secret.terraform_labels.secret_id
  role      = "roles/secretmanager.viewer"
  member    = "serviceAccount:${google_service_account.upwind_management_sa.email}"
}

