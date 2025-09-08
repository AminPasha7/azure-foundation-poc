output "log_analytics_id" { value = module.log_analytics.workspace_id }
output "key_vault_id" { value = try(module.kv.id, null) }
# Avoid outputting any secrets. Public IP is OK if your module exports it:
output "linux_public_ip" { value = try(module.vm_linux.public_ip, null) }
