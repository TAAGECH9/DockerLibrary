resource "azurerm_resource_group" "acr_rg" {
  name     = var.docker_rg.name
  location = var.docker_rg.location
}
