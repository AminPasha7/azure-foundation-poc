variable "name" { type = string }
variable "subscription_id" { type = string }
variable "amount" { type = number }
variable "start_date" { type = string }
variable "end_date" { type = string }
variable "contact_emails" { type = list(string) }

resource "azurerm_consumption_budget_subscription" "this" {
  name            = var.name
  subscription_id = "/subscriptions/${var.subscription_id}"
  amount          = var.amount
  time_grain      = "Monthly"

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  notification {
    enabled        = true
    operator       = "GreaterThan"
    threshold      = 80
    contact_emails = var.contact_emails
  }

  notification {
    enabled        = true
    operator       = "GreaterThan"
    threshold      = 100
    contact_emails = var.contact_emails
  }
}

