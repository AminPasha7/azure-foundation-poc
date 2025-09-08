
Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_key_vault_secret.linux_admin_password will be created
  + resource "azurerm_key_vault_secret" "linux_admin_password" {
      + id                      = (known after apply)
      + key_vault_id            = (known after apply)
      + name                    = "linux-admin-password"
      + resource_id             = (known after apply)
      + resource_versionless_id = (known after apply)
      + value                   = (sensitive value)
      + version                 = (known after apply)
      + versionless_id          = (known after apply)
    }

  # random_password.linux_admin will be created
  + resource "random_password" "linux_admin" {
      + bcrypt_hash      = (sensitive value)
      + id               = (known after apply)
      + length           = 24
      + lower            = true
      + min_lower        = 3
      + min_numeric      = 3
      + min_special      = 3
      + min_upper        = 3
      + number           = true
      + numeric          = true
      + override_special = "_%@#-+!"
      + result           = (sensitive value)
      + special          = true
      + upper            = true
    }

  # module.action_group.azurerm_monitor_action_group.this will be created
  + resource "azurerm_monitor_action_group" "this" {
      + enabled             = true
      + id                  = (known after apply)
      + location            = "global"
      + name                = "azure-foundation-poc-poc-ag"
      + resource_group_name = "azure-foundation-poc-poc-rg"
      + short_name          = "POCAG"
      + tags                = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }

      + email_receiver {
          + email_address = "owner@example.com"
          + name          = "email-owner-example.com"
        }
      + email_receiver {
          + email_address = "finance@example.com"
          + name          = "email-finance-example.com"
        }
    }

  # module.budgets.azurerm_consumption_budget_subscription.this will be created
  + resource "azurerm_consumption_budget_subscription" "this" {
      + amount          = 100
      + etag            = (known after apply)
      + id              = (known after apply)
      + name            = "azure-foundation-poc-poc-monthly"
      + subscription_id = "/subscriptions/910ed080-654d-4049-b637-6d53b903a892"
      + time_grain      = "Monthly"

      + notification {
          + contact_emails = [
              + "owner@example.com",
              + "finance@example.com",
            ]
          + contact_groups = []
          + contact_roles  = []
          + enabled        = true
          + operator       = "GreaterThan"
          + threshold      = 100
          + threshold_type = "Actual"
        }
      + notification {
          + contact_emails = [
              + "owner@example.com",
              + "finance@example.com",
            ]
          + contact_groups = []
          + contact_roles  = []
          + enabled        = true
          + operator       = "GreaterThan"
          + threshold      = 80
          + threshold_type = "Actual"
        }

      + time_period {
          + end_date   = "2099-12-31T00:00:00Z"
          + start_date = "2025-01-01T00:00:00Z"
        }
    }

  # module.defender.azurerm_security_center_contact.security will be created
  + resource "azurerm_security_center_contact" "security" {
      + alert_notifications = true
      + alerts_to_admins    = true
      + email               = "security@example.com"
      + id                  = (known after apply)
      + name                = "default1"
      + phone               = "+1-555-0100"
    }

  # module.defender.azurerm_security_center_subscription_pricing.aks will be created
  + resource "azurerm_security_center_subscription_pricing" "aks" {
      + id            = (known after apply)
      + resource_type = "KubernetesService"
      + tier          = "Free"
    }

  # module.defender.azurerm_security_center_subscription_pricing.vms will be created
  + resource "azurerm_security_center_subscription_pricing" "vms" {
      + id            = (known after apply)
      + resource_type = "VirtualMachines"
      + tier          = "Standard"
    }

  # module.kv.azurerm_key_vault.this will be created
  + resource "azurerm_key_vault" "this" {
      + access_policy                 = (known after apply)
      + id                            = (known after apply)
      + location                      = "eastus"
      + name                          = "azurefoundationpocpockv"
      + public_network_access_enabled = false
      + purge_protection_enabled      = true
      + resource_group_name           = "azure-foundation-poc-poc-rg"
      + sku_name                      = "standard"
      + soft_delete_retention_days    = 7
      + tags                          = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
      + tenant_id                     = "3757cf14-95b3-43c4-b707-db57d261c228"
      + vault_uri                     = (known after apply)

      + contact (known after apply)

      + network_acls {
          + bypass         = "AzureServices"
          + default_action = "Deny"
          + ip_rules       = [
              + "175.143.92.178/32",
            ]
        }
    }

  # module.log_analytics.azurerm_log_analytics_workspace.this will be created
  + resource "azurerm_log_analytics_workspace" "this" {
      + allow_resource_only_permissions = true
      + daily_quota_gb                  = 1
      + id                              = (known after apply)
      + internet_ingestion_enabled      = true
      + internet_query_enabled          = true
      + local_authentication_disabled   = false
      + location                        = "eastus"
      + name                            = "azure-foundation-poc-poc-law"
      + primary_shared_key              = (sensitive value)
      + resource_group_name             = "azure-foundation-poc-poc-logs-rg"
      + retention_in_days               = 30
      + secondary_shared_key            = (sensitive value)
      + sku                             = "PerGB2018"
      + tags                            = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
      + workspace_id                    = (known after apply)
    }

  # module.log_analytics.azurerm_resource_group.logs will be created
  + resource "azurerm_resource_group" "logs" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "azure-foundation-poc-poc-logs-rg"
      + tags     = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
    }

  # module.monitoring.azurerm_monitor_diagnostic_setting.subscription_activity will be created
  + resource "azurerm_monitor_diagnostic_setting" "subscription_activity" {
      + id                             = (known after apply)
      + log_analytics_destination_type = (known after apply)
      + log_analytics_workspace_id     = (known after apply)
      + name                           = "sub-activity-to-law"
      + target_resource_id             = "/subscriptions/910ed080-654d-4049-b637-6d53b903a892"

      + enabled_log (known after apply)

      + log {
          + category       = "Administrative"
          + enabled        = true
            # (1 unchanged attribute hidden)

          + retention_policy {
              + enabled = false
            }
        }
      + log {
          + category       = "Alert"
          + enabled        = true
            # (1 unchanged attribute hidden)

          + retention_policy {
              + enabled = false
            }
        }
      + log {
          + category       = "Autoscale"
          + enabled        = true
            # (1 unchanged attribute hidden)

          + retention_policy {
              + enabled = false
            }
        }
      + log {
          + category       = "Policy"
          + enabled        = true
            # (1 unchanged attribute hidden)

          + retention_policy {
              + enabled = false
            }
        }
      + log {
          + category       = "Recommendation"
          + enabled        = true
            # (1 unchanged attribute hidden)

          + retention_policy {
              + enabled = false
            }
        }
      + log {
          + category       = "ResourceHealth"
          + enabled        = true
            # (1 unchanged attribute hidden)

          + retention_policy {
              + enabled = false
            }
        }
      + log {
          + category       = "Security"
          + enabled        = true
            # (1 unchanged attribute hidden)

          + retention_policy {
              + enabled = false
            }
        }
      + log {
          + category       = "ServiceHealth"
          + enabled        = true
            # (1 unchanged attribute hidden)

          + retention_policy {
              + enabled = false
            }
        }
    }

  # module.network_hub.azurerm_network_security_group.workload will be created
  + resource "azurerm_network_security_group" "workload" {
      + id                  = (known after apply)
      + location            = "eastus"
      + name                = "azure-foundation-poc-poc-workload-nsg"
      + resource_group_name = "azure-foundation-poc-poc-net-rg"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "Allow-SSH-From-MyIP"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "175.143.92.178/32"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
                # (1 unchanged attribute hidden)
            },
          + {
              + access                                     = "Allow"
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "3389"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "Allow-RDP-From-MyIP"
              + priority                                   = 110
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "175.143.92.178/32"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
                # (1 unchanged attribute hidden)
            },
        ]
      + tags                = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
    }

  # module.network_hub.azurerm_resource_group.net will be created
  + resource "azurerm_resource_group" "net" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "azure-foundation-poc-poc-net-rg"
      + tags     = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
    }

  # module.network_hub.azurerm_subnet.workload will be created
  + resource "azurerm_subnet" "workload" {
      + address_prefixes                               = [
          + "10.10.1.0/24",
        ]
      + default_outbound_access_enabled                = true
      + enforce_private_link_endpoint_network_policies = (known after apply)
      + enforce_private_link_service_network_policies  = (known after apply)
      + id                                             = (known after apply)
      + name                                           = "workload-snet"
      + private_endpoint_network_policies              = (known after apply)
      + private_endpoint_network_policies_enabled      = (known after apply)
      + private_link_service_network_policies_enabled  = (known after apply)
      + resource_group_name                            = "azure-foundation-poc-poc-net-rg"
      + virtual_network_name                           = "azure-foundation-poc-poc-vnet"
    }

  # module.network_hub.azurerm_subnet_network_security_group_association.workload will be created
  + resource "azurerm_subnet_network_security_group_association" "workload" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.network_hub.azurerm_virtual_network.hub will be created
  + resource "azurerm_virtual_network" "hub" {
      + address_space       = [
          + "10.10.0.0/16",
        ]
      + dns_servers         = (known after apply)
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "eastus"
      + name                = "azure-foundation-poc-poc-vnet"
      + resource_group_name = "azure-foundation-poc-poc-net-rg"
      + subnet              = (known after apply)
      + tags                = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
    }

  # module.policy.azurerm_subscription_policy_assignment.deny_public_ip will be created
  + resource "azurerm_subscription_policy_assignment" "deny_public_ip" {
      + display_name         = "Deny public IP on network interfaces"
      + enforce              = true
      + id                   = (known after apply)
      + metadata             = (known after apply)
      + name                 = "deny-public-ip"
      + policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2f0f1b5a-5c3d-4c3f-82f4-0e23a6b3e6c2"
      + subscription_id      = "/subscriptions/910ed080-654d-4049-b637-6d53b903a892"
    }

  # module.policy.azurerm_subscription_policy_assignment.require_tags will be created
  + resource "azurerm_subscription_policy_assignment" "require_tags" {
      + display_name         = "Require tag and its value"
      + enforce              = true
      + id                   = (known after apply)
      + metadata             = (known after apply)
      + name                 = "require-core-tags"
      + parameters           = jsonencode(
            {
              + tagName  = {
                  + value = "costCenter"
                }
              + tagValue = {
                  + value = "sme-poc"
                }
            }
        )
      + policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f3afdf9-62d3-4d83-8e7d-7181b4c3b6d6"
      + subscription_id      = "/subscriptions/910ed080-654d-4049-b637-6d53b903a892"
    }

  # module.rg.azurerm_resource_group.this will be created
  + resource "azurerm_resource_group" "this" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "azure-foundation-poc-poc-rg"
      + tags     = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
    }

  # module.vm_linux.azurerm_linux_virtual_machine.this will be created
  + resource "azurerm_linux_virtual_machine" "this" {
      + admin_password                                         = (sensitive value)
      + admin_username                                         = "pocsvcadmin"
      + allow_extension_operations                             = true
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = false
      + disk_controller_type                                   = (known after apply)
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "eastus"
      + max_bid_price                                          = -1
      + name                                                   = "azure-foundation-poc-poc-linux-vm"
      + network_interface_ids                                  = (known after apply)
      + patch_assessment_mode                                  = "ImageDefault"
      + patch_mode                                             = "ImageDefault"
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = true
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "azure-foundation-poc-poc-rg"
      + size                                                   = "Standard_B1s"
      + tags                                                   = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
      + virtual_machine_id                                     = (known after apply)
      + vm_agent_platform_updates_enabled                      = false

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = "azure-foundation-poc-poc-linux-osdisk"
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "0001-com-ubuntu-server-jammy"
          + publisher = "Canonical"
          + sku       = "22_04-lts"
          + version   = "latest"
        }

      + termination_notification (known after apply)
    }

  # module.vm_linux.azurerm_network_interface.this will be created
  + resource "azurerm_network_interface" "this" {
      + accelerated_networking_enabled = (known after apply)
      + applied_dns_servers            = (known after apply)
      + dns_servers                    = (known after apply)
      + enable_accelerated_networking  = (known after apply)
      + enable_ip_forwarding           = (known after apply)
      + id                             = (known after apply)
      + internal_domain_name_suffix    = (known after apply)
      + ip_forwarding_enabled          = (known after apply)
      + location                       = "eastus"
      + mac_address                    = (known after apply)
      + name                           = "azure-foundation-poc-poc-linux-nic"
      + private_ip_address             = (known after apply)
      + private_ip_addresses           = (known after apply)
      + resource_group_name            = "azure-foundation-poc-poc-rg"
      + tags                           = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
      + virtual_machine_id             = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "ipconfig1"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # module.vm_linux.azurerm_public_ip.this will be created
  + resource "azurerm_public_ip" "this" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "eastus"
      + name                    = "azure-foundation-poc-poc-linux-pip"
      + resource_group_name     = "azure-foundation-poc-poc-rg"
      + sku                     = "Standard"
      + sku_tier                = "Regional"
      + tags                    = {
          + "env"     = "poc"
          + "owner"   = "amin"
          + "project" = "azure-foundation-poc"
          + "purpose" = "poc"
        }
    }

  # module.vm_linux.azurerm_virtual_machine_extension.oms will be created
  + resource "azurerm_virtual_machine_extension" "oms" {
      + failure_suppression_enabled = false
      + id                          = (known after apply)
      + name                        = "OmsAgentForLinux"
      + protected_settings          = (sensitive value)
      + publisher                   = "Microsoft.EnterpriseCloud.Monitoring"
      + settings                    = (known after apply)
      + type                        = "OmsAgentForLinux"
      + type_handler_version        = "1.13"
      + virtual_machine_id          = (known after apply)
    }

Plan: 23 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + key_vault_id     = (known after apply)
  + linux_public_ip  = (known after apply)
  + log_analytics_id = (known after apply)
