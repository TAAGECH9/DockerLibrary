resource "azurerm_resource_group" "example" {
  name     = var.docker_rg.name
  location = var.docker_rg.location
}
