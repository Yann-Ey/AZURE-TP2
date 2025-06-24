provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Groupes de ressources
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

##module "network" {
##  source = "./modules/network"
##  resource_group_name = azurerm_resource_group.rg.name
##  location            = var.location
## }

module "acr" {
  source = "./modules/acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  acr_name            = var.acr_name
}

module "mysql" {
  source = "./modules/mysql"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  mysql_name          = var.mysql_name
  admin_username      = var.mysql_admin
  admin_password      = var.mysql_password
}

module "webapp" {
  source = "./modules/webapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  app_name            = var.webapp_name
  acr_login_server    = module.acr.login_server
  acr_username        = module.acr.username
  acr_password        = module.acr.password
  mysql_fqdn          = module.mysql.mysql_fqdn
  mysql_user          = var.mysql_admin
  mysql_password      = var.mysql_password
}   