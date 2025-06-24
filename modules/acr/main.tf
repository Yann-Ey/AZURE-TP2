resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

output "login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "username" {
  value = azurerm_container_registry.acr.admin_username
}

output "password" {
  value = azurerm_container_registry.acr.admin_password
}