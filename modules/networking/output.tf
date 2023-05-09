output "network_name" {
  value = azurerm_virtual_network.main.name
  description = "Name of the Virtual network"
}

output "gwsubnet_id" {
  value = azurerm_subnet.gw-subnet.id
  description = "Id of websubnet in the network"
}

output "websubnet_id" {
  value = azurerm_subnet.web-subnet.id
  description = "Id of websubnet in the network"
}

output "dbsubnet_id" {
  value = azurerm_subnet.db-subnet.id
  description = "Id of dbsubnet in the network"
}