# Google Cloud Organization Onboarding Module

This Terraform module handles the onboarding of Google Cloud organizations to the Upwind platform, enabling users to
seamlessly connect their entire organization for comprehensive monitoring and security analysis.


## APIs

The Terraform module will enable these APIs on the orchestrator project:

### Required for Upwind operations

| API Name                                                                                | Endpoint                              |
| --------------------------------------------------------------------------------------- | ------------------------------------- |
| [Cloud Asset API](https://cloud.google.com/asset-inventory/docs/reference/rest)         | `cloudasset.googleapis.com`           |
| [Cloud Resource Manager API](https://cloud.google.com/resource-manager/reference/rest)  | `cloudresourcemanager.googleapis.com` |
| [Compute Engine API](https://cloud.google.com/compute/docs/reference/rest/v1)           | `compute.googleapis.com`              |
| [Identity and Access Management API](https://cloud.google.com/iam/docs/reference/rest)  | `iam.googleapis.com`                  |
| [Kubernetes Engine API](https://cloud.google.com/kubernetes-engine/docs/reference/rest) | `container.googleapis.com`            |
| [Security Token Service API](https://cloud.google.com/iam/docs/reference/sts/rest)      | `sts.googleapis.com`                  |

### Required for Upwind Posture

| API Name                                                                             | Endpoint                           |
| ------------------------------------------------------------------------------------ | ---------------------------------- |
| [Access Approval API](https://cloud.google.com/access-approval/docs)                 | `accessapproval.googleapis.com`    |
| [Admin SDK Directory API](https://developers.google.com/admin-sdk/directory)         | `admin.googleapis.com`             |
| [AlloyDB Admin API](https://cloud.google.com/alloydb/docs/reference/rest)            | `alloydb.googleapis.com`           |
| [API Keys API](https://cloud.google.com/api-keys/docs)                               | `apikeys.googleapis.com`           |
| [BigQuery API](https://cloud.google.com/bigquery/docs/reference/rest)                | `bigquery.googleapis.com`          |
| [Cloud Dataproc API](https://cloud.google.com/dataproc/docs/reference/rest)          | `dataproc.googleapis.com`          |
| [Cloud DNS API](https://cloud.google.com/dns/docs/reference/v1)                      | `dns.googleapis.com`               |
| [Cloud Functions API](https://cloud.google.com/functions/docs/reference/rest)        | `cloudfunctions.googleapis.com`    |
| [Cloud Key Management Service API](https://cloud.google.com/kms/docs/reference/rest) | `cloudkms.googleapis.com`          |
| [Cloud Logging API](https://cloud.google.com/logging/docs/reference/v2/rest)         | `logging.googleapis.com`           |
| [Cloud Monitoring API](https://cloud.google.com/monitoring/api/ref_v3/rest)          | `monitoring.googleapis.com`        |
| [Cloud Redis API](https://cloud.google.com/memorystore/docs/redis/reference/rest)    | `redis.googleapis.com`             |
| [Cloud SQL Admin API](https://cloud.google.com/sql/docs/mysql/admin-api)             | `sqladmin.googleapis.com`          |
| [Cloud Storage API](https://cloud.google.com/storage/docs/json_api)                  | `storage.googleapis.com`           |
| [Essential Contacts API](https://cloud.google.com/essential-contacts/docs)           | `essentialcontacts.googleapis.com` |
| [Service Usage API](https://cloud.google.com/service-usage/docs/reference/rest)      | `serviceusage.googleapis.com`      |

### Required for Upwind Cloud Scanners

These are only enabled if `enable_cloudscanners` is true.

| API Name                                                                                            | Endpoint                              |
| --------------------------------------------------------------------------------------------------- | ------------------------------------- |
| [Secret Manager API](https://cloud.google.com/secret-manager/docs/reference/rest)                   | `secretmanager.googleapis.com`        |
| [Identity and Access Management API](https://cloud.google.com/iam/docs/reference/rest)              | `iam.googleapis.com`                  |
| [IAM Service Account Credentials API](https://cloud.google.com/iam/docs/reference/credentials/rest) | `iamcredentials.googleapis.com`       |
| [Compute Engine API](https://cloud.google.com/compute/docs/reference/rest/v1)                       | `compute.googleapis.com`              |
| [Cloud Run Admin API](https://cloud.google.com/run/docs/reference/rest)                             | `run.googleapis.com`                  |
| [Cloud Scheduler API](https://cloud.google.com/scheduler/docs/reference/rest)                       | `cloudscheduler.googleapis.com`       |
| [Cloud Resource Manager API](https://cloud.google.com/resource-manager/reference/rest)              | `cloudresourcemanager.googleapis.com` |

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.23.0, <= 6.35.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.aws](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_organization_iam_custom_role.cloudscanner_cloud_run_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_custom_role.upwind_management_sa_iam_read_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_custom_role.upwind_management_sa_iam_write_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_custom_role.snapshot_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_custom_role.snapshot_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.cloudscanner_cloud_run_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_cloudscanner_sa_compute_viewer_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_management_sa_iam_read_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_management_sa_iam_write_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_management_sa_org_viewer_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_cloudscanner_reader_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_cloudscanner_writer_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project_iam_custom_role.cloudscanner_basic_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_scaler_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_secret_access_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_storage_delete_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.cloudscanner_sa_basic_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_sa_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_sa_run_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_sa_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_secret_access_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_secret_access_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_cloudscanner_deployment_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_secret_access_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account_iam_member.cloudscanner_impersonate_scaler](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_project_service.enable_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_secret_manager_secret.scanner_client_id](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.scanner_client_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.upwind_client_id](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.upwind_client_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.scanner_client_id_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.scanner_client_secret_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.upwind_client_id_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.upwind_client_secret_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.cloudscanner_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.cloudscanner_scaler_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.upwind_management_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.cloudscanner_scaler_sa_cloudscanner_sa_user_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_iam_member.cloudscanner_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.cloudscanner_workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.management_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.management_workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_organization.org](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_cloudscanners"></a> [enable\_cloudscanners](#input\_enable\_cloudscanners) | Enable the creation of cloud scanners. | `bool` | `false` | no |
| <a name="input_gcp_organization_id"></a> [gcp\_organization\_id](#input\_gcp\_organization\_id) | The GCP organization ID. | `string` | n/a | yes |
| <a name="input_google_service_account_display_name"></a> [google\_service\_account\_display\_name](#input\_google\_service\_account\_display\_name) | The display name for the service account. | `string` | `"Upwind Security Service Account"` | no |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | The suffix to append to all resources created by this module. | `string` | `""` | no |
| <a name="input_scanner_client_id"></a> [scanner\_client\_id](#input\_scanner\_client\_id) | The client ID used for authentication with the Upwind Cloudscanner Service. | `string` | `""` | no |
| <a name="input_scanner_client_secret"></a> [scanner\_client\_secret](#input\_scanner\_client\_secret) | The client secret for authentication with the Upwind Cloudscanner Service. | `string` | `""` | no |
| <a name="input_upwind_apis"></a> [upwind\_apis](#input\_upwind\_apis) | List of GCP APIs to enable for Upwind Operations. | `list(string)` | <pre>[<br/>  "cloudasset.googleapis.com",<br/>  "cloudresourcemanager.googleapis.com",<br/>  "compute.googleapis.com",<br/>  "iam.googleapis.com",<br/>  "container.googleapis.com",<br/>  "sts.googleapis.com"<br/>]</pre> | no |
| <a name="input_upwind_auth_endpoint"></a> [upwind\_auth\_endpoint](#input\_upwind\_auth\_endpoint) | The Authentication API endpoint. | `string` | `"https://oauth.upwind.io"` | no |
| <a name="input_upwind_client_id"></a> [upwind\_client\_id](#input\_upwind\_client\_id) | The client ID used for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_client_secret"></a> [upwind\_client\_secret](#input\_upwind\_client\_secret) | The client secret for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_cloudscanner_apis"></a> [upwind\_cloudscanner\_apis](#input\_upwind\_cloudscanner\_apis) | List of GCP APIs to enable for Upwind Cloud Scanners. | `list(string)` | <pre>[<br/>  "secretmanager.googleapis.com",<br/>  "iam.googleapis.com",<br/>  "iamcredentials.googleapis.com",<br/>  "compute.googleapis.com",<br/>  "run.googleapis.com",<br/>  "cloudscheduler.googleapis.com",<br/>  "cloudresourcemanager.googleapis.com"<br/>]</pre> | no |
| <a name="input_upwind_integration_endpoint"></a> [upwind\_integration\_endpoint](#input\_upwind\_integration\_endpoint) | The Integration API endpoint. | `string` | `"https://integration.upwind.io"` | no |
| <a name="input_upwind_orchestrator_project"></a> [upwind\_orchestrator\_project](#input\_upwind\_orchestrator\_project) | The main project where the resources are created. | `string` | n/a | yes |
| <a name="input_workload_identity_pool_project"></a> [workload\_identity\_pool\_project](#input\_workload\_identity\_pool\_project) | The project where the Workload Identity Federation pool is created. | `string` | `upwind_orchestrator_project` | no |
| <a name="input_upwind_organization_id"></a> [upwind\_organization\_id](#input\_upwind\_organization\_id) | The identifier of the Upwind organization to integrate with. | `string` | n/a | yes |
| <a name="input_upwind_posture_apis"></a> [upwind\_posture\_apis](#input\_upwind\_posture\_apis) | List of GCP APIs to enable for Upwind Posture. | `list(string)` | <pre>[<br/>  "accessapproval.googleapis.com",<br/>  "admin.googleapis.com",<br/>  "alloydb.googleapis.com",<br/>  "apikeys.googleapis.com",<br/>  "bigquery.googleapis.com",<br/>  "dataproc.googleapis.com",<br/>  "dns.googleapis.com",<br/>  "cloudfunctions.googleapis.com",<br/>  "cloudkms.googleapis.com",<br/>  "logging.googleapis.com",<br/>  "monitoring.googleapis.com",<br/>  "redis.googleapis.com",<br/>  "sqladmin.googleapis.com",<br/>  "storage.googleapis.com",<br/>  "essentialcontacts.googleapis.com",<br/>  "serviceusage.googleapis.com"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_upwind_management_service_account_display_name"></a> [upwind\_management\_service\_account\_display\_name](#output\_upwind\_management\_service\_account\_display\_name) | The display name of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_email"></a> [upwind\_management\_service\_account\_email](#output\_upwind\_management\_service\_account\_email) | The email address of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_name"></a> [upwind\_management\_service\_account\_name](#output\_upwind\_management\_service\_account\_name) | The name of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_project"></a> [upwind\_management\_service\_account\_project](#output\_upwind\_management\_service\_account\_project) | The project ID of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_unique_id"></a> [upwind\_management\_service\_account\_unique\_id](#output\_upwind\_management\_service\_account\_unique\_id) | The unique ID of the Upwind Management Service Account. |
<!-- END_TF_DOCS -->
