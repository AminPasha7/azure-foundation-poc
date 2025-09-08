# Azure Foundation POC

This repository contains Terraform code for setting up a secure Azure foundation proof-of-concept (POC).  
It provisions core resources such as Networking, Log Analytics, Key Vault, Defender for Cloud, Monitoring, and VM workloads.

## Architecture Overview

```text
+------------------------------------------------------------------------------------------------------------+
|                                            Azure Subscription (poc)                                        |
|                                                                                                            |
|  +------------------------------------ Resource Group ---------------------------------------------------+  |
|  |  azure-foundation-poc-poc-rg                                                                            |
|  |                                                                                                        |
|  |  +---------------- Key Vault ------------------+        +------------- Action Group ----------------+  |
|  |  | Name: azurefoundationpocpockv               |        | Name: azure-foundation-poc-poc-ag        |  |
|  |  | Access: Private, IP allowlist               |        | Emails: owner@ / finance@                |  |
|  |  | Purge protection: 7d                        |        +------------------------------------------+  |
|  |  | Secret: linux-admin-password (random)       |                                              |
|  |  +---------------------------------------------+                                              |
|  |                                                                                               |
|  |  +----------------- VNet: azure-foundation-poc-poc-vnet ----------------------------------------------+  |
|  |  | Address space: 10.10.0.0/16                                                                         | |
|  |  |                                                                                                      | |
|  |  |  +------- Subnet: workload-snet (10.10.1.0/24) --------------------------------------------------+  | |
|  |  |  |  NSG: azure-foundation-poc-poc-workload-nsg                                                    |  | |
|  |  |  |   - Allow SSH (22)  from 175.143.92.178/32                                                      |  | |
|  |  |  |   - Allow RDP (3389) from 175.143.92.178/32                                                     |  | |
|  |  |  |                                                                                                 |  | |
|  |  |  |   +-------------+         +------------------- public IP -------------------+                    |  | |
|  |  |  |   |  Linux VM   |<------->|  azure-foundation-poc-poc-linux-pip (Standard) |                    |  | |
|  |  |  |   |  B1s/Ubuntu |         +-----------------------------------------------+                    |  | |
|  |  |  |   |  OMS agent  |-----> Sends logs/metrics to Log Analytics                                   |  | |
|  |  |  |   +-------------+                                                                              |  | |
|  |  |  +-----------------------------------------------------------------------------------------------+  | |
|  |  +----------------------------------------------------------------------------------------------------+  |
|                                                                                                            |
|  [Monitoring]                                                                                              |
|   - Subscription Activity Logs → Log Analytics (Administrative, Security, ServiceHealth, etc.)             |
|                                                                                                            |
|  +------------------------------- Logs RG ---------------------------------------------------------------+  |
|  |  azure-foundation-poc-poc-logs-rg                                                                    |  |
|  |  Log Analytics Workspace: azure-foundation-poc-poc-law (PerGB2018)                                   |  |
|  |   - Retention: 30 days  | Daily cap: 1 GB                                                            |  |
|  +------------------------------------------------------------------------------------------------------+  |
|                                                                                                            |
|  [Budgets]  Subscription monthly budget: $100 (80% & 100% email alerts)                                    |
|  [Policies] Subscription assignments: Deny Public IP on NICs; Require tag (costCenter = "sme-poc")         |
+------------------------------------------------------------------------------------------------------------+
