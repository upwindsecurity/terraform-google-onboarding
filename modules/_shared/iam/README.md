# Shared IAM Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.23.0, < 8.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 7.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.aws](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_iam_binding.cloudscanner_disk_writer_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_custom_role.cloudscanner_basic_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_instance_template_mgmt_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_instance_template_test_creation_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_scaler_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cloudscanner_secret_access_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.compute_service_agent_minimal](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.disk_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.upwind_management_sa_cloudscanner_deployment_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.cloudrun_service_agent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_instance_template_mgmt_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_instance_template_test_creation_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_sa_basic_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_sa_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_sa_run_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_sa_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_scaler_secret_access_scaler_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudscanner_secret_access_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.compute_service_agent_minimal](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_cloudscanner_deployment_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.upwind_management_sa_secret_access_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_secret_manager_secret.scanner_client_id](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.scanner_client_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.terraform_labels](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.upwind_client_id](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.upwind_client_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_iam_member.terraform_labels_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam_member) | resource |
| [google_secret_manager_secret_version.scanner_client_id_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.scanner_client_secret_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.terraform_labels_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.upwind_client_id_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.upwind_client_secret_v1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.cloudscanner_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.cloudscanner_scaler_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.upwind_management_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.scaler_and_compute_can_use_cloudscanner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_iam_member.cloudscanner_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.cloudscanner_workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.cloudscheduler_can_impersonate_scaler](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.management_can_impersonate_scaler](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.management_can_impersonate_scanner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.management_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.management_workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.scaler_can_impersonate_scanner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.scanner_can_impersonate_scaler](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_run_permissions"></a> [cloud\_run\_permissions](#input\_cloud\_run\_permissions) | List of IAM permissions for Cloud Run roles. | `list(string)` | <pre>[<br/>  "artifactregistry.repositories.downloadArtifacts",<br/>  "artifactregistry.dockerimages.get"<br/>]</pre> | no |
| <a name="input_cloudscanner_basic_permissions"></a> [cloudscanner\_basic\_permissions](#input\_cloudscanner\_basic\_permissions) | List of IAM permissions for basic CloudScanner operations. | `list(string)` | <pre>[<br/>  "compute.disks.createSnapshot",<br/>  "compute.disks.get",<br/>  "compute.disks.list",<br/>  "compute.instances.attachDisk",<br/>  "compute.instances.detachDisk",<br/>  "compute.instances.get",<br/>  "compute.instances.list",<br/>  "compute.snapshots.get",<br/>  "compute.snapshots.setLabels",<br/>  "compute.snapshots.useReadOnly",<br/>  "compute.zoneOperations.get",<br/>  "compute.globalOperations.get",<br/>  "iam.serviceAccounts.actAs",<br/>  "run.executions.list"<br/>]</pre> | no |
| <a name="input_cloudscanner_instance_template_mgmt_permissions"></a> [cloudscanner\_instance\_template\_mgmt\_permissions](#input\_cloudscanner\_instance\_template\_mgmt\_permissions) | List of IAM permissions for CloudScanner instance template management. | `list(string)` | <pre>[<br/>  "compute.instanceTemplates.get",<br/>  "compute.instanceTemplates.create",<br/>  "compute.instanceTemplates.delete",<br/>  "compute.instanceTemplates.useReadOnly"<br/>]</pre> | no |
| <a name="input_cloudscanner_instance_template_test_creation_permissions"></a> [cloudscanner\_instance\_template\_test\_creation\_permissions](#input\_cloudscanner\_instance\_template\_test\_creation\_permissions) | List of IAM permissions for CloudScanner instance template test creation. | `list(string)` | <pre>[<br/>  "compute.instances.create",<br/>  "compute.instances.setMetadata",<br/>  "compute.instances.setLabels",<br/>  "compute.disks.create"<br/>]</pre> | no |
| <a name="input_cloudscanner_scaler_permissions"></a> [cloudscanner\_scaler\_permissions](#input\_cloudscanner\_scaler\_permissions) | List of IAM permissions for CloudScanner Scaler operations. | `list(string)` | <pre>[<br/>  "compute.instanceGroups.get",<br/>  "compute.instanceGroups.list",<br/>  "compute.instanceGroups.update",<br/>  "compute.instanceGroupManagers.get",<br/>  "compute.instanceGroupManagers.list",<br/>  "compute.instanceGroupManagers.update",<br/>  "compute.zoneOperations.get",<br/>  "compute.globalOperations.get",<br/>  "compute.subnetworks.get",<br/>  "compute.subnetworks.use"<br/>]</pre> | no |
| <a name="input_cloudscanner_secret_access_permissions"></a> [cloudscanner\_secret\_access\_permissions](#input\_cloudscanner\_secret\_access\_permissions) | List of IAM permissions for CloudScanner secret access. | `list(string)` | <pre>[<br/>  "secretmanager.versions.access",<br/>  "secretmanager.versions.get",<br/>  "secretmanager.versions.list",<br/>  "secretmanager.secrets.get",<br/>  "secretmanager.secrets.list"<br/>]</pre> | no |
| <a name="input_compute_service_agent_minimal_permissions"></a> [compute\_service\_agent\_minimal\_permissions](#input\_compute\_service\_agent\_minimal\_permissions) | List of IAM permissions for minimal compute service agent role. | `list(string)` | <pre>[<br/>  "compute.disks.create",<br/>  "compute.disks.use",<br/>  "compute.instances.create",<br/>  "compute.instances.use",<br/>  "compute.instances.delete",<br/>  "compute.instances.setLabels",<br/>  "compute.instances.setTags",<br/>  "compute.instances.setMetadata",<br/>  "compute.instances.setServiceAccount",<br/>  "compute.subnetworks.use",<br/>  "compute.instanceGroups.update"<br/>]</pre> | no |
| <a name="input_default_labels"></a> [default\_labels](#input\_default\_labels) | Default labels applied to all resources (can be overridden) | `map(string)` | <pre>{<br/>  "component": "upwind",<br/>  "managed_by": "terraform"<br/>}</pre> | no |
| <a name="input_deployment_permissions"></a> [deployment\_permissions](#input\_deployment\_permissions) | List of IAM permissions for deployment operations. | `list(string)` | <pre>[<br/>  "compute.instanceTemplates.create",<br/>  "compute.instanceTemplates.delete",<br/>  "compute.instanceTemplates.get",<br/>  "compute.instanceTemplates.useReadOnly",<br/>  "compute.instanceGroupManagers.create",<br/>  "compute.instanceGroupManagers.delete",<br/>  "compute.instanceGroupManagers.get",<br/>  "compute.instanceGroupManagers.update",<br/>  "compute.instanceGroups.delete",<br/>  "compute.instances.create",<br/>  "compute.instances.delete",<br/>  "compute.instances.get",<br/>  "compute.instances.setMetadata",<br/>  "compute.instances.setTags",<br/>  "compute.instances.setLabels",<br/>  "compute.disks.create",<br/>  "compute.disks.get",<br/>  "compute.disks.delete",<br/>  "compute.zones.list",<br/>  "compute.networks.create",<br/>  "compute.networks.get",<br/>  "compute.networks.updatePolicy",<br/>  "compute.networks.delete",<br/>  "compute.subnetworks.create",<br/>  "compute.subnetworks.get",<br/>  "compute.subnetworks.use",<br/>  "compute.subnetworks.delete",<br/>  "compute.routers.create",<br/>  "compute.routers.get",<br/>  "compute.routers.update",<br/>  "compute.routers.delete",<br/>  "compute.firewalls.create",<br/>  "compute.firewalls.get",<br/>  "compute.firewalls.delete",<br/>  "run.jobs.create",<br/>  "run.jobs.get",<br/>  "run.jobs.update",<br/>  "run.jobs.delete",<br/>  "run.operations.get",<br/>  "run.operations.list",<br/>  "run.executions.get",<br/>  "run.executions.list",<br/>  "cloudscheduler.jobs.create",<br/>  "cloudscheduler.jobs.get",<br/>  "cloudscheduler.jobs.enable",<br/>  "cloudscheduler.jobs.delete",<br/>  "resourcemanager.projects.getIamPolicy",<br/>  "resourcemanager.projects.setIamPolicy",<br/>  "iam.serviceAccounts.get",<br/>  "iam.serviceAccounts.actAs",<br/>  "iam.serviceAccounts.getIamPolicy",<br/>  "iam.serviceAccounts.setIamPolicy",<br/>  "compute.regionOperations.get",<br/>  "serviceusage.services.use"<br/>]</pre> | no |
| <a name="input_disk_writer_permissions"></a> [disk\_writer\_permissions](#input\_disk\_writer\_permissions) | List of IAM permissions for disk writer role. | `list(string)` | <pre>[<br/>  "compute.disks.create",<br/>  "compute.disks.delete",<br/>  "compute.disks.setLabels",<br/>  "compute.disks.use"<br/>]</pre> | no |
| <a name="input_enable_cloudscanners"></a> [enable\_cloudscanners](#input\_enable\_cloudscanners) | Enable CloudScanner resources | `bool` | `true` | no |
| <a name="input_google_service_account_display_name"></a> [google\_service\_account\_display\_name](#input\_google\_service\_account\_display\_name) | Display name for the management service account | `string` | n/a | yes |
| <a name="input_iam_read_role_permissions"></a> [iam\_read\_role\_permissions](#input\_iam\_read\_role\_permissions) | List of IAM permissions for read-only access across GCP services. | `list(string)` | <pre>[<br/>  "iam.serviceAccounts.get",<br/>  "iam.serviceAccounts.list",<br/>  "iam.serviceAccountKeys.get",<br/>  "iam.serviceAccountKeys.list",<br/>  "resourcemanager.projects.getIamPolicy",<br/>  "iam.roles.get",<br/>  "iam.roles.list"<br/>]</pre> | no |
| <a name="input_is_dev"></a> [is\_dev](#input\_is\_dev) | Flag to indicate if the environment is a development environment. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | The suffix to append to all resources created by this module. | `string` | `""` | no |
| <a name="input_scanner_client_id"></a> [scanner\_client\_id](#input\_scanner\_client\_id) | The client ID used for authentication with the Upwind Cloudscanner Service. | `string` | `""` | no |
| <a name="input_scanner_client_secret"></a> [scanner\_client\_secret](#input\_scanner\_client\_secret) | The client secret for authentication with the Upwind Cloudscanner Service. | `string` | `""` | no |
| <a name="input_snapshot_creator_permissions"></a> [snapshot\_creator\_permissions](#input\_snapshot\_creator\_permissions) | List of IAM permissions for creating and deleting snapshots. | `list(string)` | <pre>[<br/>  "compute.snapshots.create",<br/>  "compute.snapshots.setLabels",<br/>  "compute.snapshots.useReadOnly"<br/>]</pre> | no |
| <a name="input_snapshot_deleter_permissions"></a> [snapshot\_deleter\_permissions](#input\_snapshot\_deleter\_permissions) | List of IAM permissions for deleting snapshots. | `list(string)` | <pre>[<br/>  "compute.snapshots.delete"<br/>]</pre> | no |
| <a name="input_snapshot_reader_permissions"></a> [snapshot\_reader\_permissions](#input\_snapshot\_reader\_permissions) | List of IAM permissions for reading snapshots. | `list(string)` | <pre>[<br/>  "compute.disks.get",<br/>  "compute.disks.list",<br/>  "compute.disks.createSnapshot",<br/>  "compute.snapshots.get",<br/>  "compute.snapshots.list",<br/>  "compute.instances.get",<br/>  "compute.instances.list",<br/>  "compute.diskTypes.get",<br/>  "compute.diskTypes.list",<br/>  "compute.projects.get",<br/>  "resourcemanager.projects.get",<br/>  "compute.zoneOperations.get",<br/>  "compute.globalOperations.get",<br/>  "compute.regionOperations.get"<br/>]</pre> | no |
| <a name="input_storage_object_reader_permissions"></a> [storage\_object\_reader\_permissions](#input\_storage\_object\_reader\_permissions) | List of IAM permissions for storage object reader role. | `list(string)` | <pre>[<br/>  "storage.objects.get",<br/>  "storage.buckets.get",<br/>  "storage.buckets.list"<br/>]</pre> | no |
| <a name="input_storage_read_permissions"></a> [storage\_read\_permissions](#input\_storage\_read\_permissions) | List of IAM permissions for storage read access. | `list(string)` | <pre>[<br/>  "storage.buckets.get",<br/>  "storage.buckets.getIamPolicy",<br/>  "storage.buckets.getIpFilter",<br/>  "storage.buckets.list",<br/>  "storage.buckets.listEffectiveTags",<br/>  "storage.buckets.listTagBindings",<br/>  "storage.bucketOperations.get",<br/>  "storage.bucketOperations.list",<br/>  "storage.folders.get",<br/>  "storage.folders.list",<br/>  "storage.managedFolders.get",<br/>  "storage.managedFolders.getIamPolicy",<br/>  "storage.managedFolders.list",<br/>  "storage.objects.getIamPolicy",<br/>  "storage.objects.list"<br/>]</pre> | no |
| <a name="input_upwind_client_id"></a> [upwind\_client\_id](#input\_upwind\_client\_id) | The client ID used for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_client_secret"></a> [upwind\_client\_secret](#input\_upwind\_client\_secret) | The client secret for authentication with the Upwind Authorization Service. | `string` | n/a | yes |
| <a name="input_upwind_orchestrator_project"></a> [upwind\_orchestrator\_project](#input\_upwind\_orchestrator\_project) | The orchestrator project where Upwind resources are created. | `string` | n/a | yes |
| <a name="input_upwind_organization_id"></a> [upwind\_organization\_id](#input\_upwind\_organization\_id) | The identifier of the Upwind organization to integrate with. | `string` | n/a | yes |
| <a name="input_workload_identity_pool_project"></a> [workload\_identity\_pool\_project](#input\_workload\_identity\_pool\_project) | The project where the workload identity pool is created. Defaults to the orchestrator project if not specified. | `string` | `""` | no |
| <a name="input_workload_identity_trusted_account"></a> [workload\_identity\_trusted\_account](#input\_workload\_identity\_trusted\_account) | The account ID of the trusted account for Workload Identity Federation. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_run_permissions"></a> [cloud\_run\_permissions](#output\_cloud\_run\_permissions) | List of IAM permissions for Cloud Run role. |
| <a name="output_cloudscanner_sa"></a> [cloudscanner\_sa](#output\_cloudscanner\_sa) | The Cloudscanner Service Account details. |
| <a name="output_cloudscanner_scaler_sa"></a> [cloudscanner\_scaler\_sa](#output\_cloudscanner\_scaler\_sa) | The Cloudscanner Scaler Service Account details. |
| <a name="output_default_labels"></a> [default\_labels](#output\_default\_labels) | Default labels applied to all resources (can be overridden). |
| <a name="output_google_iam_workload_identity_pool"></a> [google\_iam\_workload\_identity\_pool](#output\_google\_iam\_workload\_identity\_pool) | The Workload Identity Pool created. |
| <a name="output_google_iam_workload_identity_pool_provider"></a> [google\_iam\_workload\_identity\_pool\_provider](#output\_google\_iam\_workload\_identity\_pool\_provider) | The Workload Identity Pool Provider created. |
| <a name="output_google_project_iam_binding"></a> [google\_project\_iam\_binding](#output\_google\_project\_iam\_binding) | The IAM bindings at the project level. |
| <a name="output_google_project_iam_custom_role"></a> [google\_project\_iam\_custom\_role](#output\_google\_project\_iam\_custom\_role) | The custom IAM roles created at the project level. |
| <a name="output_google_project_iam_member"></a> [google\_project\_iam\_member](#output\_google\_project\_iam\_member) | The IAM role bindings at the project level. |
| <a name="output_google_secret_manager_secret"></a> [google\_secret\_manager\_secret](#output\_google\_secret\_manager\_secret) | The secrets created in Secret Manager. |
| <a name="output_google_service_account_iam_binding"></a> [google\_service\_account\_iam\_binding](#output\_google\_service\_account\_iam\_binding) | The IAM bindings for service accounts. |
| <a name="output_iam_read_role_permissions"></a> [iam\_read\_role\_permissions](#output\_iam\_read\_role\_permissions) | List of IAM permissions for read-only access role. |
| <a name="output_labels"></a> [labels](#output\_labels) | Labels applied to all resources. |
| <a name="output_snapshot_creator_permissions"></a> [snapshot\_creator\_permissions](#output\_snapshot\_creator\_permissions) | List of IAM permissions for snapshot creator role. |
| <a name="output_snapshot_deleter_permissions"></a> [snapshot\_deleter\_permissions](#output\_snapshot\_deleter\_permissions) | List of IAM permissions for snapshot deleter role. |
| <a name="output_snapshot_reader_permissions"></a> [snapshot\_reader\_permissions](#output\_snapshot\_reader\_permissions) | List of IAM permissions for snapshot reader role. |
| <a name="output_storage_object_reader_permissions"></a> [storage\_object\_reader\_permissions](#output\_storage\_object\_reader\_permissions) | List of IAM permissions for storage object reader role. |
| <a name="output_storage_read_permissions"></a> [storage\_read\_permissions](#output\_storage\_read\_permissions) | List of IAM permissions for storage read access. |
| <a name="output_upwind_management_sa"></a> [upwind\_management\_sa](#output\_upwind\_management\_sa) | The Upwind Management Service Account details. |
<!-- END_TF_DOCS -->
