resource "azurerm_linux_virtual_machine" "vm" {
  name = var.vm_name
  location = var.location
  resource_group_name = var.resource_group_name
  size = var.vm_size
  admin_username = var.admin_username
  network_interface_ids = [var.nic.id]

  admin_ssh_key{
    username = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk{
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference{
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "20.0.4-LTS"
    version = "latest"
  }
}