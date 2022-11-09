resource "azurerm_role_assignment" "acr_pull_role" {
  principal_id                     = data.azuread_group.test.object_id
  role_definition_name             = "Contributor"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
