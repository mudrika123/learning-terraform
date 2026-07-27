variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "server_name" {
  description = "The name of the MySQL server."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the MySQL server."
  type        = string
  default = "mysqladmin"
}

variable "admin_password" {
  description = "The administrator password for the MySQL server."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU name for the MySQL server."
  type        = string
  default     = "B_Standard_B1ms"
}