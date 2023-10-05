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

## Dealing with Configuration Drift

### What happens if we lose our state file?

If the Terraform state file is lost, most likely all cloud infrastructure will need to be torn down manually.

`terraform import` can be used, but does not work for all cloud resources. Check Terraform Providers documentation to see which resource have import capability.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/language/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If a cloud resource is removed or modified manually, running `terraform plan` will attempt to put infrastructure back in the expected state fixing any configuration drift.

### Fix Using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when locally developing modules.

### Passing Input Variables

Can pass input variables to modules.

The modules has to declare terraform variables in its own `variables.tf`

```tf
module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.user_uuid
    bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module form vairs places:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

