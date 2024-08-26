module "jumpbox" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.15.1"

  enable_telemetry    = var.enable_telemetry
  location            = var.location
  resource_group_name = local.resource_group_name
  os_type             = var.jumpbox.os_type
  name                = var.jumpbox.name
  sku_size            = var.jumpbox.size
  zone                = var.jumpbox.zone

  source_image_reference = var.jumpbox.image_ref

  network_interfaces = {
    network_interface_1 = {
      name                           = "${var.jumpbox.name}-nic"
      accelerated_networking_enabled = var.jumpbox.accelerated_networking_enabled
      ip_configurations = {
        ip_configuration_1 = {
          name                          = "${var.jumpbox.name}-nic-ipconfig1"
          private_ip_subnet_resource_id = module.virtual_network.subnets["virtual_machines"].resource_id
        }
      }
    }
  }

  managed_identities = {
    type = "SystemAssigned"
  }

  tags  = var.tags
  count = var.jumpbox.create ? 1 : 0
}
