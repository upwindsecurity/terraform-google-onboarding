# Google Cloud Project Onboarding Example

This example demonstrates how to onboard a single Google Cloud project to the Upwind platform using the project
module with basic configuration.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.17 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_upwind_project_onboarding"></a> [upwind\_project\_onboarding](#module\_upwind\_project\_onboarding) | ../../modules/project | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.post_onboarding_setup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The GCP project ID where the service account was created |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | The email address of the created service account |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | The name of the created service account |
<!-- END_TF_DOCS -->
