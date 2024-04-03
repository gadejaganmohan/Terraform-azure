terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

provider "azurerm" {
  features {}
}



resource "azurerm_resource_group" "rg" {
  location = "eastus"
  name     = "my-pet-rg"
}

locals {
  create_signing_cert = try(!fileexists("~/.certs/cert.pem"), true)
}

resource "tls_private_key" "signing_cert" {
  count = local.create_signing_cert ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "attestation" {
  count = local.create_signing_cert ? 1 : 0

  private_key_pem = tls_private_key.signing_cert[0].private_key_pem
  validity_period_hours = 12
  allowed_uses = [
    "cert_signing",
  ]
}


resource "azurerm_attestation_provider" "corp_attestation" {
  location                        = azurerm_resource_group.rg.location
  name                            = "myattestation220523"
  resource_group_name             = azurerm_resource_group.rg.name
  policy_signing_certificate_data = try(tls_self_signed_cert.attestation[0].cert_pem, file("~/.certs/cert.pem"))
}


