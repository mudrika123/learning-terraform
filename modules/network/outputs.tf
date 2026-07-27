output "subnet_id" {
  description = "List of subnet IDs created"
  value       = azurerm_subnet.aks.id
}

output "vnet_id" {
  description = "ID of the virtual network created"
  value       = azurerm_virtual_network.main.id
}
output "appgw_subnet_id" {
  description = "The ID of the Application Gateway subnet"
  value       = azurerm_subnet.appgw.id
}