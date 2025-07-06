resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sql_name
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = var.sql_version
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_login_password
}
output "sqlserver_id" {
  value = azurerm_mssql_server.sqlserver.id
}