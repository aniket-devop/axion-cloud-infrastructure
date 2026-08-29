terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.80"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = "axiontfstate2026"
  resource_group_name      = "rg-axion-dev"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.terraform_state.id
  container_access_type = "private"
}
