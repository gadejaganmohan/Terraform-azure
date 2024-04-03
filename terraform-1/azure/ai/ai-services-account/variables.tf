variable "resource_group_location" {
  type		= string
  description	= "Location for all resources"
  default	= "eastus"
}

variable "resource_group_name_prefix" {
  type		= string
  description	= "Prefix of resource group name"
  default	= "rg"
}

variable "sku" {
  type		= string
  description 	= "The sku name of the Azure analysis servies server to create.choose from B1, B2, D1, S0, S1, S2, S3, S4, S8, S9"
  default	= "S0"
}
