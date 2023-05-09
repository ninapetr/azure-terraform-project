resource "azurerm_virtual_network" "main" {
  name                = "main"
  resource_group_name = var.rg_name
  location            = var.rg_location
  address_space       = [var.vnetcidr]
}

resource "azurerm_subnet" "gw-subnet" {
  name                 = "gw-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name = var.rg_name
  address_prefixes     = [var.websubnetcidr]
}

resource "azurerm_subnet" "app-subnet" {
  name                 = "app-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name = var.rg_name
  address_prefixes     = [var.appsubnetcidr]
}

resource "azurerm_subnet" "db-subnet" {
  name                 = "db-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name = var.rg_name
  address_prefixes     = [var.dbsubnetcidr]
}