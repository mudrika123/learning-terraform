variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
  default     = "rg-terraform-learning"
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, test, prod)."
  type        = string
  default     = "dev"
}
variable "mysql_location" {
  description = "Azure region for MySQL Flexible Server (may differ due to regional availability)"
  type        = string
  default     = "Southeast Asia"
}
