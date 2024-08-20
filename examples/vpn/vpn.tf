resource "azurerm_public_ip" "vpn" {
  allocation_method       = "Static"
  location                = azurerm_resource_group.example.location
  name                    = "example-vpn-ip"
  resource_group_name     = azurerm_resource_group.example.name
  idle_timeout_in_minutes = 30
  sku                     = "Standard"
}

resource "azurerm_network_interface" "vpn" {
  location            = azurerm_resource_group.example.location
  name                = "example-vpn-nic"
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vpn.id
    subnet_id                     = module.airi.resource.virtual_network.subnets["virtual_machines"].resource_id
  }
}

resource "azurerm_linux_virtual_machine" "vpn" {
  admin_username = "adminazure"
  location       = azurerm_resource_group.example.location
  name           = "example-vpn-vm"
  network_interface_ids = [
    azurerm_network_interface.vpn.id,
  ]
  resource_group_name = azurerm_resource_group.example.name
  size                = "Standard_F2s"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  admin_ssh_key {
    public_key = file("~/.ssh/id_rsa.pub")
    username   = "adminazure"
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "Canonical"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

locals {
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

    AllowOpenVpnInbound = {
      access                     = "Allow"
      direction                  = "Inbound"
      name                       = "Allow-OpenVpn"
      priority                   = 510
      protocol                   = "*"
      destination_address_prefix = "VirtualNetwork"
      destination_port_ranges    = ["1194"]
      source_address_prefix      = "*"
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

    # Temporary required so the vms can install software idealy this would point our to an appliance that would serve as firewall and filter internet traffic.
    AllowInternetOutbound = {
      access                     = "Allow"
      direction                  = "Outbound"
      name                       = "Allow-Internet-Outbound"
      priority                   = 900
      protocol                   = "*"
      destination_address_prefix = "Internet"
      destination_port_range     = "*"
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
