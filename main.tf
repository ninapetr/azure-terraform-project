# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

module "resourcegroup" {
  source         = "./modules/resourcegroup"
  rg_name        = var.rg_name
  rg_location    = var.rg_location
}

module "networking" {
  source         = "./modules/networking"
  rg             = module.resourcegroup.rg
  location       = module.resourcegroup.loc_id
  vnetcidr       = var.vnetcidr
  gwsubnetcidr   = var.gwsubnetcidr
  appsubnetcidr  = var.appsubnetcidr
  dbsubnetcidr   = var.dbsubnetcidr
}