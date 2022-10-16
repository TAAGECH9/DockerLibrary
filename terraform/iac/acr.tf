resource "azurerm_container_registry" "acr" {
  name                = var.acr.name
  resource_group_name = azurerm_resource_group.acr_rg.name
  location            = var.acr.location
  sku                 = var.acr.sku
}
