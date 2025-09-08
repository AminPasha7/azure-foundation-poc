variable "security_email" { type = string }
variable "security_phone" { type = string }
variable "enable_kubernetes_defender" {
  type    = bool
  default = false
}

resource "azurerm_security_center_contact" "security" {
  name                = "default1"
  email               = var.security_email
  phone               = var.security_phone
  alert_notifications = true
  alerts_to_admins    = true
}

resource "azurerm_security_center_subscription_pricing" "vms" {
  resource_type = "VirtualMachines"
  tier          = "Standard"
}

resource "azurerm_security_center_subscription_pricing" "aks" {
  resource_type = "KubernetesService"
  tier          = var.enable_kubernetes_defender ? "Standard" : "Free"
}
