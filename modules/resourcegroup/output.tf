output "rg" {
    value = azurerm_resource_group.individual-project.name
    description = "Name of the resource group."
}

output "loc_id" {
    value = azurerm_resource_group.individual-project.location
    description = "Location id of the resource group"
}