resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.mysql_name
  resource_group_name = var.resource_group_name
  location            = var.location
  administrator_login          = var.admin_username
  administrator_password       = var.admin_password
  sku_name             = "B_Standard_B1ms"
  ## plus suporter
  ## storage_mb           = 32768
  version = "8.0.21"
  zone                 = "1"
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  ##high_availability_enabled    = false
}

output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.mysql.fqdn
}