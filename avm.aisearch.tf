module "private_dns_aisearch" {
  source              = "Azure/avm-res-network-privatednszone/azurerm"
  version             = "~> 0.1.1"
  domain_name         = "privatelink.aisearch.azure.net"
  resource_group_name = data.azurerm_resource_group.base.name
  virtual_network_links = {
    dnslink = {
      vnetlinkname = "aisearch-vnet-link"
      vnetid       = module.virtual_network.resource.id
    }
  }
  tags             = var.tags
  enable_telemetry = var.enable_telemetry
}


module "aisearch" {
  # source = "../terraform-azurerm-avm-res-search-searchservice"
  source                        = "Azure/avm-res-search-searchservice/azurerm"
  version                       = "0.1.1"
  location                      = var.location
  name                          = local.aisearch_name
  resource_group_name           = data.azurerm_resource_group.base.name
  public_network_access_enabled = var.aisearch_public_network_access_enabled
  enable_telemetry              = var.enable_telemetry

  private_endpoints = {
    primary = {
      subnet_resource_id            = module.virtual_network.subnets["private_endpoints"].resource_id
      private_dns_zone_resource_ids = [module.private_dns_aisearch.resource.id]
      tags                          = var.tags
    }
  }

  sku                          = var.aisearch_sku
  replica_count                = var.aisearch_replica_count
  partition_count              = var.aisearch_partition_count
  hosting_mode                 = var.aisearch_hosting_mode
  semantic_search_sku          = var.aisearch_semantic_search_sku
  allowed_ips                  = var.aisearch_allowed_ips
  local_authentication_enabled = var.aisearch_local_authentication_enabled
  managed_identities = {
    system_assigned = true
  }
  tags = var.tags
}

resource "azurerm_private_dns_a_record" "this" {
  for_each = module.aisearch.private_endpoints

  name                = module.aisearch.resource.name
  records             = [each.value.private_service_connection[0].private_ip_address]
  resource_group_name = data.azurerm_resource_group.base.name
  ttl                 = 300
  zone_name           = module.private_dns_aisearch.resource.name
  tags                = var.tags
}
