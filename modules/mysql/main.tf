resource "azurerm_mysql_flexible_server" "main" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.admin_username
  administrator_password = var.admin_password

  sku_name   = var.sku_name
  version    = "8.0.21"
  storage{
    size_gb=20
  }

  backup_retention_days = 7

  lifecycle {
    ignore_changes = [zone]
  }
}

 resource "azurerm_mysql_flexible_server_firewall_rule" "allow_aks" {
  name                = "allow_aks_subnet"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.main.name
  start_ip_address    = "10.0.1.0"
  end_ip_address      = "10.0.1.255"
 }