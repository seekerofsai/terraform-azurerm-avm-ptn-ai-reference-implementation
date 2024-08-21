# Create the Azure AD groups

resource "azuread_group" "akv_secret_admin" {
  display_name     = "akv_secret_admin"
  description      = "This is the group for AKV Secret Admins"
  mail_enabled     = false
  security_enabled = true
}

resource "azuread_group" "aml_workspace_ds" {
  display_name     = "aml_workspace_ds"
  description      = "This is the group for AML Workspace Data Scientists"
  mail_enabled     = false
  security_enabled = true
}

resource "azuread_group" "aml_workspace_ml_operator" {
  display_name     = "AML_Workspace_ML_Operator"
  description      = "This is the group for AML Workspace ML Operators"
  mail_enabled     = false
  security_enabled = true
}

resource "azuread_group" "user_adlsgen_data_contrib" {
  display_name     = "User_ADLSgen_Data_contrib"
  description      = "This is the group for ADLSgen Data Contributors"
  mail_enabled     = false
  security_enabled = true
}

resource "azuread_group" "user_storage_mvnet" {
  display_name     = "User_storage_mvnet"
  description      = "This is the user group for storage within mvnet "
  mail_enabled     = false
  security_enabled = true
}

resource "azuread_group" "user_sql_storage_external" {
  display_name     = "User_sql_storage_external"
  description      = "This is the user group for external (outside mvnet) SQL storage"
  mail_enabled     = false
  security_enabled = true
}

# Create the role assignments

resource "azurerm_role_assignment" "akv_secret_admin" {
  principal_id         = azuread_group.akv_secret_admin.object_id
  scope                = data.azurerm_resource_group.base.id
  role_definition_name = "Key Vault Administrator"
}

resource "azurerm_role_assignment" "aml_workspace_ds" {
  principal_id         = azuread_group.aml_workspace_ds.object_id
  scope                = data.azurerm_resource_group.base.id
  role_definition_name = "AzureML Data Scientist"
}

resource "azurerm_role_assignment" "aml_workspace_ml_operator" {
  principal_id         = azuread_group.aml_workspace_ml_operator.object_id
  scope                = data.azurerm_resource_group.base.id
  role_definition_name = "AzureML Compute Operator"
}

resource "azurerm_role_assignment" "user_adlsgen_data_contrib" {
  principal_id         = azuread_group.user_adlsgen_data_contrib.object_id
  scope                = data.azurerm_resource_group.base.id
  role_definition_name = "Storage Blob Data Contributor"
}

resource "azurerm_role_assignment" "user_storage_mvnet" {
  principal_id         = azuread_group.user_storage_mvnet.object_id
  scope                = data.azurerm_resource_group.base.id
  role_definition_name = "Storage Blob Data Contributor"
}

resource "azurerm_role_assignment" "user_sql_storage_external" {
  principal_id         = azuread_group.user_sql_storage_external.object_id
  scope                = data.azurerm_resource_group.base.id
  role_definition_name = "Storage Blob Data Contributor"
}

# addociate uobject ids to the groups for the role assignments

resource "azuread_group_member" "akv_secret_admin" {
  for_each = toset(var.akv_secret_admin_users)

  group_object_id  = azuread_group.akv_secret_admin.object_id
  member_object_id = each.key
}

resource "azuread_group_member" "aml_workspace_ds" {
  for_each = toset(var.aml_workspace_ds_users)

  group_object_id  = azuread_group.aml_workspace_ds.object_id
  member_object_id = each.key
}

resource "azuread_group_member" "aml_workspace_ml_operator" {
  for_each = toset(var.aml_workspace_ml_operator_users)

  group_object_id  = azuread_group.aml_workspace_ml_operator.object_id
  member_object_id = each.key
}

resource "azuread_group_member" "user_adlsgen_data_contrib" {
  for_each = toset(var.adlsgen_data_contrib_users)

  group_object_id  = azuread_group.user_adlsgen_data_contrib.object_id
  member_object_id = each.key
}

resource "azuread_group_member" "user_storage_mvnet" {
  for_each = toset(var.storage_mvnet_users)

  group_object_id  = azuread_group.user_storage_mvnet.object_id
  member_object_id = each.key
}

resource "azuread_group_member" "user_sql_storage_external" {
  for_each = toset(var.sql_storage_external_users)

  group_object_id  = azuread_group.user_sql_storage_external.object_id
  member_object_id = each.key
}

