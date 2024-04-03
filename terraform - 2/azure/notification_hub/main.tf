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
  name     = "base-notification-hub-rg"
  location = "eastus"
}



resource "azurerm_notification_hub_namespace" "namespace" {
  name                = "az-notification-hub-namespace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  namespace_type      = "NotificationHub"
  sku_name            = "Free"
}


resource "azurerm_notification_hub" "hub" {
  name                = "hub-nani"
  resource_group_name = azurerm_resource_group.rg.name
  namespace_name      = azurerm_notification_hub_namespace.namespace.name
  location            = azurerm_resource_group.rg.location
}

