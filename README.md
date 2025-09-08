# Azure Foundation Proof-of-Concept (POC)

This repository contains **Terraform Infrastructure-as-Code (IaC)** to provision a secure, cost-efficient Azure foundation baseline for SMEs moving to Azure.  
It demonstrates reusable patterns for governance, security, networking, and monitoring — designed with SME cost-sensitivity and best practices in mind.

---

##  Objectives

- Provide a **lean and secure Azure baseline** that can be reused across SMEs.  
- Showcase a **working POC environment** to validate design choices.  
- Ensure **compliance and security alignment** with standards (GDPR, PCI-DSS, CIS, Azure Well-Architected Framework).  
- Deliver Infrastructure-as-Code for repeatable deployments.

---

##  Architecture Overview

```text
+------------------------------------------------------------------------------------------------------------+
|                                            Azure Subscription (POC)                                        |
|                                                                                                            |
|  +------------------------------------ Resource Group ---------------------------------------------------+  |
|  |  azure-foundation-poc-poc-rg                                                                            | 
|  |                                                                                                        |
|  |  +---------------- Key Vault ------------------+        +------------- Action Group ----------------+  |
|  |  | Name: azurefoundationpocpockv               |        | Name: azure-foundation-poc-poc-ag        |  |
|  |  | Access: Private, IP allowlist               |        | Emails: owner@ / finance@                |  |
|  |  | Purge protection: 7d                        |        +------------------------------------------+  |
|  |  | Secret: linux-admin-password (random)       |                                                          |
|  |  +---------------------------------------------+                                                          |
|  |                                                                                                          |
|  |  +----------------- VNet: azure-foundation-poc-poc-vnet ----------------------------------------------+  |
|  |  | Address space: 10.10.0.0/16                                                                         | |
|  |  |                                                                                                      | |
|  |  |  +------- Subnet: workload-snet (10.10.1.0/24) --------------------------------------------------+  | |
|  |  |  |  NSG: azure-foundation-poc-poc-workload-nsg                                                    |  | |
|  |  |  |   - Allow SSH (22)  from admin IP                                                              |  | |
|  |  |  |   - Allow RDP (3389) from admin IP                                                             |  | |
|  |  |  |                                                                                                 |  | |
|  |  |  |   +-------------+         +------------------- public IP -------------------+                    |  | |
|  |  |  |   |  Linux VM   |<------->|  azure-foundation-poc-poc-linux-pip (Standard) |                    |  | |
|  |  |  |   |  B1s/Ubuntu |         +-----------------------------------------------+                    |  | |
|  |  |  |   |  OMS agent  |-----> Sends logs/metrics to Log Analytics                                |   |  | |
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


---


## Cost Estimates (Approximate)

Below are estimated monthly costs for running the SME baseline POC in Azure.  
Estimates assume East US region, Pay-As-You-Go pricing, and baseline consumption levels. Actual costs may vary.

| Service/Component             | 50 Users (Monthly) | 100 Users (Monthly) | Notes |
|-------------------------------|--------------------|---------------------|-------|
| **Azure Linux VM (B1s, test)**| ~$15               | ~$30                | Small VM for demo workloads |
| **Azure Key Vault**           | ~$1                | ~$2                 | Secrets storage (basic ops) |
| **Log Analytics Workspace**   | ~$50               | ~$100               | 5 GB/day ingestion baseline |
| **Azure Backup Vault**        | ~$10               | ~$20                | Protects 1–2 VMs |
| **Defender for Cloud**        | ~$60               | ~$120               | Coverage for VMs & AKS |
| **Azure Monitor & Alerts**    | ~$20               | ~$40                | Metric alerts & monitoring |
| **Budgets & Policies**        | Included           | Included            | Native Azure service |
| **Networking (VNet + NSG)**   | Included           | Included            | No extra charge |
| **Estimated Total**           | **~$156**          | **~$312**           | Monthly subscription baseline |

### Assumptions
- SMEs typically scale workloads as user count grows, hence 2x VM & log/alert usage estimated for 100 users.
- Costs exclude licensing (e.g., Microsoft 365, Intune) — only Azure infrastructure baseline is covered.
- Defender costs assume standard tier for VMs and Kubernetes.
- Log Analytics estimates assume ~5 GB/day ingestion per 50 users, scaling linearly.

---


Components

Networking: Hub VNet with subnet + NSG (restricted SSH/RDP).

Compute: Linux VM with OMS agent, secure password in Key Vault.

Security: Azure Defender (VMs: Standard, AKS: Free).

Governance: Policy assignments (Deny Public IP, Enforce tags).

Monitoring: Log Analytics + Diagnostic settings for subscription activity.

Cost Controls: Subscription budget with 80%/100% alerts.


## Deployment

# Init
terraform init -upgrade

# Validate
terraform validate

# Plan
terraform plan -var-file="envs/poc-eastus.tfvars" -out="poc-eastus.tfplan"

# Apply
terraform apply "poc-eastus.tfplan"


Deliverables

Reusable Terraform modules

Secure admin credentials stored in Azure Key Vault

Logs integrated with Log Analytics

Cost baseline with Budgets

Policy enforcement for SME hygiene


