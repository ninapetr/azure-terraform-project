locals {
  first_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWruQeQGEtINxpHfehvqCJYr0DObpsdyHsJs1f7mTJsoEV/8LyUb/8BGDKmcljds3D4AUB8iiq3/E1E2g/ntToc5hc0Lp32UPN24ASNczVOW787dmkYhB2y0UE13NoZ7/AcO8Y7/XeoQWfS0hO8kyQmqDVx2g+8kx7qxCUF2zmxd9P"
}

resource "azurerm_linux_virtual_machine_scale_set" "scale-set" {
  name                = "scale-set"
  resource_group_name = var.rg
  location            = var.location

  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"
  admin_password      = "password123"
  disable_password_authentication = false

  #admin_ssh_key {
  #  username   = "admin"
  #  public_key = local.first_public_key
  #}
  

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
    name    = "net_int"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.websubnet_id
    }
  }
}