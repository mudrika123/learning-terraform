output "server_fqdn" {
  description = "The fully qualified domain name of the MySQL server"
  value       = azurerm_mysql_flexible_server.main.fqdn
}

output "server_name" {
  description = "The name of the MySQL server"
  value       = azurerm_mysql_flexible_server.main.name
}