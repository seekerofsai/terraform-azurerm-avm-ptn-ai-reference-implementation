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

  subnet_associations = {
    virtual_machines = {
      resource_id = module.virtual_network.subnets["virtual_machines"].resource_id
    }
  }
  count = var.explicit_outbound_method == "NAT" ? 1 : 0
}