resource "azurerm_public_ip" "this" {
  name                = "${var.name_prefix}-linux-pip"
  location            = var.region
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "this" {
  name                = "${var.name_prefix}-linux-nic"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "this" {
  name                  = "${var.name_prefix}-linux-vm"
  location              = var.region
  resource_group_name   = var.resource_group_name
  size                  = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.this.id]

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.name_prefix}-linux-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = var.tags
}

# Connect to Log Analytics (legacy OMS agent ok for POC demo)
resource "azurerm_virtual_machine_extension" "oms" {
  name                 = "OmsAgentForLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "OmsAgentForLinux"
  type_handler_version = "1.13"

  settings           = jsonencode({ "workspaceId" = var.la_workspace_id })
  protected_settings = jsonencode({})

  depends_on = [azurerm_linux_virtual_machine.this]
}

output "vm_id" { value = azurerm_linux_virtual_machine.this.id }
output "public_ip" { value = azurerm_public_ip.this.ip_address }
