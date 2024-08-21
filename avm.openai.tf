module "openai" {
  count               = var.kind == "Default" ? 1 : 0
  source              = "Azure/openai/azurerm"
  version             = "~>0.1.3"
  resource_group_name = data.azurerm_resource_group.base.name
  location            = var.location
  private_endpoint = {
    "pe_endpoint" = {
      name                            = "pe-openai"
      vnet_rg_name                    = data.azurerm_resource_group.base.name
      vnet_name                       = module.virtual_network.name
      subnet_name                     = module.virtual_network.subnets["private_endpoints"].name
      private_dns_entry_enabled       = true
      dns_zone_virtual_network_link   = "dns_zone_link"
      is_manual_connection            = false
      private_service_connection_name = "pe_one_connection"
    }
  }
  deployment = {
    "gpt-35-turbo" = {
      name          = "gpt-35-turbo"
      model_format  = "OpenAI"
      model_name    = "gpt-35-turbo"
      model_version = "0613"
      scale_type    = "Standard"
    }
  }
  depends_on = [
    data.azurerm_resource_group.base,
    module.virtual_network
  ]
}
