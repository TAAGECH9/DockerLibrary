data "azuread_group" "test" {
  display_name = "test"
}

data "azuread_application" "docker-image-library" {
  display_name = "docker-image-library"
}
