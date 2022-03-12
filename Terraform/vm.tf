# Creating a virtual machine
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVMBig" {
    name                = "jepv-cp02-bigvm-${var.big_machines[count.index]}"
    count               = length(var.big_machines)
    resource_group_name = azurerm_resource_group.resource_group.name
    location            = azurerm_resource_group.resource_group.location
    size                = var.vm_big_size
    admin_username      = var.ssh_user
    network_interface_ids = [ azurerm_network_interface.myNicBigVM[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }

    connection {
        host        = self.public_ip_address
        user        = var.ssh_user
        type        = "ssh"
        private_key = file(var.private_key_path)
        timeout     = "5m"
        agent       = false
    }

    provisioner "file" {
        source      = var.public_key_path
        destination = "/home/${var.ssh_user}/.ssh/id_az_stdent.pub"
    }

    provisioner "file" {
        source      = var.private_key_path
        destination = "/home/${var.ssh_user}/.ssh/id_az_stdent"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chmod 600 ~/.ssh/id_az_stdent"
        ]
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
    }

    tags = {
        environment = "JEPV-CP-2"
    }
}

resource "azurerm_linux_virtual_machine" "myVMSmall" {
    name                = "jepv-cp02-smallvm-${var.small_machines[count.index]}"
    count               = length(var.small_machines)
    resource_group_name = azurerm_resource_group.resource_group.name
    location            = azurerm_resource_group.resource_group.location
    size                = var.vm_small_size
    admin_username      = var.ssh_user
    network_interface_ids = [ azurerm_network_interface.myNicSmallVM[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }

    connection {
        host        = self.public_ip_address
        user        = var.ssh_user
        type        = "ssh"
        private_key = file(var.private_key_path)
        timeout     = "5m"
        agent       = false
    }

    provisioner "file" {
        source      = var.public_key_path
        destination = "/home/${var.ssh_user}/.ssh/id_az_stdent.pub"
    }

    provisioner "file" {
        source      = var.private_key_path
        destination = "/home/${var.ssh_user}/.ssh/id_az_stdent"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chmod 600 ~/.ssh/id_az_stdent"
        ]
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
    }

    tags = {
        environment = "JEPV-CP-2"
    }

}
