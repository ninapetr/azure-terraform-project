resource "azurerm_postgresql_server" "psql_server" {
  name                = "psql-server46556456"
  resource_group_name = var.rg
  location            = var.location

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "psqladmin"
  administrator_login_password = "H@Sh1CoR3!"
  version                      = "9.5"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "example" {
  name                = "exampledb"
  resource_group_name = var.rg
  server_name         = azurerm_postgresql_server.psql_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}