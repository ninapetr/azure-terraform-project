variable "rg_name" {
    description = "Resource group name"
}
variable "rg_location" {
    description = "Resource group location region"
}

# Cidr blocks for the network and network subnets
variable "vnetcidr" {}
variable "gwsubnetcidr" {}
variable "appsubnetcidr" {}
variable "dbsubnetcidr" {}
variable "vnet_name" {}