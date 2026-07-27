variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}
variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}
variable "appgw_name" {
  description = "The name of the Application Gateway."
  type        = string
}
variable "subnet_id" {
  description = "The ID of the subnet where the Application Gateway will be deployed."
  type        = string
}