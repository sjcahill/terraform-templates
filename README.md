# Terraform Templates

</br>

## Naming Conventions

### Folders

#### Environments
- `global` Contains resources used across all environments and remote backend configuration
- `dev` Contains development/testing infrastucture
- `stage` Preproduction and further testing infrastructure
- `prod` Production infrastructure
- `mgmt` Devops tooling infrastructure (bastion_host, CI server, etc)

#### Modules/Components
- `vpc` Network topology and infra
- `services` Apps and services infra
- `data-storage` Data storage related infra

</br>

### Files

#### Core
- `variables.tf` Defining input variables
- `outputs.tf` Defining and specification of output variables (returned from terraform setup)
- `main.tf` Define resources and data sources

#### Additional
- `dependencies.tf` Data sources to make infrastructure dependencies clearer
- `providers.tf` Has all provider info
- `main-<xxx>` If main.tf getting to long break it down into smaller chunks `main-iam-role.tf`

