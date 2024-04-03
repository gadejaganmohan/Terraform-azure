terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "base-api-rg"
  location = "eastus"
}


resource "azurerm_api_management" "api" {
  name                = "apiservice${"nani"}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_email     = "test@contoso.com"
  publisher_name      = "publisher_nani"
  sku_name            = "${"Developer"}_${1}"
}
