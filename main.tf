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
  source         = "./modules/loadbalancer"
  rg             = module.resourcegroup.rg
  location       = module.resourcegroup.loc_id

  gwsubnet_id    = module.networking.gwsubnet_id
  vnet_name      = var.vnet_name
}

module "vmss" {
  source         = "./modules/vmss"
  rg             = module.resourcegroup.rg
  location       = module.resourcegroup.loc_id

  websubnet_id   = module.networking.websubnet_id
  lb_pool_id     = module.loadbalancer.lb-pool-id
}

module "webconfig" {
  source         = "./modules/webconfig"
  rg             = module.resourcegroup.rg
  location       = module.resourcegroup.loc_id

  scaleset_id    = module.vmss.scaleset_id
}

module "securitygroup" {
  source         = "./modules/securitygroup"
  rg             = module.resourcegroup.rg
  location       = module.resourcegroup.loc_id

  websubnet_id   = module.networking.websubnet_id
}

module "database" {
  source         = "./modules/database"
  rg             = module.resourcegroup.rg
  location       = module.resourcegroup.loc_id
}