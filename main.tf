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
  features {}
}

module "resourcegroup" {
  source         = "./modules/resourcegroup"
  name           = var.rg_name
  location       = var.rg_location
}

module "networking" {
  source         = "./modules/networking"
  location       = module.resourcegroup.loc_id
  resource_group = module.resourcegroup.rg_name
  vnetcidr       = var.vnetcidr
  websubnetcidr  = var.gwsubnetcidr
  appsubnetcidr  = var.appsubnetcidr
  dbsubnetcidr   = var.dbsubnetcidr
}