# Subscription-scope assignments

resource "azurerm_subscription_policy_assignment" "deny_public_ip" {
  name                 = "deny-public-ip"
  subscription_id      = "/subscriptions/${var.subscription_id}"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2f0f1b5a-5c3d-4c3f-82f4-0e23a6b3e6c2"
  display_name         = "Deny public IP on network interfaces"
}

resource "azurerm_subscription_policy_assignment" "require_tags" {
  name                 = "require-core-tags"
  subscription_id      = "/subscriptions/${var.subscription_id}"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f3afdf9-62d3-4d83-8e7d-7181b4c3b6d6"
  display_name         = "Require tag and its value"
  parameters = jsonencode({
    tagName  = { value = "costCenter" }
    tagValue = { value = "sme-poc" }
  })
}

