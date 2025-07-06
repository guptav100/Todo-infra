resource "azurerm_subnet" "subnet" {
    name = var.name
    address_prefixes = var.address_prefix
    resource_group_name = var.resource_group_name
    virtual_network_name = var.virtual_network_name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}