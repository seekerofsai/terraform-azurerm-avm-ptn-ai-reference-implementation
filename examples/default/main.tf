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
resource "azurerm_resource_group" "this" {
  location = "southcentralus"
  name     = module.naming.resource_group.name_unique
}

module "test" {
  source              = "../../"
  location            = azurerm_resource_group.this.location
  name                = random_string.name.id
  resource_group_name = azurerm_resource_group.this.name
  enable_telemetry    = var.enable_telemetry
  jumpbox = {
    create                         = true
    size                           = var.jumpbox.size
    zone                           = var.jumpbox.zone
    accelerated_networking_enabled = var.jumpbox.accelerated_networking_enabled
  }
  tags = {
    environment = "test"
    cicd        = "terraform"
  }
  depends_on = [azurerm_resource_group.this]
}
