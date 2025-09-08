variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tenant_id" { type = string }
variable "ip_allowlist" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}

resource "azurerm_key_vault" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  purge_protection_enabled      = true
  soft_delete_retention_days    = 7
  public_network_access_enabled = false

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = var.ip_allowlist
  }

  tags = var.tags
}

output "id" { value = azurerm_key_vault.this.id }
