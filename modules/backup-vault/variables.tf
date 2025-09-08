variable "name_prefix" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "protect_vm_ids" {
  description = "List of VM IDs to protect in this vault"
  type        = list(string)
}
