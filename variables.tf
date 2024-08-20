variable "location" {
  type        = string
  description = "The location/region where the resources will be deployed."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the this resource."

  validation {
    condition     = can(regex("^[a-z][a-z0-9]{4,14}$", var.name))
    error_message = "The name must be between 5 and 15 chars long and can only contain lowercase letters and numbers."
  }
}

# This is required for most resource modules
variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "adlsgen_data_contrib_users" {
  type        = list(string)
  default     = []
  description = "List of user object ids to add to the ADLSgen Data Contributor group"
}

variable "akv_secret_admin_users" {
  type        = list(string)
  default     = []
  description = "List of user object ids to add to the AKV Secret Admin group"
}

variable "aml_workspace_ds_users" {
  type        = list(string)
  default     = []
  description = "List of user object ids to add to the AML Workspace DS group"
}

variable "aml_workspace_ml_operator_users" {
  type        = list(string)
  default     = []
  description = "List of user object ids to add to the AML Workspace ML Operator group"
}

variable "azure_bastion_subnet_address_spaces" {
  type        = list(string)
  default     = ["10.1.3.0/24"]
  description = "The address space that is used for the Azure Bastion subnet"
}

variable "bastion_copy_paste_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether copy-paste functionality is enabled for the Azure Bastion Host."
  nullable    = false
}

variable "bastion_file_copy_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether file copy functionality is enabled for the Azure Bastion Host."
  nullable    = false
}

variable "bastion_name" {
  type        = string
  default     = ""
  description = "The name of the Azure Bastion resource. if not provided, a name will be generated."
}

variable "bastion_network_security_group_name" {
  type        = string
  default     = ""
  description = "The name of the Network Security Group for the Azure Bastion subnet. If not provided, a name will be generated."
}

variable "bastion_sku" {
  type        = string
  default     = "Standard"
  description = <<DESCRIPTION
The SKU of the Azure Bastion Host.
Valid values are 'Basic', 'Standard'.
DESCRIPTION
  nullable    = false

  validation {
    condition     = can(regex("^(Basic|Standard)$", var.bastion_sku))
    error_message = "The SKU must be either 'Basic', 'Standard'"
  }
}

variable "bastion_tunneling_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether tunneling functionality is enabled for the Azure Bastion Host."
  nullable    = false
}

