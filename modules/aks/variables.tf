variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be deployed."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the AKS cluster."
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "The size of the virtual machines in the AKS cluster."
  type        = string
  default     = "Standard_B2s"
}