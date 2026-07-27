# Learning Terraform — Modular Azure Infrastructure

A self-directed project to build hands-on Terraform experience by provisioning a
realistic Azure environment: AKS, MySQL, Application Gateway, Key Vault, and
networking — all modular, with remote state and CI/CD-driven deployment.

This was built independently to close a gap in my production experience (my
day-to-day client work involves Azure/AKS/GitHub, but Terraform was owned by a
separate infrastructure team) — so I built this to actually learn it hands-on.

## Architecture
                    Internet
                       │
              ┌────────▼────────┐
              │  Application     │
              │  Gateway (public)│
              └────────┬────────┘
                       │
              ┌────────▼────────┐
              │   AKS Cluster    │──────┐
              │  (snet-aks)      │      │
              └──────────────────┘      │
                                        │
              ┌─────────────────────────▼──┐
              │  Azure Database for MySQL   │
              │  Flexible Server             │
              │  (firewall scoped to AKS subnet)
              └──────────────────────────────┘

              ┌──────────────────┐
              │    Key Vault      │  ← stores DB password
              │  (Terraform-      │    (random_password,
              │   generated       │     never in plaintext)
              │   secret)         │
              └──────────────────┘

## Modules

| Module | Purpose |
|---|---|
| `network` | VNet with two dedicated subnets (AKS, Application Gateway) |
| `aks` | AKS cluster with Azure CNI networking, System-Assigned identity |
| `keyvault` | Key Vault storing a Terraform-generated MySQL password |
| `mysql` | Azure Database for MySQL Flexible Server, firewall-scoped to the AKS subnet |
| `appgw` | Application Gateway (Standard_v2) with listener/routing rule configured |

## Key design decisions

- **Remote state** — stored in Azure Storage (not local), with automatic locking.
- **Secrets never touch a file** — MySQL's password is generated via Terraform's
  `random_password` resource, stored directly in Key Vault, and referenced by
  the MySQL module — it's never typed or committed anywhere.
- **Least-privilege networking** — the MySQL firewall rule allows traffic only
  from the AKS subnet's CIDR range, not from all IPs.
- **CI/CD-driven deployment** — GitHub Actions runs `terraform plan` on every
  pull request, and `terraform apply` only runs after manual approval, mirroring
  a real production promotion gate.

## Real issues hit and resolved during this project

- A resource-type typo (`azure_resource_group` vs. `azurerm_resource_group`)
  that surfaced as a provider-resolution error, not a syntax error.
- AKS deployment failing due to a VM SKU not being available for this
  subscription/region — resolved by querying Azure's allowed-SKU list.
- A Service CIDR overlapping with the VNet's subnet CIDR — required understanding
  the difference between pod IP ranges and Kubernetes service IP ranges.
- AKS rejecting an update because `oidc_issuer_enabled` can't be disabled once
  set — had to explicitly declare the field to match existing cluster state.
- MySQL Flexible Server provisioning failing due to regional capacity
  restrictions on this subscription — resolved by querying `az mysql
  flexible-server list-skus` across regions to find one with actual support,
  and cleaning up an orphaned resource name left behind by a failed create.

## What this project intentionally does NOT cover

Being upfront about scope: this is a personal learning project, not a
production system. It hasn't been exposed to real concurrent multi-engineer
usage, infrastructure drift from manual changes, or production rollback
scenarios — the kind of things that only come from real team/production
exposure over time.

## Running this project

```bash
terraform init
terraform plan
terraform apply
```

Requires: Terraform >= 1.5.0, Azure CLI (authenticated via `az login`), and an
Azure subscription.
