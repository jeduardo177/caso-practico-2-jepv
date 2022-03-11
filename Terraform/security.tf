# Security group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "mySecGroup" {
    name                = "sshtraffic"
    location            = azurerm_resource_group.resource_group.location
    resource_group_name = azurerm_resource_group.resource_group.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "JEPV-CP-2"
    }
}

# We bind the security group to the network interface
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "mySecGroupAssociationVmBig" {
    network_interface_id      = azurerm_network_interface.myNicBigVM[count.index].id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id
    count                     = length(var.small_machines)
}

resource "azurerm_network_interface_security_group_association" "mySecGroupAssociationVmSmall" {
    network_interface_id      = azurerm_network_interface.myNicSmallVM[count.index].id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id
    count                     = length(var.small_machines)
}
