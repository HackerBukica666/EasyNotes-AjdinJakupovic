resource "azurerm_mysql_flexible_server" "easynotes-dev-mysql" {
  name                   = var.tf-db-name
  location               = azurerm_resource_group.easynotes-dev-rg.location
  resource_group_name    = azurerm_resource_group.easynotes-dev-rg.name
  version                = "8.0.21"
  sku_name               = "B_Standard_B1ms"
  administrator_login    = var.tf-db-admin-user
  administrator_password = var.tf-db-admin-password
  delegated_subnet_id = azurerm_subnet.easynotes-dev-subnet-mysql.id
}

resource "azurerm_mysql_flexible_server_configuration" "easynotes-dev-mysql" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.easynotes-dev-rg.name
  server_name         = azurerm_mysql_flexible_server.easynotes-dev-mysql.name
  value               = "off"
}


