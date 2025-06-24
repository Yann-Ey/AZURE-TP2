resource "azurerm_app_service_plan" "plan" {
  name                = "${var.app_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    tier = "Basic"
    size = "B1"
  }
  kind = "Linux"
  reserved = true
}

resource "azurerm_app_service" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id
  site_config {
    linux_fx_version = "DOCKER|${var.acr_login_server}/wordpress:latest"
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://${var.acr_login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME     = var.acr_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.acr_password
    WORDPRESS_DB_HOST                   = var.mysql_fqdn
    WORDPRESS_DB_USER                   = "${var.mysql_user}@${split(".", var.mysql_fqdn)[0]}"
    WORDPRESS_DB_PASSWORD               = var.mysql_password
  }
}