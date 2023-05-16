resource "azurerm_public_ip" "load_ip" {
  name                = "load-ip"
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = "Static"
  sku = "Standard"
  zones = ["1", "2", "3"]
}

resource "azurerm_lb" "app_balancer" {
  name                = "app-balancer"
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"
  sku_tier            = "Regional"
  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.load_ip.id
  }

  depends_on=[
    azurerm_public_ip.load_ip
  ]
}

resource "azurerm_lb_backend_address_pool" "scalesetpool" {
  loadbalancer_id = azurerm_lb.app_balancer.id
  name            = "scalesetpool"
  depends_on=[
    azurerm_lb.app_balancer
  ]
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id     = azurerm_lb.app_balancer.id
  name                = "probe"
  port                = 80
  protocol            = "Tcp"
  depends_on=[
    azurerm_lb.app_balancer
  ]
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.app_balancer.id
  name                           = "RuleA"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip"
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.scalesetpool.id ]
}
