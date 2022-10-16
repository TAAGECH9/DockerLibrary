resource "azurerm_container_registry" "acr" {
  name                = var.acr.name
  resource_group_name = azurerm_resource_group.example.name
  location            = var.acr.location
  sku                 = var.acr.sku
}
