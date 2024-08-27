module "private_dns_aml_api" {
  source              = "Azure/avm-res-network-privatednszone/azurerm"
  version             = "0.1.2"
  domain_name         = "privatelink.api.azureml.ms"
  resource_group_name = data.azurerm_resource_group.base.name
  virtual_network_links = {
    dnslink = {
      vnetlinkname = "privatelink.api.azureml.ms"
      vnetid       = module.virtual_network.resource.id
    }
  }

  tags             = var.tags
  enable_telemetry = var.enable_telemetry
}
module "private_dns_aml_notebooks" {
  source              = "Azure/avm-res-network-privatednszone/azurerm"
  version             = "0.1.2"
  domain_name         = "privatelink.notebooks.azure.net"
  resource_group_name = data.azurerm_resource_group.base.name
  virtual_network_links = {
    dnslink = {
      vnetlinkname = "privatelink.notebooks.azureml.ms"
      vnetid       = module.virtual_network.resource.id
    }
  }
  tags             = var.tags
  enable_telemetry = var.enable_telemetry
}

module "aml" {
  source   = "Azure/avm-res-machinelearningservices-workspace/azurerm"
  version  = "0.1.2"
  location = var.location
  name     = local.machine_learning_workspace_name
  kind     = var.kind
  resource_group = {
    id   = data.azurerm_resource_group.base.id
    name = data.azurerm_resource_group.base.name
  }
  storage_account = {
    resource_id = module.storage_account.resource.id
    create_new  = false
  }

  key_vault = {
    resource_id = replace(module.key_vault.resource_id, "Microsoft.KeyVault", "Microsoft.Keyvault")
    create_new  = false
  }

  container_registry = {
    resource_id = module.avm_res_containerregistry_registry.resource.id
    create_new  = false
  }

  log_analytics_workspace = {
    resource_id = module.log_analytics_workspace.resource_id
    create_new  = false
  }

  private_endpoints = {
    primary = {
      name                          = "pe-aml"
      subnet_resource_id            = module.virtual_network.subnets["private_endpoints"].resource_id
      private_dns_zone_resource_ids = [module.private_dns_aml_api.resource_id, module.private_dns_aml_notebooks.resource_id]
      inherit_lock                  = false
    }
  }


  enable_telemetry = var.enable_telemetry
  tags             = var.tags
  is_private       = true
}
