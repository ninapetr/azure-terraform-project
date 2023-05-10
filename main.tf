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
  vnet_name      = var.vnet_name
  gwsubnetcidr   = var.gwsubnetcidr
  websubnetcidr  = var.websubnetcidr
  dbsubnetcidr   = var.dbsubnetcidr
}

module "loadbalancer" {
  source         = "./modules/gateway"
  rg             = module.resourcegroup.rg
  location       = module.resourcegroup.loc_id

  gwsubnet_id    = module.networking.gwsubnet_id
  vnet_name      = var.vnet_name
}

#module "loadbalancer" {
#  source         = "./modules/securitygroup"
#  rg             = module.resourcegroup.rg
#  location       = module.resourcegroup.loc_id


#}

module "vmss" {
  source         = "./modules/webtier"
  rg             = module.resourcegroup.rg
  location       = module.resourcegroup.loc_id

  websubnet_id   = module.networking.websubnet_id
}