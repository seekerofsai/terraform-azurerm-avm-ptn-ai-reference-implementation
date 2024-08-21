resource "azurerm_subscription_policy_assignment" "mcsb_assignment" {
  name                 = "mcsb"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Microsoft Cloud Security Benchmark"
}

resource "azurerm_security_center_subscription_pricing" "mdc_arm" {
  tier          = "Free"
  resource_type = "Arm"
}

resource "azurerm_security_center_subscription_pricing" "mdc_servers" {
  tier          = "Free"
  resource_type = "VirtualMachines"
}

resource "azurerm_security_center_subscription_pricing" "mdc_keyvault" {
  tier          = "Free"
  resource_type = "KeyVaults"
}

resource "azurerm_security_center_subscription_pricing" "mdc_containerregistry" {
  tier          = "Free"
  resource_type = "ContainerRegistry"
}

resource "azurerm_security_center_subscription_pricing" "mdc_cspm" {
  tier          = "Free"
  resource_type = "CloudPosture"
}


resource "azurerm_security_center_subscription_pricing" "mdc_storage" {
  tier          = "Free"
  resource_type = "StorageAccounts"
}
