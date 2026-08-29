terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "rg-axion-dev"
    storage_account_name = "axiontfstate2026"
    container_name       = "tfstate"
    key                  = "axion-infrastructure.tfstate"
  }
}

provider "azurerm" {
  features {}
}