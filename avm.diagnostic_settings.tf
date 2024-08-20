# Diagnostic Settings
#
# Some modules implement diagnostic settings to send logs and metrics to Log Analytics.
# If the modules are invoked directly from this pattern AVM, the diagnostic settings are implemented in the reference to that module.
# However, if the module is invoked from another resource module that the pattern uses, it will not be possible to implement the diagnostic settings,
# without changing the implementation of the module used by the pattern.

# For this reason, this module creates diagnostic settings for any resource that is not directly invoked from this pattern module and
# does not implement diagnostic settings.

# If diagnostic settings for the resource use category groups (allLogs, allMetrics), add the id of the corresponding 
# resource in the diag_settings_resources local variable.
# Otherwise, add its specific resource with the customized attributes for it (storage account, for example)

locals {
  diag_setting_resources = {
    aml           = { resource_id = module.aml.resource.id },
    storage-blob  = { resource_id = format("%s%s", module.storage_account.resource.id, "/blobServices/default/") },
    storage-table = { resource_id = format("%s%s", module.storage_account.resource.id, "/tableServices/default/") },
    storage-file  = { resource_id = format("%s%s", module.storage_account.resource.id, "/fileServices/default/") },
    storage-queue = { resource_id = format("%s%s", module.storage_account.resource.id, "/queueServices/default/") },
    bastion       = { resource_id = module.azure_bastion.resource.id },
    bastion-ip    = { resource_id = azurerm_public_ip.bastion_ip.id }
  }
}

resource "azurerm_monitor_diagnostic_setting" "diag_setting_resources" {
  for_each = local.diag_setting_resources

  name                       = local.diagnostic_settings.defaultDiagnosticSettings.name
  target_resource_id         = each.value.resource_id
  log_analytics_workspace_id = module.log_analytics_workspace.resource.id

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
  }
}

# Resources like the following, have specific categories for Logs/metrics, so they are implemented separately

resource "azurerm_monitor_diagnostic_setting" "diag_setting_resource_storage" {
  name                       = local.diagnostic_settings.defaultDiagnosticSettings.name
  target_resource_id         = module.storage_account.resource.id
  log_analytics_workspace_id = module.log_analytics_workspace.resource.id

  metric {
    category = "Transaction"
  }
}
