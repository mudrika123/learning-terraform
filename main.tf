resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    managed_by  = "Terraform"
    purpose     = "Learning"
  }
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  cluster_name      = "aks-${var.environment}-learning"
  subnet_id          = module.network.subnet_id
  node_count         = 1
  vm_size            = "Standard_B2s_v2"
}

module "mysql" {
  source              = "./modules/mysql"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.mysql_location
  server_name         = "mysql-${var.environment}-learning-v2"
  admin_username      = "mysqladmin"
  admin_password      = module.keyvault.mysql_admin_password
}
module "keyvault" {
  source              = "./modules/keyvault"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  key_vault_name      = "kv-mudrika-learning"
}
module "appgw" {
  source              = "./modules/appgw"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  appgw_name          = "appgw-${var.environment}-learning"
  subnet_id           = module.network.appgw_subnet_id
}