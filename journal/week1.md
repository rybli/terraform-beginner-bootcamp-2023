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
