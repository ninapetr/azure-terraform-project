output "lb-id" {
  value = azurerm_lb.scale-set.id
  description = "The ID of the Load balancer in front of the scale set"
}