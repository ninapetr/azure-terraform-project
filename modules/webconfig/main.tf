resource "azurerm_storage_account" "storage1235476457567" {
  name                     = "storage1235476457567"
  resource_group_name      = var.rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = "storage1235476457567"
  container_access_type = "blob"
  depends_on = [azurerm_storage_account.storage1235476457567]
}

resource "azurerm_storage_blob" "server" {
  name                   = "server.sh"
  storage_account_name   = "storage1235476457567"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "./modules/webconfig/configuration/server.sh"
  depends_on = [azurerm_storage_container.data]
}

resource "azurerm_virtual_machine_scale_set_extension" "custom_extension" {
  name                 = "custom-extension"
  virtual_machine_scale_set_id   = var.scaleset_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"
  
  settings = <<SETTINGS
    {
      "fileUris": [
        "https://storage1235476457567.blob.core.windows.net/data/server.sh"
      ],
      "commandToExecute": "bash server.sh"
    }
    SETTINGS
}