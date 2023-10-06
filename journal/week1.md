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

## Working with Files in Terraform

### Fileexists Function

This is a built in terraform function to check the existance of a file.

```tf
validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The provided path for error.html does not exist."
  }
```

[Fileexists Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

[Filemd5 Function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In Terraform, there is a special variable called `path` that allows the ability to reference local paths:
- path.module = get the path for the vurrent module
- path.root = get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "website_index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key = "index.html"
  source = "${path.root}/public/index.html"
}
```

## Terraform Locals

Allow the ability to define local variables.

Useful for transforming data into another format to be referenced as a variable.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

This allows us to source data from cloud resources.

Useful for when needed to reference cloud resouces without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

Use `jsonencode` to create json policy inline in HCL.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources

[Meta Arguements Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

[terraform_data Resource](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners

Provisioners allow to execute commands on compute instances eg. AWS CLI command.

Not recommended for use by Hashicorp because Configuration Management tools, such as Ansible or Chef, are a better fit.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

Executes a command on the machine running the Terraform commands eg. plan/apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

[local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

### Remote-exec

Executes commands on a targeted machine. Will need to provide credentials such as ssh to authenticate to the remote machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

[remote-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)