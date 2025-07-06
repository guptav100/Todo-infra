module "rg" {
  source = "../Modules/Resouce_Group"
  rg_name = "vishalrg"
  rg_location = "West US"
}

module "vnet"{
    depends_on = [ module.rg ]
    vnet_name = "vishal-vnet"
    source = "../Modules/VNET"
    location = "West US"
    address_space = ["10.0.0.0/16"]
    resource_group_name = "vishalrg"
}

module "subnet" {
    depends_on = [ module.vnet ]
    source = "../Modules/Subnet"
    name = "vishal-subnet"
    address_prefix = ["10.0.1.0/24"]
    resource_group_name = "vishalrg"
    virtual_network_name = "vishal-vnet"
}

#Public IP
resource "azurerm_public_ip" "pip" {
  name = "vishal-public-ip"
  location = "West US"
  resource_group_name = "vishalrg"
  allocation_method = "Static"
}

#NSG
resource "azurerm_network_security_group" "nsg" {
  name = "vishal-nsg"
  location = "West US"
  resource_group_name = "vishalrg"

  security_rule {
    name = "SSH"
    priority = 1002
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*" 
  }

  security_rule {
    name = "HTTP"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*"
    destination_address_prefix = "*" 
  }

}

#NIC
resource "azurerm_network_interface" "nic" {
  name = "vishal-nic"
  location = "West US"
  resource_group_name = "vishalrg"

  ip_configuration {
    name = "internal"
    subnet_id = module.subnet.subnet_id
    private_ip_address = azurerm_public_ip.pip.id
    private_ip_address_allocation = "Dynamic"
  }
}

#Attach NSG to NIC
resource "azurerm_network_interface_security_group_association" "nsga" {
  depends_on = [ azurerm_network_interface.nic ]
  network_interface_id = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


module "sqlserver" {
  source = "../Modules/SQL_server"
  sql_name = "vishal-sever"
  rg_name = "vishalrg"
  rg_location = "West US"
  sql_version = "12.0"
  admin_login = "VishalAdmin"
  admin_login_password = "Vishal@12345"
}


module "sqldb" {
  source = "../Modules/SQL_db"
  depends_on = [ module.sqlserver ]
  db_name =  "vishal-db"
  sku_name = "S0"
  server_id = module.sqlserver.sqlserver_id
  # The db_name variable is defined in the SQL_db module's variable.tf file.
  
}
