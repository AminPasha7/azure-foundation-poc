# azure-foundation-poc

Lean, secure Azure foundation for SMEs (POC).
This repo starts with structure-only placeholders so you can fill in real Terraform later.

## Folders
- docs/                Client-facing artifacts (diagram, rationale, costs)
- modules/             Reusable Terraform modules (placeholders for now)
- envs/                Per-environment variables (.tfvars examples)
- Root Terraform files main.tf, providers.tf, variables.tf, outputs.tf (stubs)

## Quick start (after you add real TF resources)
terraform -chdir=. init
terraform -chdir=. validate
terraform -chdir=. plan -var-file=envs/poc-eastus.tfvars
