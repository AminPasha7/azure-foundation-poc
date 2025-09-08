variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "name" {
  type = string
}
variable "short_name" {
  type = string
}
variable "emails" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}

resource "azurerm_monitor_action_group" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name
  tags                = var.tags

  dynamic "email_receiver" {
    for_each = var.emails
    content {
      name          = "email-${replace(email_receiver.value, "@", "-")}"
      email_address = email_receiver.value
    }
  }
}

output "id" {
  value = azurerm_monitor_action_group.this.id
}
