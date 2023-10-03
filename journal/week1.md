# Terraform Beginner Bootcamp 2023 - Week 1

## Table of Contents

## Root Module Structure

Root Module Structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # data of variables to load into terraform project
├── providers.tf            # defined required providers and their configurations
├── outputs.tf              # stores outputs
└── README.md               # required for root modules
```

[Standard Terraform Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Vairables

### Terraform Cloud Variables

In Terraform, two types of variables can be set:
- Environement Variables - those you would set in bash terminal eg. AWS credentials
- Terraform Variables - those you would normally set in tfvars file

Can set Terraform Cloud variables to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

Can use the `-var` flag to set or override an input variable that is in the tfvars file eg. `terraform -var user_uuid="my-user_uuid"`

### var-file flag

- TODO: TO-BE-DOCUMENTED

### terraform.tfvars

Default file to load in Terraform variables in bulk

### auto.tfvars

- TODO: TO-BE-DOCUMENTED

### Order of Terraform variables

- TODO: Document which terraform vars take precedence