<!-- BEGIN_TF_DOCS -->
## AI Reference Implementation Baseline Pattern Module

### Overview

The AI Reference Implementation Baseline Pattern Module provides a secure, observable by default, scalable, and highly configurable foundation for deploying AI workloads on Azure. This pattern module integrates multiple Azure resources, following best practices and architectural standards, to deliver a comprehensive AI Reference Implementation. The goal is to accelerate the deployment of AI solutions by providing a ready-to-use infrastructure that adheres to Azure's Well-Architected Framework.

This pattern module is opinionated, meaning it comes with pre-configured defaults for security, observability, and essential AI resources. However, it remains flexible, allowing users to customize the environment to meet specific project needs by enabling or disabling various components.

### Architecture

The pattern module is designed to be modular and composable. The default deployment includes a minimum set of resources required to establish a secure and observable AI environment, but additional resources can be added based on project requirements. Below is a high-level architecture diagram:

![AI Reference Implementation Baseline Architecture](./media/ai-reference-implementation-architecture.png)

## Architecture Design Record

Refer to the [ADR](./adr.md)

### Key Features and Goals

This AI Reference Implementation pattern module is designed to accelerate the deployment of AI solutions on Azure, while ensuring security, compliance, flexibility, and observability. The primary objectives and functionalities of this module include:

1. **Security by Default:** Ensuring that all deployed resources adhere to Azure's security best practices, including network isolation, encryption, and identity management. This guarantees that AI environments are secure from the outset. For more details, see [Security practices](./security\_practices.md).
    
2. **Observability:** Providing out-of-the-box integration of logging, monitoring, and alerting, making the AI environment fully observable from day one. This ensures that all deployments are transparent and issues can be quickly identified and resolved. More details are available in [Observability practices](./observability\_practices.md).
    
3. **Modular and Flexible Design:** Composed of several modules that can be individually enabled or disabled, this pattern offers a flexible architecture that can be tailored to specific project needs. This modular approach allows teams to start with a minimal setup and expand as required, ensuring the AI environment is scalable and adaptable.
    
4. **Compliance with Azure Best Practices:** Adhering to the recommendations of the Azure Well-Architected Framework, this module ensures that all resources and configurations are optimized for performance, reliability, security, and cost management.
    
5. **Rapid Deployment and Consistency:** By providing a standardized reference implementation, this module accelerates the deployment process and ensures consistency across different projects and teams. This reduces variability and guarantees that best practices are consistently applied in all AI environments.

### Usage

This pattern module is designed for both data scientists and engineers who need to quickly stand up a secure, scalable AI environment on Azure. It is also suitable for organizations that require a compliant and secure environment for their AI workloads with the flexibility to customize the setup based on project-specific needs.

#### Example Usage

To deploy the AI Reference Implementation Baseline with minimal configuration:

```hcl
module "ai_reference_implementation" {
  source  = "Azure/avm-ptn-ai-reference-implementation/azurerm"
  version = "x.x.x"

  resource_group_name = "<your_resource_group>"
  location            = "<your_location>"
  jumpbox = {
    create = true
  }
}
```

This example sets up the AI Reference Implementation with all default resources and a jumpbox so you can access your workspace from the virtual network. The username is `azureuser` and the password is generated and can be found in the tfstate file but you may need to reset from the portal. The following default configuration is used for the jumpbox VM creation if enabled and can be updated for your needs.

If you need an easy way to get a list of available VM sizes in a specific region and availability zone:

```sh
# The following is a simple command will list Standard_D VM sizes and have no restrictions in southcentralus region
az vm list-skus -l southcentralus --size Standard_D -o table | grep None
```

```
{
  os_type = "Windows"
  size = "Standard_D4s_v3"
  zone = "1"
  accelerated_networking_enabled = false
  image_ref = {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-ent"
    version   = "latest"
  }
}    
```

### Use Cases

This module is ideal for:

* **Data Scientists:** Who need a secure, scalable, and integrated environment to experiment, develop, and train machine learning models.
* **ML Engineers:** Looking to deploy machine learning models into production with robust monitoring, scaling, and management capabilities.
* **Organizations:** That require a compliant and secure environment for their machine learning workloads, with the flexibility to integrate with existing Azure services.

### Extending the Pattern Module

