# 5. VM (Server1: RedHat : IP 10.0.0.5)
resource "azurerm_network_interface" "server1_nic" {
  name = "nic-server1"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.0.5"
  }
}

resource "azurerm_linux_virtual_machine" "server1" {
  name = "Server1"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = var.vm_size
  admin_username = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
	username = var.admin_username
	public_key = file(var.ssh_public_key_path)
  }

  network_interface_ids = [
    azurerm_network_interface.server1_nic.id,
  ]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer  = "RHEL"
    sku = "9-lvm-gen2"
    version = "latest"
  }
}