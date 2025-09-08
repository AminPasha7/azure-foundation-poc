resource "azurerm_resource_group" "logs" {
  name     = "${var.name_prefix}-logs-rg"
  location = var.region
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                       = "${var.name_prefix}-law"
  location                   = var.region
  resource_group_name        = azurerm_resource_group.logs.name
  sku                        = "PerGB2018"
  retention_in_days          = var.retention_days
  daily_quota_gb             = var.daily_cap_gb
  internet_ingestion_enabled = true
  internet_query_enabled     = true
  tags                       = var.tags
}

output "workspace_id" { value = azurerm_log_analytics_workspace.this.workspace_id }
