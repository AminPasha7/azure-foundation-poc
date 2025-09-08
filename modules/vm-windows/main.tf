resource "azurerm_public_ip" "this" {
  name                = "${var.name_prefix}-win-pip"
  location            = var.region
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "this" {
  name                = "${var.name_prefix}-win-nic"
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

resource "azurerm_windows_virtual_machine" "this" {
  name                  = "${var.name_prefix}-win-vm"
  location              = var.region
  resource_group_name   = var.resource_group_name
  size                  = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.this.id]

  admin_username = var.admin_username
  admin_password = var.admin_password

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.name_prefix}-win-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "mma" {
  name                 = "MicrosoftMonitoringAgent"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "MicrosoftMonitoringAgent"
  type_handler_version = "1.0"

  settings           = jsonencode({ "workspaceId" = var.la_workspace_id })
  protected_settings = jsonencode({})

  depends_on = [azurerm_windows_virtual_machine.this]
}

output "vm_id" { value = azurerm_windows_virtual_machine.this.id }
output "public_ip" { value = azurerm_public_ip.this.ip_address }
