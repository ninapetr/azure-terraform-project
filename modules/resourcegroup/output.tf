output "rg_name" {
    value = azurerm_resource_group.azure-stack-rs.name
    description = "Name of the resource group."
}

output "loc_id" {
    value = azurerm_resource_group.azure-stack-rs.location
    description = "Location id of the resource group"
}