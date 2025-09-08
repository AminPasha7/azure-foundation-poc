
Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

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
      + admin_username                                         = "amin"
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

  # module.vm_windows.azurerm_network_interface.this will be created
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
      + name                           = "azure-foundation-poc-poc-win-nic"
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

  # module.vm_windows.azurerm_public_ip.this will be created
  + resource "azurerm_public_ip" "this" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "eastus"
      + name                    = "azure-foundation-poc-poc-win-pip"
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

  # module.vm_windows.azurerm_virtual_machine_extension.mma will be created
  + resource "azurerm_virtual_machine_extension" "mma" {
      + failure_suppression_enabled = false
      + id                          = (known after apply)
      + name                        = "MicrosoftMonitoringAgent"
      + protected_settings          = (sensitive value)
      + publisher                   = "Microsoft.EnterpriseCloud.Monitoring"
      + settings                    = (known after apply)
      + type                        = "MicrosoftMonitoringAgent"
      + type_handler_version        = "1.0"
      + virtual_machine_id          = (known after apply)
    }

  # module.vm_windows.azurerm_windows_virtual_machine.this will be created
  + resource "azurerm_windows_virtual_machine" "this" {
      + admin_password                                         = (sensitive value)
      + admin_username                                         = "aminadmin"
      + allow_extension_operations                             = true
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disk_controller_type                                   = (known after apply)
      + enable_automatic_updates                               = true
      + extensions_time_budget                                 = "PT1H30M"
      + hotpatching_enabled                                    = false
      + id                                                     = (known after apply)
      + location                                               = "eastus"
      + max_bid_price                                          = -1
      + name                                                   = "azure-foundation-poc-poc-win-vm"
      + network_interface_ids                                  = (known after apply)
      + patch_assessment_mode                                  = "ImageDefault"
      + patch_mode                                             = "AutomaticByOS"
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
          + name                      = "azure-foundation-poc-poc-win-osdisk"
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "WindowsServer"
          + publisher = "MicrosoftWindowsServer"
          + sku       = "2019-datacenter"
          + version   = "latest"
        }

      + termination_notification (known after apply)
    }

Plan: 16 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + linux_public_ip   = (known after apply)
  + log_analytics_id  = (known after apply)
  + windows_public_ip = (known after apply)
