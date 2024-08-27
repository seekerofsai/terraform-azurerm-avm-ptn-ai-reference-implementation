module "natgateway" {
  source              = "Azure/avm-res-network-natgateway/azurerm"
  version             = "0.2.0"
  name                = "vm-subnet-gw"
  enable_telemetry    = true
  location            = var.location
  resource_group_name = data.azurerm_resource_group.base.name

  public_ips = {
    public_ip = {
      name = "vm_subnet_gw_pip"
    }
  }
  count = var.explicit_outbound_method == "NAT" ? 1 : 0
  tags  = var.tags
  # for idempotency
  zones = []
}
