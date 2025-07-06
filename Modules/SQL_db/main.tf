resource "azurerm_mssql_database" "sqldb"{
  name = var.db_name
  sku_name = var.sku_name
  server_id = var.server_id
}