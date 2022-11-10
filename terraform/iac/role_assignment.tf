resource "azurerm_role_assignment" "test_role_assignment" {
  principal_id                     = data.azuread_application.docker-image-library.id
  role_definition_name             = "AcrPush"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