The AI Reference Implementation Baseline Pattern Module is designed to be extended. You can add additional resources or services by integrating other Azure Verified Modules (AVM). For example, you can include additional machine learning environments, data lakes, or advanced AI services by simply integrating their respective modules and configuring them within the pattern module.

### Additional Resources

* **Azure Well-Architected Framework:** [Azure WAF](https://learn.microsoft.com/en-us/azure/architecture/framework/)
* **Azure AI Documentation:** [Azure AI Services](https://learn.microsoft.com/en-us/azure/ai-services/)
* **Terraform Registry:** Terraform AzureRM Provider

### Contributing

This module is part of the Azure Verified Modules (AVM) ecosystem, and contributions are welcome. Please follow the standard contribution guidelines if you wish to submit enhancements or report issues.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.7)

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (>= 2.53, < 3.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.114.0, < 4.0.0)

- <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) (~> 0.3)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

## Resources

The following resources are used by this module:

- [azuread_group.akv_secret_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) (resource)
- [azuread_group.aml_workspace_ds](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) (resource)
- [azuread_group.aml_workspace_ml_operator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) (resource)
- [azuread_group.user_adlsgen_data_contrib](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) (resource)
- [azuread_group.user_sql_storage_external](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) (resource)
- [azuread_group.user_storage_mvnet](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) (resource)
- [azuread_group_member.akv_secret_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) (resource)
- [azuread_group_member.aml_workspace_ds](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) (resource)
- [azuread_group_member.aml_workspace_ml_operator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) (resource)
- [azuread_group_member.user_adlsgen_data_contrib](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) (resource)
- [azuread_group_member.user_sql_storage_external](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) (resource)
- [azuread_group_member.user_storage_mvnet](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) (resource)
- [azurerm_application_insights_workbook.avm_ootb_workbook](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_workbook) (resource)
- [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) (resource)
- [azurerm_monitor_diagnostic_setting.diag_setting_resource_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_monitor_diagnostic_setting.diag_setting_resources](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_private_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) (resource)
- [azurerm_public_ip.bastion_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) (resource)
- [azurerm_role_assignment.akv_secret_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.aml_workspace_ds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.aml_workspace_ml_operator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.user_adlsgen_data_contrib](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.user_sql_storage_external](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.user_storage_mvnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_security_center_subscription_pricing.mdc_arm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) (resource)
- [azurerm_security_center_subscription_pricing.mdc_containerregistry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) (resource)
- [azurerm_security_center_subscription_pricing.mdc_cspm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) (resource)
- [azurerm_security_center_subscription_pricing.mdc_keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) (resource)
- [azurerm_security_center_subscription_pricing.mdc_servers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) (resource)
- [azurerm_security_center_subscription_pricing.mdc_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) (resource)
- [azurerm_subscription_policy_assignment.mcsb_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) (resource)
- [modtm_telemetry.telemetry](https://registry.terraform.io/providers/Azure/modtm/latest/docs/resources/telemetry) (resource)
- [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) (resource)
- [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [azurerm_client_config.telemetry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [azurerm_resource_group.base](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)
- [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) (data source)
- [modtm_module_source.telemetry](https://registry.terraform.io/providers/Azure/modtm/latest/docs/data-sources/module_source) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_location"></a> [location](#input\_location)

Description: The location/region where the resources will be deployed.

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the this resource.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The resource group where the resources will be deployed.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_adlsgen_data_contrib_users"></a> [adlsgen\_data\_contrib\_users](#input\_adlsgen\_data\_contrib\_users)

Description: List of user object ids to add to the ADLSgen Data Contributor group

Type: `list(string)`

Default: `[]`

### <a name="input_aisearch_allowed_ips"></a> [aisearch\_allowed\_ips](#input\_aisearch\_allowed\_ips)

Description: A list of IP addresses that are allowed to access the Azure Cognitive Search service.

Type: `list(string)`

Default: `[]`

### <a name="input_aisearch_hosting_mode"></a> [aisearch\_hosting\_mode](#input\_aisearch\_hosting\_mode)

Description: (Optional) Specifies the Hosting Mode, which allows for High Density partitions (that allow for up to 1000 indexes) should be supported. Possible values are `highDensity` or `default`. Defaults to `default`. Changing this forces a new Search Service to be created.

Type: `string`

Default: `null`

### <a name="input_aisearch_local_authentication_enabled"></a> [aisearch\_local\_authentication\_enabled](#input\_aisearch\_local\_authentication\_enabled)

Description: Controls whether or not local authentication is enabled for the Azure Cognitive Search service.

Type: `bool`

Default: `false`

### <a name="input_aisearch_name"></a> [aisearch\_name](#input\_aisearch\_name)

Description: The name of the Azure Cognitive Search service. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_aisearch_partition_count"></a> [aisearch\_partition\_count](#input\_aisearch\_partition\_count)

Description: Partitions allow for scaling of document count as well as faster indexing by sharding your index over multiple search units.

Type: `number`

Default: `1`

### <a name="input_aisearch_public_network_access_enabled"></a> [aisearch\_public\_network\_access\_enabled](#input\_aisearch\_public\_network\_access\_enabled)

Description: Controls whether or not the Azure Cognitive Search service is accessible from the public internet.

Type: `bool`

Default: `false`

### <a name="input_aisearch_replica_count"></a> [aisearch\_replica\_count](#input\_aisearch\_replica\_count)

Description: Replicas distribute search workloads across the service. You need at least two replicas to support high availability of query workloads (not applicable to the free tier).

Type: `number`

Default: `1`

### <a name="input_aisearch_semantic_search_sku"></a> [aisearch\_semantic\_search\_sku](#input\_aisearch\_semantic\_search\_sku)

Description: (Optional) Specifies the Semantic Search SKU which should be used for this Search Service. Possible values include `free` and `standard`.

Type: `string`

Default: `null`

### <a name="input_aisearch_sku"></a> [aisearch\_sku](#input\_aisearch\_sku)

Description: The SKU of the Azure Cognitive Search service.

Type: `string`

Default: `"basic"`

### <a name="input_akv_secret_admin_users"></a> [akv\_secret\_admin\_users](#input\_akv\_secret\_admin\_users)

Description: List of user object ids to add to the AKV Secret Admin group

Type: `list(string)`

Default: `[]`

### <a name="input_aml_workspace_ds_users"></a> [aml\_workspace\_ds\_users](#input\_aml\_workspace\_ds\_users)

Description: List of user object ids to add to the AML Workspace DS group

Type: `list(string)`

Default: `[]`

### <a name="input_aml_workspace_ml_operator_users"></a> [aml\_workspace\_ml\_operator\_users](#input\_aml\_workspace\_ml\_operator\_users)

Description: List of user object ids to add to the AML Workspace ML Operator group

Type: `list(string)`

Default: `[]`

### <a name="input_azure_bastion_subnet_address_spaces"></a> [azure\_bastion\_subnet\_address\_spaces](#input\_azure\_bastion\_subnet\_address\_spaces)

Description: The address space that is used for the Azure Bastion subnet

Type: `list(string)`

Default:

```json
[
  "10.1.3.0/24"
]
```

### <a name="input_bastion_copy_paste_enabled"></a> [bastion\_copy\_paste\_enabled](#input\_bastion\_copy\_paste\_enabled)

Description: Specifies whether copy-paste functionality is enabled for the Azure Bastion Host.

Type: `bool`

Default: `true`

### <a name="input_bastion_file_copy_enabled"></a> [bastion\_file\_copy\_enabled](#input\_bastion\_file\_copy\_enabled)

Description: Specifies whether file copy functionality is enabled for the Azure Bastion Host.

Type: `bool`

Default: `false`

### <a name="input_bastion_name"></a> [bastion\_name](#input\_bastion\_name)

Description: The name of the Azure Bastion resource. if not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_bastion_network_security_group_name"></a> [bastion\_network\_security\_group\_name](#input\_bastion\_network\_security\_group\_name)

Description: The name of the Network Security Group for the Azure Bastion subnet. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_bastion_sku"></a> [bastion\_sku](#input\_bastion\_sku)

Description: The SKU of the Azure Bastion Host.  
Valid values are 'Basic', 'Standard'.

Type: `string`

Default: `"Standard"`

### <a name="input_bastion_tunneling_enabled"></a> [bastion\_tunneling\_enabled](#input\_bastion\_tunneling\_enabled)

Description: Specifies whether tunneling functionality is enabled for the Azure Bastion Host.

Type: `bool`

Default: `true`

### <a name="input_container_registry_name"></a> [container\_registry\_name](#input\_container\_registry\_name)

Description: The name of the Azure Container Registry. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see <https://aka.ms/avm/telemetryinfo>.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_explicit_outbound_method"></a> [explicit\_outbound\_method](#input\_explicit\_outbound\_method)

Description: The method to enable outbound internet access from jumpbox to Azure Machine Learning/AI Studio

Type: `string`

Default: `"NAT"`

### <a name="input_jumpbox"></a> [jumpbox](#input\_jumpbox)

Description: This creates a jumpbox if configured with jumpbox.create = true and defaults to a Windows machine. It is recommended to use a VM size with at least 16GB.

Type:

```hcl
object({
    create                         = bool
    name                           = optional(string, "jumpbox")
    os_type                        = optional(string, "Windows")
    size                           = optional(string, "Standard_D4s_v3")
    zone                           = optional(string, "1")
    accelerated_networking_enabled = optional(bool, false)
    image_ref = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
      }), {
      publisher = "microsoftwindowsdesktop"
      offer     = "windows-11"
      sku       = "win11-22h2-ent"
      version   = "latest"
    })
  })
```

Default:

```json
{
  "create": false
}
```

### <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name)

Description: The name of the Azure Key Vault. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_kind"></a> [kind](#input\_kind)

Description: The kind of the resource. This is used to determine the type of the resource. If not specified, the resource will be created as a standard resource.  
Possible values are:
- `Default` - The resource will be created as a standard Azure Machine Learning resource.
- `hub` - The resource will be created as an Azure AI Hub resource.

Type: `string`

Default: `"Default"`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.

Type:

```hcl
object({
    kind = string
    name = optional(string, null)
  })
```

Default: `null`

### <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name)

Description: The name of the Log Analytics Workspace. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_machine_learning_workspace_name"></a> [machine\_learning\_workspace\_name](#input\_machine\_learning\_workspace\_name)

Description: The name of the Azure Machine Learning Workspace. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_pe_network_security_group_name"></a> [pe\_network\_security\_group\_name](#input\_pe\_network\_security\_group\_name)

Description: The name of the Network Security Group for the private endpoints subnet. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_private_endpoints_subnet_address_spaces"></a> [private\_endpoints\_subnet\_address\_spaces](#input\_private\_endpoints\_subnet\_address\_spaces)

Description: The address space that is used for the private endpoints subnet

Type: `list(string)`

Default:

```json
[
  "10.1.2.0/24"
]
```

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description:   A map of role assignments to create on the <RESOURCE>. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

  - `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
  - `principal_id` - The ID of the principal to assign the role to.
  - `description` - (Optional) The description of the role assignment.
  - `skip_service_principal_aad_check` - (Optional) If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
  - `condition` - (Optional) The condition which will be used to scope the role assignment.
  - `condition_version` - (Optional) The version of the condition syntax. Leave as `null` if you are not using a condition, if you are then valid values are '2.0'.
  - `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.
  - `principal_type` - (Optional) The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.

  > Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_sql_storage_external_users"></a> [sql\_storage\_external\_users](#input\_sql\_storage\_external\_users)

Description: List of user object ids to add to the SQL storage external users group

Type: `list(string)`

Default: `[]`

### <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name)

Description: The name of the Azure Storage Account. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_storage_mvnet_users"></a> [storage\_mvnet\_users](#input\_storage\_mvnet\_users)

Description: List of user object ids to add to the storage mvnet users group

Type: `list(string)`

Default: `[]`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: A map of tags to add to all resources

Type: `map(string)`

Default: `null`

### <a name="input_virtual_machines_subnet_address_spaces"></a> [virtual\_machines\_subnet\_address\_spaces](#input\_virtual\_machines\_subnet\_address\_spaces)

Description: The address space that is used for the virtual machines subnet

Type: `list(string)`

Default:

```json
[
  "10.1.1.0/24"
]
```

### <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name)

Description: The name of the Virtual Network. If not provided, a name will be generated.

Type: `string`

Default: `""`

### <a name="input_vm_network_security_group"></a> [vm\_network\_security\_group](#input\_vm\_network\_security\_group)

Description:  - `name` - (Optional) The name of the Network Security Group. Changing this forces a new resource to be created. If not provided, a name will be generated.
 - `rules` - (Required) A map of Network Security Rules to create for the Network Security Group. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
    - `access` - (Required) Specifies whether network traffic is allowed or denied. Possible values are `Allow` and `Deny`.
    - `name` - (Required) Name of the network security rule to be created.
    - `description` - (Optional) A description for this rule. Restricted to 140 characters.
    - `destination_address_prefix` - (Optional) CIDR or destination IP range or * to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the CLI: ```shell az network list-service-tags --location westcentralus
```. For further information please see [Azure CLI
    - `destination_address_prefixes` - (Optional) List of destination address prefixes. Tags may not be used. This is required if `destination_address_prefix` is not specified.
    - `destination_application_security_group_ids` - (Optional) A List of destination Application Security Group IDs
    - `destination_port_range` - (Optional) Destination Port or Range. Integer or range between `0` and `65535` or `*` to match any. This is required if `destination_port_ranges` is not specified.
    - `destination_port_ranges` - (Optional) List of destination ports or port ranges. This is required if `destination_port_range` is not specified.
    - `direction` - (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are `Inbound` and `Outbound`.
    - `name` - (Required) The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created.
    - `priority` - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
    - `protocol` - (Required) Network protocol this rule applies to. Possible values include `Tcp`, `Udp`, `Icmp`, `Esp`, `Ah` or `*` (which matches all).
    - `resource_group_name` - (Required) The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created.
    - `source_address_prefix` - (Optional) CIDR or source IP range or * to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `source_address_prefixes` is not specified.
    - `source_address_prefixes` - (Optional) List of source address prefixes. Tags may not be used. This is required if `source_address_prefix` is not specified.
    - `source_application_security_group_ids` - (Optional) A List of source Application Security Group IDs
    - `source_port_range` - (Optional) Source Port or Range. Integer or range between `0` and `65535` or `*` to match any. This is required if `source_port_ranges` is not specified.
    - `source_port_ranges` - (Optional) List of source ports or port ranges. This is required if `source_port_range` is not specified.

Type:

```hcl
object({
    name = optional(string, "")
    security_rules = map(object({
      access                                     = string
      name                                       = string
      description                                = optional(string)
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      direction                                  = string
      priority                                   = number
      protocol                                   = string
      source_address_prefix                      = optional(string)
      source_address_prefixes                    = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      timeouts = optional(object({
        create = optional(string)
        delete = optional(string)
        read   = optional(string)
        update = optional(string)
      }))
    }))
  })
```

Default:

```json
{
  "name": "",
  "security_rules": {
    "AllowADOutbound": {
      "access": "Allow",
      "destination_address_prefix": "AzureActiveDirectory",
      "destination_port_ranges": [
        "80",
        "443"
      ],
      "direction": "Outbound",
      "name": "Allow-AD-Outbound",
      "priority": 110,
      "protocol": "*",
      "source_address_prefix": "*",
      "source_port_range": "*"
    },
    "AllowARMOutbound": {
      "access": "Allow",
      "destination_address_prefix": "AzureResourceManager",
      "destination_port_range": "*",
      "direction": "Outbound",
      "name": "Allow-ARM-Outbound",
      "priority": 120,
      "protocol": "*",
      "source_address_prefix": "*",
      "source_port_range": "*"
    },
    "AllowAzureBastion": {
      "access": "Allow",
      "destination_address_prefix": "VirtualNetwork",
      "destination_port_ranges": [
        "3389",
        "22"
      ],
      "direction": "Inbound",
      "name": "Allow-AzureBastion",
      "priority": 100,
      "protocol": "*",
      "source_address_prefix": "VirtualNetwork",
      "source_port_range": "*"
    },
    "AllowStudioOutbound": {
      "access": "Allow",
      "destination_address_prefix": "AzureFrontDoor.Frontend",
      "destination_port_range": "443",
      "direction": "Outbound",
      "name": "Allow-Studio-Outbound",
      "priority": 100,
      "protocol": "*",
      "source_address_prefix": "*",
      "source_port_range": "*"
    },
    "DenyInternetOutbound": {
      "access": "Deny",
      "destination_address_prefix": "Internet",
      "destination_port_range": "*",
      "direction": "Outbound",
      "name": "Deny-Internet-Outbound",
      "priority": 1000,
      "protocol": "*",
      "source_address_prefix": "*",
      "source_port_range": "*"
    }
  }
}
```

### <a name="input_vnet_address_spaces"></a> [vnet\_address\_spaces](#input\_vnet\_address\_spaces)

Description: The address space that is used the virtual network

Type: `list(string)`

Default:

```json
[
  "10.1.0.0/16"
]
```

## Outputs

The following outputs are exported:

### <a name="output_resource"></a> [resource](#output\_resource)

Description: This is the full output for the resource.

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: The Azure resource id of the resource.

## Modules

The following Modules are called:

### <a name="module_aisearch"></a> [aisearch](#module\_aisearch)

Source: Azure/avm-res-search-searchservice/azurerm

Version: 0.1.1

### <a name="module_aml"></a> [aml](#module\_aml)

Source: Azure/avm-res-machinelearningservices-workspace/azurerm

Version: 0.1.2

### <a name="module_avm_res_containerregistry_registry"></a> [avm\_res\_containerregistry\_registry](#module\_avm\_res\_containerregistry\_registry)

Source: Azure/avm-res-containerregistry-registry/azurerm

Version: ~> 0.2

### <a name="module_azure_bastion"></a> [azure\_bastion](#module\_azure\_bastion)

Source: Azure/avm-res-network-bastionhost/azurerm

Version: 0.3.0

### <a name="module_ba_network_security_group"></a> [ba\_network\_security\_group](#module\_ba\_network\_security\_group)

Source: Azure/avm-res-network-networksecuritygroup/azurerm

Version: ~> 0.2.0

### <a name="module_jumpbox"></a> [jumpbox](#module\_jumpbox)

Source: Azure/avm-res-compute-virtualmachine/azurerm

Version: 0.15.1

### <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault)

Source: Azure/avm-res-keyvault-vault/azurerm

Version: ~> 0.5

### <a name="module_log_analytics_workspace"></a> [log\_analytics\_workspace](#module\_log\_analytics\_workspace)

Source: Azure/avm-res-operationalinsights-workspace/azurerm

Version: ~> 0.1

### <a name="module_natgateway"></a> [natgateway](#module\_natgateway)

Source: Azure/avm-res-network-natgateway/azurerm

Version: 0.2.0

### <a name="module_pe_network_security_group"></a> [pe\_network\_security\_group](#module\_pe\_network\_security\_group)

Source: Azure/avm-res-network-networksecuritygroup/azurerm

Version: ~> 0.2.0

### <a name="module_private_dns_aisearch"></a> [private\_dns\_aisearch](#module\_private\_dns\_aisearch)

Source: Azure/avm-res-network-privatednszone/azurerm

Version: ~> 0.1.1

### <a name="module_private_dns_aml_api"></a> [private\_dns\_aml\_api](#module\_private\_dns\_aml\_api)

Source: Azure/avm-res-network-privatednszone/azurerm

Version: 0.1.2

### <a name="module_private_dns_aml_notebooks"></a> [private\_dns\_aml\_notebooks](#module\_private\_dns\_aml\_notebooks)

Source: Azure/avm-res-network-privatednszone/azurerm

Version: 0.1.2

### <a name="module_private_dns_container_registry"></a> [private\_dns\_container\_registry](#module\_private\_dns\_container\_registry)

Source: Azure/avm-res-network-privatednszone/azurerm

Version: ~> 0.1.1

### <a name="module_private_dns_keyvault"></a> [private\_dns\_keyvault](#module\_private\_dns\_keyvault)

Source: Azure/avm-res-network-privatednszone/azurerm

Version: ~> 0.1.1

### <a name="module_private_dns_storage"></a> [private\_dns\_storage](#module\_private\_dns\_storage)

Source: Azure/avm-res-network-privatednszone/azurerm

Version: ~> 0.1.1

### <a name="module_private_dns_workspace"></a> [private\_dns\_workspace](#module\_private\_dns\_workspace)

Source: Azure/avm-res-network-privatednszone/azurerm

Version: ~> 0.1.1

### <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account)

Source: Azure/avm-res-storage-storageaccount/azurerm

Version: 0.2.2

### <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network)

Source: Azure/avm-res-network-virtualnetwork/azurerm

Version: ~> 0.4.0

### <a name="module_vm_network_security_group"></a> [vm\_network\_security\_group](#module\_vm\_network\_security\_group)

Source: Azure/avm-res-network-networksecuritygroup/azurerm

Version: ~> 0.2.0

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->