resource "azurerm_virtual_network" "main" {
  name                = "main"
  resource_group_name = var.rg
  location            = var.location
  address_space       = [var.vnetcidr]
}

resource "azurerm_subnet" "gw-subnet" {
  name                 = "gw-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name = var.rg
  address_prefixes     = [var.gwsubnetcidr]
}

resource "azurerm_subnet" "app-subnet" {
  name                 = "app-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = var.rg
  address_prefixes     = [var.appsubnetcidr]
}

resource "azurerm_subnet" "db-subnet" {
  name                 = "db-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = var.rg
  address_prefixes     = [var.dbsubnetcidr]
}