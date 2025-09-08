resource "azurerm_resource_group" "this" {
  name     = "${var.name_prefix}-rg"
  location = var.region
  tags     = var.tags
}

output "name" {
  value = azurerm_resource_group.this.name
}
