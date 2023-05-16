resource "azurerm_linux_virtual_machine_scale_set" "scale_set" {
  name                = "scale-set"
  resource_group_name = var.rg
  location            = var.location
  sku                 = "Standard_F2"
  instances           = 2
  admin_password      = "Azure@123"
  admin_username      = "vmuser"
  disable_password_authentication = false
  upgrade_mode = "Automatic"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "scaleset-interface"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.websubnet_id
      load_balancer_backend_address_pool_ids =[var.lb_pool_id]
    }    
  }
}