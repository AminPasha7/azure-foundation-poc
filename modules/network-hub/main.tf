resource "azurerm_resource_group" "net" {
  name     = "${var.name_prefix}-net-rg"
  location = var.region
  tags     = var.tags
}

resource "azurerm_virtual_network" "hub" {
  name                = "${var.name_prefix}-vnet"
  address_space       = [var.address_space]
  location            = var.region
  resource_group_name = azurerm_resource_group.net.name
  tags                = var.tags
}

resource "azurerm_subnet" "workload" {
  name                 = "workload-snet"
  resource_group_name  = azurerm_resource_group.net.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_network_security_group" "workload" {
  name                = "${var.name_prefix}-workload-nsg"
  location            = var.region
  resource_group_name = azurerm_resource_group.net.name
  tags                = var.tags

  security_rule {
    name                       = "Allow-SSH-From-MyIP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.my_ip_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-RDP-From-MyIP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.my_ip_cidr
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "workload" {
  subnet_id                 = azurerm_subnet.workload.id
  network_security_group_id = azurerm_network_security_group.workload.id
}

output "workload_subnet_id" { value = azurerm_subnet.workload.id }
output "workload_nsg_id" { value = azurerm_network_security_group.workload.id }
