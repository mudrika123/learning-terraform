variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "appgw_subnet_prefix" {
  description = "The prefix for the Application Gateway subnet."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}