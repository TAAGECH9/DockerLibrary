resource "azurerm_resource_group" "example" {
  name     = var.docker-rg.name
  location = var.docker-rg.location
}
