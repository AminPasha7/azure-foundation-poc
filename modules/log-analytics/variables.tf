variable "name_prefix" { type = string }
variable "region" { type = string }
variable "daily_cap_gb" { type = number }
variable "retention_days" { type = number }
variable "tags" { type = map(string) }
