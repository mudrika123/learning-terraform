variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}
variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}
variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}