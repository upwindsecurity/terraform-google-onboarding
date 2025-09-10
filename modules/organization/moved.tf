### Service Account related

moved {
  from = google_service_account.upwind_management_sa
  to   = module.iam.google_service_account.upwind_management_sa
}

moved {
  from = google_service_account.cloudscanner_sa
  to   = module.iam.google_service_account.cloudscanner_sa
}

moved {
  from = google_service_account.cloudscanner_scaler_sa
  to   = module.iam.google_service_account.cloudscanner_scaler_sa
}

### Service Account IAM bindings

moved {
  from = google_service_account_iam_binding.scaler_and_compute_can_use_cloudscanner
  to   = module.iam.google_service_account_iam_binding.scaler_and_compute_can_use_cloudscanner
}

### Service Account IAM members

moved {
  from = google_service_account_iam_member.cloudscanner_impersonate_scaler
  to   = module.iam.google_service_account_iam_member.cloudscanner_impersonate_scaler
}

moved {
  from = google_service_account_iam_member.management_can_impersonate_scanner
  to   = module.iam.google_service_account_iam_member.management_can_impersonate_scanner
}

moved {
  from = google_service_account_iam_member.management_can_impersonate_scaler
  to   = module.iam.google_service_account_iam_member.management_can_impersonate_scaler
}

moved {
  from = google_service_account_iam_member.scanner_can_impersonate_scaler
  to   = module.iam.google_service_account_iam_member.scanner_can_impersonate_scaler
}

moved {
  from = google_service_account_iam_member.scaler_can_impersonate_scanner
  to   = module.iam.google_service_account_iam_member.scaler_can_impersonate_scanner
}

moved {
  from = google_service_account_iam_member.cloudscheduler_can_impersonate_scaler
  to   = module.iam.google_service_account_iam_member.cloudscheduler_can_impersonate_scaler
}

moved {
  from = google_project_iam_member.compute_service_agent_minimal
  to   = module.iam.google_project_iam_member.compute_service_agent_minimal
}

### IAM Roles related

moved {
  from = google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role
  to   = module.iam.google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_basic_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_basic_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_scaler_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_scaler_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_secret_access_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_secret_access_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role
}

moved {
  from = google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role
  to   = module.iam.google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role
}

moved {
  from = google_project_iam_custom_role.disk_writer
  to   = module.iam.google_project_iam_custom_role.disk_writer
}

moved {
  from = google_project_iam_custom_role.compute_service_agent_minimal
  to   = module.iam.google_project_iam_custom_role.compute_service_agent_minimal
}

### IAM Members

moved {
  from = google_project_iam_member.upwind_management_sa_cloudscanner_deployment_role_member
  to   = module.iam.google_project_iam_member.upwind_management_sa_cloudscanner_deployment_role_member
}

moved {
  from = google_project_iam_member.upwind_management_sa_secret_access_role_member
  to   = module.iam.google_project_iam_member.upwind_management_sa_secret_access_role_member
}

moved {
  from = google_project_iam_member.cloudscanner_instance_template_mgmt_member
  to   = module.iam.google_project_iam_member.cloudscanner_instance_template_mgmt_member
}

moved {
  from = google_project_iam_member.cloudscanner_instance_template_test_creation_member
  to   = module.iam.google_project_iam_member.cloudscanner_instance_template_test_creation_member
}

moved {
  from = google_project_iam_member.cloudscanner_sa_basic_role_member
  to   = module.iam.google_project_iam_member.cloudscanner_sa_basic_role_member
}

moved {
  from = google_project_iam_member.cloudscanner_sa_scaler_role_member
  to   = module.iam.google_project_iam_member.cloudscanner_sa_scaler_role_member
}

moved {
  from = google_project_iam_member.cloudscanner_scaler_sa_run_invoker
  to   = module.iam.google_project_iam_member.cloudscanner_scaler_sa_run_invoker
}

moved {
  from = google_project_iam_member.cloudscanner_scaler_sa_scaler_role_member
  to   = module.iam.google_project_iam_member.cloudscanner_scaler_sa_scaler_role_member
}

moved {
  from = google_project_iam_member.cloudscanner_scaler_secret_access_scaler_role_member
  to   = module.iam.google_project_iam_member.cloudscanner_scaler_secret_access_scaler_role_member
}

moved {
  from = google_project_iam_member.cloudscanner_secret_access_role_member
  to   = module.iam.google_project_iam_member.cloudscanner_secret_access_role_member
}

moved {
  from = google_project_iam_member.cloudrun_service_agent
  to   = module.iam.google_project_iam_member.cloudrun_service_agent
}

moved {
  from = google_project_iam_member.cloudrun_service_agent_minimal
  to   = module.iam.google_project_iam_member.cloudrun_service_agent_minimal
}

moved {
  from = google_project_iam_binding.cloudscanner_disk_writer_role_binding
  to   = module.iam.google_project_iam_binding.cloudscanner_disk_writer_role_binding
}

### Secrets related

moved {
  from = google_secret.upwind_client_id
  to   = module.iam.google_secret.upwind_client_id
}

moved {
  from = google_secret.upwind_client_secret
  to   = module.iam.google_secret.upwind_client_secret
}

moved {
  from = google_secret.scanner_client_id
  to   = module.iam.google_secret.scanner_client_id
}

moved {
  from = google_secret.scanner_client_secret
  to   = module.iam.google_secret.scanner_client_secret
}

moved {
  from = google_secret_manager_secret_version.upwind_client_id_v1
  to   = module.iam.google_secret_manager_secret_version.upwind_client_id_v1
}

moved {
  from = google_secret_manager_secret_version.upwind_client_secret_v1
  to   = module.iam.google_secret_manager_secret_version.upwind_client_secret_v1
}

moved {
  from = google_secret_manager_secret_version.scanner_client_id_v1
  to   = module.iam.google_secret_manager_secret_version.scanner_client_id_v1
}

moved {
  from = google_secret_manager_secret_version.scanner_client_secret_v1
  to   = module.iam.google_secret_manager_secret_version.scanner_client_secret_v1
}

### Workload Identity Pool related

moved {
  from = google_iam_workload_identity_pool.main
  to   = module.iam.google_iam_workload_identity_pool.main
}

moved {
  from = google_iam_workload_identity_pool_provider.aws
  to   = module.iam.google_iam_workload_identity_pool_provider.aws
}

moved {
  from = google_service_account_iam_member.management_workload_identity
  to   = module.iam.google_service_account_iam_member.management_workload_identity
}

moved {
  from = google_service_account_iam_member.management_token_creator
  to   = module.iam.google_service_account_iam_member.management_token_creator
}

moved {
  from = google_service_account_iam_member.cloudscanner_workload_identity
  to   = module.iam.google_service_account_iam_member.cloudscanner_workload_identity
}

moved {
  from = google_service_account_iam_member.cloudscanner_token_creator
  to   = module.iam.google_service_account_iam_member.cloudscanner_token_creator
}
