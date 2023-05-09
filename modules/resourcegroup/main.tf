resource "azurerm_resource_group" "individual-project" {
  name     = var.rg_name
  location = var.rg_location
}