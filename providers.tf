terraform{
    required_version = ">=1.5.0"

    required_providers{
        azurerm={
            source = "hashicorp/azurerm"
            version = "~> 3.100"
        }
        random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    }
backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatemudrika2026"
    container_name       = "tfstate"
    key                  = "learning.tfstate"
}
}
provider "azurerm" {
    features{}
}
