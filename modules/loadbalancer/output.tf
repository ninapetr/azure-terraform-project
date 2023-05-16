output "lb-pool-id" {
  value = azurerm_lb_backend_address_pool.scalesetpool.id
  description = "The ID of the Load balancer in front of the scale set"
}

