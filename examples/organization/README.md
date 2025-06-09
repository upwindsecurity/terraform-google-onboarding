# Google Cloud Organization Onboarding Example

This example demonstrates how to onboard an entire Google Cloud organization to the Upwind platform, including
organization-level setup and multiple project onboarding scenarios with conditional deployments.

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
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_upwind_organization_onboarding"></a> [upwind\_organization\_onboarding](#module\_upwind\_organization\_onboarding) | ../../modules/organization | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.post_onboarding_setup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_optional_resources"></a> [create\_optional\_resources](#input\_create\_optional\_resources) | Whether to create optional resources like staging environment | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_organization_onboarded"></a> [organization\_onboarded](#output\_organization\_onboarded) | Whether the organization was successfully onboarded |
| <a name="output_organization_service_account_email"></a> [organization\_service\_account\_email](#output\_organization\_service\_account\_email) | The email address of the organization service account |
| <a name="output_organization_service_account_name"></a> [organization\_service\_account\_name](#output\_organization\_service\_account\_name) | The name of the organization service account |
| <a name="output_organization_service_account_unique_id"></a> [organization\_service\_account\_unique\_id](#output\_organization\_service\_account\_unique\_id) | The unique ID of the organization service account |
| <a name="output_organizational_credentials"></a> [organizational\_credentials](#output\_organizational\_credentials) | The organizational credentials for pending onboarding |
| <a name="output_pending_organizations"></a> [pending\_organizations](#output\_pending\_organizations) | The organizations pending onboarding |
| <a name="output_post_onboarding_setup_completed"></a> [post\_onboarding\_setup\_completed](#output\_post\_onboarding\_setup\_completed) | Whether post-onboarding setup was completed (if optional resources were created) |
<!-- END_TF_DOCS -->
