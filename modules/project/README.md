# # Google Cloud Project Onboarding Module

This Terraform module handles the onboarding of individual Google Cloud projects to the Upwind platform, enabling
users to seamlessly connect their projects for monitoring and security analysis.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.17 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.38.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.pam](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.sak](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [random_id.uid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [http_http.upwind_create_credentials_request](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.upwind_get_access_token_request](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_service_account_display_name"></a> [google\_service\_account\_display\_name](#input\_google\_service\_account\_display\_name) | The display name for the service account. | `string` | `"Upwind Security Service Account"` | no |
| <a name="input_google_service_account_id_prefix"></a> [google\_service\_account\_id\_prefix](#input\_google\_service\_account\_id\_prefix) | The prefix of the service account ID. Changing this forces a new service account to be created. | `string` | `"upwind"` | no |
| <a name="input_google_service_account_roles"></a> [google\_service\_account\_roles](#input\_google\_service\_account\_roles) | The roles that should be attached to the service account. | `list(string)` | <pre>[<br/>  "roles/viewer"<br/>]</pre> | no |
| <a name="input_upwind_auth_endpoint"></a> [upwind\_auth\_endpoint](#input\_upwind\_auth\_endpoint) | The Authentication API endpoint. | `string` | `"https://auth.upwind.io"` | no |
| <a name="input_upwind_client_id"></a> [upwind\_client\_id](#input\_upwind\_client\_id) | The client ID used for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_client_secret"></a> [upwind\_client\_secret](#input\_upwind\_client\_secret) | The client secret for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_integration_endpoint"></a> [upwind\_integration\_endpoint](#input\_upwind\_integration\_endpoint) | The Integration API endpoint. | `string` | `"https://integration.upwind.io"` | no |
| <a name="input_upwind_organization_id"></a> [upwind\_organization\_id](#input\_upwind\_organization\_id) | The identifier of the Upwind organization to integrate with. | `string` | n/a | yes |
| <a name="input_upwind_region"></a> [upwind\_region](#input\_upwind\_region) | Which Upwind region to communicate with. 'us' or 'eu' | `string` | `"us"` | no |
| <a name="input_upwind_skip_http"></a> [upwind\_skip\_http](#input\_upwind\_skip\_http) | Controls whether HTTP requests should be skipped. Affects all HTTP requests. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_google_service_account_display_name"></a> [google\_service\_account\_display\_name](#output\_google\_service\_account\_display\_name) | The display name of the service account. |
| <a name="output_google_service_account_email"></a> [google\_service\_account\_email](#output\_google\_service\_account\_email) | The email address of the service account. |
| <a name="output_google_service_account_name"></a> [google\_service\_account\_name](#output\_google\_service\_account\_name) | The fully-qualified name of the service account. |
| <a name="output_google_service_account_project"></a> [google\_service\_account\_project](#output\_google\_service\_account\_project) | The project ID of the service account. |
| <a name="output_google_service_account_unique_id"></a> [google\_service\_account\_unique\_id](#output\_google\_service\_account\_unique\_id) | The unique ID of the service account. |
<!-- END_TF_DOCS -->
