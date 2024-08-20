module "aisearch" {
  source   = "../terraform-azurerm-avm-res-search-searchservice/"
  # source   = "Azure/avm-res-search-searchservice/azurerm"
  # version  = "0.1.1"
  location = var.location
  name     = local.aisearch_name
  resource_group_name = data.azurerm_resource_group.base.name
  enable_telemetry = var.enable_telemetry
  tags             = var.tags
  sku              = var.aisearch_sku
  public_network_access_enabled = var.aisearch_public_network_access_enabled
  allowed_ips                   = var.azure_aisearch_allowed_ips

  local_authentication_enabled = var.aisearch_local_authentication_enabled
  managed_identities = {
    system_assigned = true
  }
}
