resource "azurerm_network_security_group" "nsg" {
  name                = "app-nsg"
  resource_group_name = var.rg
  location            = var.location

  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.websubnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}