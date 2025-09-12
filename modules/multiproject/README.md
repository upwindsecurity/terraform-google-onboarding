# Google Cloud Multiproject Onboarding Module

This Terraform module handles the onboarding of Google Cloud projects to the Upwind platform, enabling users to
seamlessly connect multiple projects for comprehensive monitoring and security analysis without needing organization level administrator access.

## APIs

The following APIs are required for Upwind operations. Please verify that they are enabled across the desired projects using the script available at https://docs.upwind.io/getting-started/connect-cloud-account/google/integration

### Required for Upwind operations

| API Name                                                                                    | Endpoint                              |
| ------------------------------------------------------------------------------------------- | ------------------------------------- |
| [Cloud Asset API](https://cloud.google.com/asset-inventory/docs/reference/rest)             | `cloudasset.googleapis.com`           |
| [Cloud Resource Manager API](https://cloud.google.com/resource-manager/reference/rest)      | `cloudresourcemanager.googleapis.com` |
| [Compute Engine API](https://cloud.google.com/compute/docs/reference/rest/v1)               | `compute.googleapis.com`              |
| [Identity and Access Management API](https://cloud.google.com/iam/docs/reference/rest)      | `iam.googleapis.com`                  |
| [Kubernetes Engine API](https://cloud.google.com/kubernetes-engine/docs/reference/rest)     | `container.googleapis.com`            |
| [Security Token Service API](https://cloud.google.com/iam/docs/reference/sts/rest)          | `sts.googleapis.com`                  |
| [Storage Insights API](https://cloud.google.com/storage/docs/insights/storage-insights-api) | `storageinsights.googleapis.com`      |

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
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.23.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.23.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam"></a> [iam](#module\_iam) | ../_shared/iam | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_custom_role.cloudscanner_cloud_run_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.snapshot_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.snapshot_deleter](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.snapshot_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.storage_object_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.storage_reader_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.upwind_management_sa_iam_read_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.cloudscanner_cloud_run_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_sa_storage_object_reader_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_sa_storage_reader_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_snapshot_creator_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_snapshot_deleter_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_snapshot_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.scaler_snapshot_creator_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.scaler_snapshot_deleter_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.scaler_snapshot_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_cloudscanner_sa_compute_viewer_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_asset_viewer_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_iam_read_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_project_viewer_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_storage_reader_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_cloudscanners"></a> [enable\_cloudscanners](#input\_enable\_cloudscanners) | Enable the creation of cloud scanners. | `bool` | `false` | no |
| <a name="input_enable_dspm"></a> [enable\_dspm](#input\_enable\_dspm) | Enable DSPM functionality | `bool` | `false` | no |
| <a name="input_google_service_account_display_name"></a> [google\_service\_account\_display\_name](#input\_google\_service\_account\_display\_name) | The display name for the service account. | `string` | `"Upwind Security Service Account"` | no |
| <a name="input_is_dev"></a> [is\_dev](#input\_is\_dev) | Flag to indicate if the environment is a development environment. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | The suffix to append to all resources created by this module. | `string` | `""` | no |
| <a name="input_scanner_client_id"></a> [scanner\_client\_id](#input\_scanner\_client\_id) | The client ID used for authentication with the Upwind Cloudscanner Service. | `string` | `""` | no |
| <a name="input_scanner_client_secret"></a> [scanner\_client\_secret](#input\_scanner\_client\_secret) | The client secret for authentication with the Upwind Cloudscanner Service. | `string` | `""` | no |
| <a name="input_target_project_ids"></a> [target\_project\_ids](#input\_target\_project\_ids) | List of project IDs to grant access to | `list(string)` | n/a | yes |
| <a name="input_upwind_client_id"></a> [upwind\_client\_id](#input\_upwind\_client\_id) | The client ID used for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_client_secret"></a> [upwind\_client\_secret](#input\_upwind\_client\_secret) | The client secret for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_orchestrator_project"></a> [upwind\_orchestrator\_project](#input\_upwind\_orchestrator\_project) | The orchestrator project where Upwind resources are created. | `string` | n/a | yes |
| <a name="input_upwind_organization_id"></a> [upwind\_organization\_id](#input\_upwind\_organization\_id) | The identifier of the Upwind organization to integrate with. | `string` | n/a | yes |
| <a name="input_workload_identity_pool_project"></a> [workload\_identity\_pool\_project](#input\_workload\_identity\_pool\_project) | The project where the workload identity pool is created. Defaults to the orchestrator project if not specified. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_upwind_management_service_account_display_name"></a> [upwind\_management\_service\_account\_display\_name](#output\_upwind\_management\_service\_account\_display\_name) | The display name of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_email"></a> [upwind\_management\_service\_account\_email](#output\_upwind\_management\_service\_account\_email) | The email address of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_name"></a> [upwind\_management\_service\_account\_name](#output\_upwind\_management\_service\_account\_name) | The name of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_project"></a> [upwind\_management\_service\_account\_project](#output\_upwind\_management\_service\_account\_project) | The project ID of the Upwind Management Service Account. |
| <a name="output_upwind_management_service_account_unique_id"></a> [upwind\_management\_service\_account\_unique\_id](#output\_upwind\_management\_service\_account\_unique\_id) | The unique ID of the Upwind Management Service Account. |
| <a name="output_upwind_workload_identity_pool_id"></a> [upwind\_workload\_identity\_pool\_id](#output\_upwind\_workload\_identity\_pool\_id) | The ID of the Upwind Workload Identity Pool. |
| <a name="output_workload_identity_provider_name"></a> [workload\_identity\_provider\_name](#output\_workload\_identity\_provider\_name) | Full path name of the workload identity pool provider |

<!-- END_TF_DOCS -->
