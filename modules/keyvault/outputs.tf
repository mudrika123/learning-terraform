output "mysql_password_secret_id" {
  description = "Key Vault secret ID for the MySQL admin password"
  value       = azurerm_key_vault_secret.mysql_admin_password.id
}

output "mysql_admin_password" {
  description = "The generated MySQL admin password"
  value       = random_password.mysql_admin.result
  sensitive   = true
}

output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.main.id
}