variable "container_registry_name" {
  type        = string
  default     = ""
  description = "The name of the Azure Container Registry. If not provided, a name will be generated."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "explicit_outbound_method" {
  type        = string
  default     = "NAT"
  description = "The method to enable outbound internet access from jumpbox to Azure Machine Learning/AI Studio"

  validation {
    condition     = contains(["NAT"], var.explicit_outbound_method)
    error_message = "Valid values for var: explicit_outbound_method are NAT. Future support will include: UDR, LoadBalancer, PublicIP, or Firewall."
  }
}

variable "jumpbox" {
  type = object({
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
  default = {
    create = false
  }
  description = "This creates a jumpbox if configured with jumpbox.create = true and defaults to a Windows machine. It is recommended to use a VM size with at least 16GB."
}

variable "key_vault_name" {
  type        = string
  default     = ""
  description = "The name of the Azure Key Vault. If not provided, a name will be generated."
}

variable "kind" {
  type        = string
  default     = "Default"
  description = <<DESCRIPTION
The kind of the resource. This is used to determine the type of the resource. If not specified, the resource will be created as a standard resource.
Possible values are:
- `Default` - The resource will be created as a standard Azure Machine Learning resource.
- `hub` - The resource will be created as an Azure AI Hub resource.
DESCRIPTION
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  default     = null
  description = <<DESCRIPTION
Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.
DESCRIPTION

  validation {
    condition     = var.lock != null ? contains(["CanNotDelete", "ReadOnly"], var.lock.kind) : true
    error_message = "The lock level must be one of: 'None', 'CanNotDelete', or 'ReadOnly'."
  }
}

variable "log_analytics_workspace_name" {
  type        = string
  default     = ""
  description = "The name of the Log Analytics Workspace. If not provided, a name will be generated."
}

variable "machine_learning_workspace_name" {
  type        = string
  default     = ""
  description = "The name of the Azure Machine Learning Workspace. If not provided, a name will be generated."
}

variable "pe_network_security_group_name" {
  type        = string
  default     = ""
  description = "The name of the Network Security Group for the private endpoints subnet. If not provided, a name will be generated."
}

variable "private_endpoints_subnet_address_spaces" {
  type        = list(string)
  default     = ["10.1.2.0/24"]
  description = "The address space that is used for the private endpoints subnet"
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
  A map of role assignments to create on the <RESOURCE>. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  
  - `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
  - `principal_id` - The ID of the principal to assign the role to.
  - `description` - (Optional) The description of the role assignment.
  - `skip_service_principal_aad_check` - (Optional) If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
  - `condition` - (Optional) The condition which will be used to scope the role assignment.
  - `condition_version` - (Optional) The version of the condition syntax. Leave as `null` if you are not using a condition, if you are then valid values are '2.0'.
  - `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.
  - `principal_type` - (Optional) The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.
  
  > Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
  DESCRIPTION
  nullable    = false
}

variable "sql_storage_external_users" {
  type        = list(string)
  default     = []
  description = "List of user object ids to add to the SQL storage external users group"
}

variable "storage_account_name" {
  type        = string
  default     = ""
  description = "The name of the Azure Storage Account. If not provided, a name will be generated."
}

variable "storage_mvnet_users" {
  type        = list(string)
  default     = []
  description = "List of user object ids to add to the storage mvnet users group"
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "A map of tags to add to all resources"
}

variable "virtual_machines_subnet_address_spaces" {
  type        = list(string)
  default     = ["10.1.1.0/24"]
  description = "The address space that is used for the virtual machines subnet"
}

variable "virtual_network_name" {
  type        = string
  default     = ""
  description = "The name of the Virtual Network. If not provided, a name will be generated."
}

variable "vm_network_security_group" {
  type = object({
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
  default = {
    name = ""
    security_rules = {
      AllowAzureBastion = {
        access                     = "Allow"
        direction                  = "Inbound"
        name                       = "Allow-AzureBastion"
        priority                   = 100
        protocol                   = "*"
        destination_address_prefix = "VirtualNetwork"
        destination_port_ranges    = ["3389", "22"]
        source_address_prefix      = "VirtualNetwork"
        source_port_range          = "*"
      }

      AllowStudioOutbound = {
        access                     = "Allow"
        direction                  = "Outbound"
        name                       = "Allow-Studio-Outbound"
        priority                   = 100
        protocol                   = "*"
        destination_address_prefix = "AzureFrontDoor.Frontend"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        source_port_range          = "*"
      }

      AllowADOutbound = {
        access                     = "Allow"
        direction                  = "Outbound"
        name                       = "Allow-AD-Outbound"
        priority                   = 110
        protocol                   = "*"
        destination_address_prefix = "AzureActiveDirectory"
        destination_port_ranges    = ["80", "443"]
        source_address_prefix      = "*"
        source_port_range          = "*"
      }

      AllowARMOutbound = {
        access                     = "Allow"
        direction                  = "Outbound"
        name                       = "Allow-ARM-Outbound"
        priority                   = 120
        protocol                   = "*"
        destination_address_prefix = "AzureResourceManager"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        source_port_range          = "*"
      }

      DenyInternetOutbound = {
        access                     = "Deny"
        direction                  = "Outbound"
        name                       = "Deny-Internet-Outbound"
        priority                   = 1000
        protocol                   = "*"
        destination_address_prefix = "Internet"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        source_port_range          = "*"
      }

    }
  }
  description = <<DESCRIPTION
 - `name` - (Optional) The name of the Network Security Group. Changing this forces a new resource to be created. If not provided, a name will be generated.
 - `rules` - (Required) A map of Network Security Rules to create for the Network Security Group. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
    - `access` - (Required) Specifies whether network traffic is allowed or denied. Possible values are `Allow` and `Deny`.
    - `name` - (Required) Name of the network security rule to be created.
    - `description` - (Optional) A description for this rule. Restricted to 140 characters.
    - `destination_address_prefix` - (Optional) CIDR or destination IP range or * to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the CLI: ```shell az network list-service-tags --location westcentralus```. For further information please see [Azure CLI
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
DESCRIPTION
}

variable "vnet_address_spaces" {
  type        = list(string)
  default     = ["10.1.0.0/16"]
  description = "The address space that is used the virtual network"
}

variable "aisearch_sku" {
  type        = string
  default     = "Basic"
  description = "The SKU of the Azure Cognitive Search service."
}

variable "aisearch_name" {
  type        = string
  default     = ""
  description = "The name of the Azure Cognitive Search service. If not provided, a name will be generated."
}

variable "aisearch_public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Controls whether or not the Azure Cognitive Search service is accessible from the public internet."
}

variable "azure_aisearch_allowed_ips" {
  type        = list(string)
  default     = []
  description = "A list of IP addresses that are allowed to access the Azure Cognitive Search service."
}

variable "aisearch_local_authentication_enabled" {
  type        = bool
  default     = false
  description = "Controls whether or not local authentication is enabled for the Azure Cognitive Search service."
}

variable "hosting_mode" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Hosting Mode, which allows for High Density partitions (that allow for up to 1000 indexes) should be supported. Possible values are `highDensity` or `default`. Defaults to `default`. Changing this forces a new Search Service to be created."
}

variable "replica_count" {
  type        = number
  description = "Replicas distribute search workloads across the service. You need at least two replicas to support high availability of query workloads (not applicable to the free tier)."
  default     = 1
  validation {
    condition     = var.replica_count >= 1 && var.replica_count <= 12
    error_message = "The replica_count must be between 1 and 12."
  }
}

variable "partition_count" {
  type        = number
  description = "Partitions allow for scaling of document count as well as faster indexing by sharding your index over multiple search units."
  default     = 1
  validation {
    condition     = contains([1, 2, 3, 4, 6, 12], var.partition_count)
    error_message = "The partition_count must be one of the following values: 1, 2, 3, 4, 6, 12."
  }
}

variable "semantic_search_sku" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Semantic Search SKU which should be used for this Search Service. Possible values include `free` and `standard`."
}
