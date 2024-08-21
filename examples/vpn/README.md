<!-- BEGIN_TF_DOCS -->
# OpenVPN Connection Example

This example demonstrates how to set up an OpenVPN connection to access resources within a virtual network. The provided setup uses a simplified configuration with a single Ubuntu VM deployed on the same network as the virtual machines you intend to work with.

**Benefits:**
- **Concurrent Access:** Multiple users can access the workspace simultaneously without needing separate VMs.
- **Local Tool Integration:** Use tools on your local machine to interact with the environment, eliminating the need for additional setup.

**Note:** Ideally, users should integrate this setup with their existing VPN solutions to avoid deploying another VPN instance.

## Requirements

To use this example, ensure you have:

- Access to the internet or a local copy of an OpenVPN provisioning script.
- An OpenVPN client installed on your machine.

## How to Use

Follow these steps to set up and connect to the VPN:

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```
   Run this command in the folder containing the example files.

2. **Apply Terraform Configuration:**
   ```bash
   terraform apply
   ```
   Run this command in the same folder.

3. **Note the VPN Box IP:**
   Record the public IP address of the VPN VM, named `example-vpn-vm`.

4. **Connect to the VPN Box:**
   In the portal, locate the VPN VM `example-vpn-vm` and use Bastion to connect to it.

   You should use the username `azureuser` and the SSH key that was generated during the terraform apply. the private key will be created in the same folder as the terraform files called `vpn.key`.

   ![Connecting to the VPN Box](./midia/bastion\_printscreen.png)

5. **Install OpenVPN Server:**
   Install the OpenVPN server, ensuring you keep the default port 1194 as configured in the module. Use the following script from [Nyr's OpenVPN install script](https://github.com/Nyr/openvpn-install):
   ```bash
   sudo su
   wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
   ```
   Follow the on-screen instructions.
   ![OpenVPN Installation](./midia/openvpn\_install.png)

6. **Connect to the VPN:**
   After installation, you will receive a `<yourname>.ovpn` file. Import this file into your OpenVPN client and connect to the VPN.

7. **Access the Workspace:**
   Navigate to your Azure Machine Learning workspace in the portal and click on "Launch Studio." You should now have access without any issues.

```hcl
terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.114.0, < 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

}


## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/regions/azurerm"
  version = "~> 0.3"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}
## End of section to provide a random Azure region for the resource group

resource "random_string" "name" {
  length  = 5
  numeric = false
  special = false
  upper   = false
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.3"
}

# This is required for resource modules
resource "azurerm_resource_group" "example" {
  location = "uksouth"
  name     = module.naming.resource_group.name_unique
}

module "airi" {
  source              = "../../"
  location            = azurerm_resource_group.example.location
  name                = random_string.name.id
  resource_group_name = azurerm_resource_group.example.name
  enable_telemetry    = var.enable_telemetry
  vm_network_security_group = {
    security_rules = local.security_rules
  }
  tags = {
    environment = "vpn"
    cicd        = "terraform"
  }
  depends_on = [azurerm_resource_group.example]
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.114.0, < 4.0.0)

- <a name="requirement_local"></a> [local](#requirement\_local) (~> 2.4)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

- <a name="requirement_tls"></a> [tls](#requirement\_tls) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_linux_virtual_machine.vpn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) (resource)
- [azurerm_network_interface.vpn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) (resource)
- [azurerm_public_ip.vpn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) (resource)
- [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [local_file.vpn](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) (resource)
- [local_sensitive_file.vpn](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) (resource)
- [random_integer.region_index](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) (resource)
- [random_string.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) (resource)
- [tls_private_key.vpn](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see <https://aka.ms/avm/telemetryinfo>.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

## Outputs

The following outputs are exported:

### <a name="output_result"></a> [result](#output\_result)

Description: n/a

## Modules

The following Modules are called:

### <a name="module_airi"></a> [airi](#module\_airi)

Source: ../../

Version:

### <a name="module_naming"></a> [naming](#module\_naming)

Source: Azure/naming/azurerm

Version: ~> 0.3

### <a name="module_regions"></a> [regions](#module\_regions)

Source: Azure/regions/azurerm

Version: ~> 0.3

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->