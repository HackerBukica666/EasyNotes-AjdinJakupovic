resource "azurerm_virtual_network" "easynotes-dev-vnet" {
  name                = "easynotes-dev-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.easynotes-dev-rg.location
  resource_group_name = azurerm_resource_group.easynotes-dev-rg.name
}

resource "azurerm_subnet" "easynotes-dev-subnet-aks" {
  name                 = "easynotes-dev-subnet-aks"
  resource_group_name  = azurerm_resource_group.easynotes-dev-rg.name
  virtual_network_name = azurerm_virtual_network.easynotes-dev-vnet.name
  address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "easynotes-dev-subnet-mysql" {
  name                 = "easynotes-dev-subnet-mysql"
  resource_group_name  = azurerm_resource_group.easynotes-dev-rg.name
  virtual_network_name = azurerm_virtual_network.easynotes-dev-vnet.name
  address_prefixes     = ["192.168.2.0/24"]
  delegation {
    name = "mysqlDelegation"
    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_network_security_group" "easynotes-dev-nsg" {
  name                = "easynotes-dev-nsg"
  location            = azurerm_resource_group.easynotes-dev-rg.location
  resource_group_name = azurerm_resource_group.easynotes-dev-rg.name

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "easynotes_dev_subnet_aks_nsg_association" {
  subnet_id                 = azurerm_subnet.easynotes-dev-subnet-aks.id
  network_security_group_id = azurerm_network_security_group.easynotes-dev-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "easynotes_dev_subnet_mysql_nsg_association" {
  subnet_id                 = azurerm_subnet.easynotes-dev-subnet-mysql.id
  network_security_group_id = azurerm_network_security_group.easynotes-dev-nsg.id
}
