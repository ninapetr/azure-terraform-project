resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = var.rg
  location            = var.location
  address_space       = [var.vnetcidr]
}

resource "azurerm_subnet" "gw-subnet" {
  name                 = "gw-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = var.rg
  address_prefixes     = [var.gwsubnetcidr]
}

resource "azurerm_subnet" "web-subnet" {
  name                 = "web-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = var.rg
  address_prefixes     = [var.websubnetcidr]
}

resource "azurerm_subnet" "db-subnet" {
  name                 = "db-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = var.rg
  address_prefixes     = [var.dbsubnetcidr]
}