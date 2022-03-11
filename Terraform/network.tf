# Net Creation
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "myNet" {
  name                = "kubernetesnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    environment = "JEPV-CP-2"
  }
}

# Subnet Creation
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnet" {
  name                   = "terraformsubnet"
  resource_group_name    = azurerm_resource_group.resource_group.name
  virtual_network_name   = azurerm_virtual_network.myNet.name
  address_prefixes       = ["10.0.1.0/24"]

}

# NIC Creation for Big VM
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNicBigVM" {
  name                = "VMBig${count.index}Nic${count.index}"
  count               = length(var.big_machines)
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                           = "vmbigipconfig${count.index}"
    subnet_id                      = azurerm_subnet.mySubnet.id
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.${count.index + 10}"
    public_ip_address_id           = azurerm_public_ip.myPublicIpBigVm[count.index].id
  }

  tags = {
    environment = "JEPV-CP-2"
  }

}

# Public IP for Big VM
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIpBigVm" {
  name                = "vmBigip${count.index}"
  count               = length(var.big_machines)
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = {
    environment = "JEPV-CP-2"
  }

}

# NIC Creation for Big VM
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNicSmallVM" {
  name                = "VMSmall${count.index}Nic${count.index}"
  count               = length(var.small_machines)
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                           = "vmsmallipconfig${count.index}"
    subnet_id                      = azurerm_subnet.mySubnet.id
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.${count.index + 20}"
    public_ip_address_id           = azurerm_public_ip.myPublicIpSmallVm[count.index].id
  }

  tags = {
    environment = "JEPV-CP-2"
  }

}

# Public IP for Big VM
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIpSmallVm" {
  name                = "vmSmallip${count.index}"
  count               = length(var.small_machines)
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = {
    environment = "JEPV-CP-2"
  }

}
