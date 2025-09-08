variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "rg_name" {
  type    = string
  default = "azure-foundation-poc-poc-rg"
}

variable "prefix" {
  type    = string
  default = "azure-foundation-poc-poc"
}

variable "admin_cidrs" {
  type    = list(string)
  default = []
}

variable "security_email" {
  type = string
}

variable "security_phone" {
  type = string
}

variable "monthly_budget_usd" {
  type    = number
  default = 100
}

variable "budget_contacts" {
  type    = list(string)
  default = []
}

variable "tags" {
  type = map(string)
  default = {
    env     = "poc"
    owner   = "amin"
    project = "azure-foundation-poc"
    purpose = "poc"
  }
}

# Username only (password is generated & stored in Key Vault)
variable "admin_username" {
  type = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9_-]{2,30}$", var.admin_username)) && !contains(["admin", "root", "administrator"], lower(var.admin_username))
    error_message = "Username must start with a letter, be 3–31 chars, and not be a common admin name."
  }
}
