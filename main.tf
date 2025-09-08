locals {
  vnet_cidr     = "10.10.0.0/16"
  workload_cidr = "10.10.1.0/24"

  # Key Vault name: alphanumeric only, <=24 chars
  # example result for prefix "azure-foundation-poc-poc" -> "azurefoundationpockv"
  kv_name_short = "${substr(lower(replace(var.prefix, "-", "")), 0, 22)}kv"
}

# Core Resource Group
module "rg" {
  source      = "./modules/resource-group"
  name_prefix = var.prefix
  region      = var.location
  tags        = var.tags
}

# Log Analytics Workspace
module "log_analytics" {
  source         = "./modules/log-analytics"
  name_prefix    = var.prefix
  region         = var.location
  daily_cap_gb   = 1
  retention_days = 30
  tags           = var.tags
}

# Backup Vault
module "backup_vault" {
  source         = "./modules/backup-vault"
  name_prefix    = var.prefix
  region         = var.location
  tags           = var.tags
  protect_vm_ids = [] # can switch to module.vm_linux.vm_ids if your VM module exports it
}

# Key Vault (in core RG)
module "kv" {
  source              = "./modules/key-vault"
  name                = local.kv_name_short
  location            = var.location
  resource_group_name = module.rg.name
  tenant_id           = var.tenant_id
  ip_allowlist        = var.admin_cidrs
  tags                = var.tags
}

# Networking (creates VNet, Subnet, NSG)
module "network_hub" {
  source        = "./modules/network-hub"
  name_prefix   = var.prefix
  region        = var.location
  address_space = local.vnet_cidr
  my_ip_cidr    = var.admin_cidrs[0]
  tags          = var.tags
}

# --- Secure admin password generation & storage ---
resource "random_password" "linux_admin" {
  length           = 24
  min_upper        = 3
  min_lower        = 3
  min_numeric      = 3
  min_special      = 3
  override_special = "_%@#-+!"
}

resource "azurerm_key_vault_secret" "linux_admin_password" {
  name         = "linux-admin-password"
  value        = random_password.linux_admin.result
  key_vault_id = module.kv.id
}

# Linux VM
module "vm_linux" {
  source              = "./modules/vm-linux"
  name_prefix         = var.prefix
  region              = var.location
  subnet_id           = module.network_hub.workload_subnet_id
  nsg_id              = module.network_hub.workload_nsg_id
  la_workspace_id     = module.log_analytics.workspace_id
  resource_group_name = module.rg.name
  admin_username      = var.admin_username
  admin_password      = random_password.linux_admin.result
  tags                = var.tags
}

# Update Manager integration
module "update_mgr" {
  source      = "./modules/update-manager"
  name_prefix = var.prefix
  tags        = var.tags
}

# Defender for Cloud
module "defender" {
  source                     = "./modules/defender"
  security_email             = var.security_email
  security_phone             = var.security_phone
  enable_kubernetes_defender = false
}

# Action Group (used by alerts)
module "action_group" {
  source              = "./modules/action-group"
  resource_group_name = module.rg.name
  location            = var.location
  name                = "${var.prefix}-ag"
  short_name          = "POCAG"
  emails              = var.budget_contacts
  tags                = var.tags
}

# Monitoring (activity logs + optional VM CPU alert)
module "monitoring" {
  source                     = "./modules/monitoring"
  subscription_id            = var.subscription_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
  resource_group_name        = module.rg.name
  vm_ids                     = [] # set to module.vm_linux.vm_ids if exposed
  action_group_id            = module.action_group.id
}

# Budget (monthly)
module "budgets" {
  source          = "./modules/budgets"
  name            = "${var.prefix}-monthly"
  subscription_id = var.subscription_id
  amount          = var.monthly_budget_usd
  start_date      = "2025-01-01T00:00:00Z"
  end_date        = "2099-12-31T00:00:00Z"
  contact_emails  = var.budget_contacts
}

# Policy assignments (subscription scope)
module "policy" {
  source              = "./modules/policy"
  subscription_id     = var.subscription_id
  resource_group_name = module.rg.name
  log_analytics_id    = module.log_analytics.workspace_id
}
