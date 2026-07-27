resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.resource_group_name}"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

  resource "azurerm_subnet" "aks" {
    name                 = "snet-aks"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = var.subnet_address_prefix
  }
  resource "azurerm_subnet" "appgw" {
    name                 = "snet-appgw"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = var.appgw_subnet_prefix
}
