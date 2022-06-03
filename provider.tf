terraform {
  backend "azurerm" {
    #   resource_group_name  = "tamopstfstates"
    #   storage_account_name = "tfstatedevops"
    #   container_name       = "terraformgithubexample"
    #   key                  = "terraformgithubexample.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}
