# Google Cloud Organization Onboarding Module

This Terraform module handles the onboarding of Google Cloud organizations to the Upwind platform, enabling users to
seamlessly connect their entire organization for comprehensive monitoring and security analysis.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.23.0, <= 6.35.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.4 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.35.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.5.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_organization_iam_custom_role.cloudscanner_cloud_run_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_custom_role.upwind_management_sa_iam_read_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_custom_role.upwind_management_sa_iam_write_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.cloudscanner_cloud_run_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_cloudscanner_sa_compute_viewer_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_cloudscanner_sa_storage_admin_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_management_sa_iam_read_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_management_sa_iam_write_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.upwind_management_sa_org_viewer_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project_iam_custom_role.cloudscanner_basic_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_scaler_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_secret_access_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_storage_delete_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.cloudscanner_sa_basic_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_sa_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_sa_token_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_sa_run_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_sa_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_secret_access_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_secret_access_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_cloudscanner_deployment_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_secret_access_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_token_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.enable_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_secret_manager_secret.scanner_client_id](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.scanner_client_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.scanner_client_id_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.scanner_client_secret_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.cloudscanner_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.cloudscanner_scaler_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.upwind_management_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.cloudscanner_scaler_sa_cloudscanner_sa_user_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_key.upwind_management_sa_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [null_resource.cleanup_patch_request](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upwind_patch_credentials_request](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.verify_patch_request](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [google_organization.org](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |
| [http_http.upwind_create_credentials_request](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.upwind_get_access_token_request](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.upwind_get_organizational_credentials_request](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [local_file.patch_response_body](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.patch_status_code](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_organizational_credentials"></a> [create\_organizational\_credentials](#input\_create\_organizational\_credentials) | Set to true to create organizational credentials for the organizations pending onboarding. Needs to be set to false before destroying module. | `bool` | `true` | no |
| <a name="input_enable_cloudscanners"></a> [enable\_cloudscanners](#input\_enable\_cloudscanners) | Enable the creation of cloud scanners. | `bool` | `false` | no |
| <a name="input_gcp_organization_id"></a> [gcp\_organization\_id](#input\_gcp\_organization\_id) | The GCP organization ID. | `string` | n/a | yes |
| <a name="input_google_service_account_display_name"></a> [google\_service\_account\_display\_name](#input\_google\_service\_account\_display\_name) | The display name for the service account. | `string` | `"Upwind Security Service Account"` | no |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | The suffix to append to all resources created by this module. | `string` | `""` | no |
| <a name="input_scanner_client_id"></a> [scanner\_client\_id](#input\_scanner\_client\_id) | The client ID used for authentication with the Upwind Cloudscanner Service. | `string` | `""` | no |
| <a name="input_scanner_client_secret"></a> [scanner\_client\_secret](#input\_scanner\_client\_secret) | The client secret for authentication with the Upwind Cloudscanner Service. | `string` | `""` | no |
| <a name="input_upwind_apis"></a> [upwind\_apis](#input\_upwind\_apis) | List of GCP APIs to enable for Upwind Operations. | `list(string)` | <pre>[<br/>  "cloudasset.googleapis.com",<br/>  "cloudresourcemanager.googleapis.com",<br/>  "compute.googleapis.com",<br/>  "iam.googleapis.com",<br/>  "container.googleapis.com"<br/>]</pre> | no |
| <a name="input_upwind_auth_endpoint"></a> [upwind\_auth\_endpoint](#input\_upwind\_auth\_endpoint) | The Authentication API endpoint. | `string` | `"https://oauth.upwind.io"` | no |
| <a name="input_upwind_client_id"></a> [upwind\_client\_id](#input\_upwind\_client\_id) | The client ID used for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_client_secret"></a> [upwind\_client\_secret](#input\_upwind\_client\_secret) | The client secret for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_cloudscanner_apis"></a> [upwind\_cloudscanner\_apis](#input\_upwind\_cloudscanner\_apis) | List of GCP APIs to enable for Upwind Cloud Scanners. | `list(string)` | <pre>[<br/>  "secretmanager.googleapis.com",<br/>  "iam.googleapis.com",<br/>  "iamcredentials.googleapis.com",<br/>  "compute.googleapis.com",<br/>  "run.googleapis.com",<br/>  "cloudscheduler.googleapis.com",<br/>  "cloudresourcemanager.googleapis.com"<br/>]</pre> | no |
| <a name="input_upwind_integration_endpoint"></a> [upwind\_integration\_endpoint](#input\_upwind\_integration\_endpoint) | The Integration API endpoint. | `string` | `"https://integration.upwind.io"` | no |
| <a name="input_upwind_orchestrator_project"></a> [upwind\_orchestrator\_project](#input\_upwind\_orchestrator\_project) | The main project where the resources are created. | `string` | n/a | yes |
| <a name="input_upwind_organization_id"></a> [upwind\_organization\_id](#input\_upwind\_organization\_id) | The identifier of the Upwind organization to integrate with. | `string` | n/a | yes |
| <a name="input_upwind_posture_apis"></a> [upwind\_posture\_apis](#input\_upwind\_posture\_apis) | List of GCP APIs to enable for Upwind Posture. | `list(string)` | <pre>[<br/>  "accessapproval.googleapis.com",<br/>  "admin.googleapis.com",<br/>  "alloydb.googleapis.com",<br/>  "apikeys.googleapis.com",<br/>  "bigquery.googleapis.com",<br/>  "dataproc.googleapis.com",<br/>  "dns.googleapis.com",<br/>  "cloudfunctions.googleapis.com",<br/>  "cloudkms.googleapis.com",<br/>  "logging.googleapis.com",<br/>  "monitoring.googleapis.com",<br/>  "redis.googleapis.com",<br/>  "sqladmin.googleapis.com",<br/>  "storage.googleapis.com",<br/>  "essentialcontacts.googleapis.com",<br/>  "serviceusage.googleapis.com"<br/>]</pre> | no |
| <a name="input_upwind_region"></a> [upwind\_region](#input\_upwind\_region) | Which Upwind region to communicate with. 'us' or 'eu' | `string` | `"us"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_org_creds"></a> [org\_creds](#output\_org\_creds) | The organizational credentials for the organizations pending onboarding. |
| <a name="output_pending_orgs"></a> [pending\_orgs](#output\_pending\_orgs) | The organizational credentials for the organizations pending onboarding. |
| <a name="output_upwind_management_service_account_display_name"></a> [upwind\_management\_service\_account\_display\_name](#output\_upwind\_management\_service\_account\_display\_name) | The display name of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_email"></a> [upwind\_management\_service\_account\_email](#output\_upwind\_management\_service\_account\_email) | The email address of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_name"></a> [upwind\_management\_service\_account\_name](#output\_upwind\_management\_service\_account\_name) | The name of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_project"></a> [upwind\_management\_service\_account\_project](#output\_upwind\_management\_service\_account\_project) | The project ID of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_unique_id"></a> [upwind\_management\_service\_account\_unique\_id](#output\_upwind\_management\_service\_account\_unique\_id) | The unique ID of the Upwind Management Service Account. |
<!-- END_TF_DOCS -->
