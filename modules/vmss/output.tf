output "scaleset_id" {
    value = azurerm_linux_virtual_machine_scale_set.scale_set.id
    description = "ID of the scale set"
}