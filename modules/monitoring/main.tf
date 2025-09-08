variable "subscription_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vm_ids" {
  type    = list(string)
  default = []
}

variable "action_group_id" {
  type = string
}

resource "azurerm_monitor_diagnostic_setting" "subscription_activity" {
  name                       = "sub-activity-to-law"
  target_resource_id         = "/subscriptions/${var.subscription_id}"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "Administrative"
    retention_policy { enabled = false }
  }
  enabled_log {
    category = "Security"
    retention_policy { enabled = false }
  }
  enabled_log {
    category = "ServiceHealth"
    retention_policy { enabled = false }
  }
  enabled_log {
    category = "Alert"
    retention_policy { enabled = false }
  }
  enabled_log {
    category = "Recommendation"
    retention_policy { enabled = false }
  }
  enabled_log {
    category = "Policy"
    retention_policy { enabled = false }
  }
  enabled_log {
    category = "Autoscale"
    retention_policy { enabled = false }
  }
  enabled_log {
    category = "ResourceHealth"
    retention_policy { enabled = false }
  }
}

resource "azurerm_monitor_metric_alert" "vm_cpu" {
  count               = length(var.vm_ids) > 0 ? 1 : 0
  name                = "HighCPU"
  resource_group_name = var.resource_group_name
  scopes              = var.vm_ids
  description         = "Alert on VM CPU > 80% for 5m"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = var.action_group_id
  }
}
