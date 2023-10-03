# Terraform Beginner Bootcamp 2023

## Table of Contents

- [Semantic Versioning](#semantic-versioning)
- [Install Terraform CLI](#install-terraform-cli)
    - [Terraform CLI Change Considerations](#terraform-cli-change-considerations)
    - [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    - [Working with Environment Variables (Env Vars](#working-with-environment-variables-env-vars)
        - [Setting/Unsetting Env Vars](#settingunsetting-env-vars)
        - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
    - [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
    - [Terraform Registry](#terraform-registry)
    - [Terraform Console](#terraform-console)
    - [Terraform Init](#terraform-init)
    - [Terraform Plan](#terraform-plan)
    - [Terraform Apply](#terraform-apply)
    - [Terraform Destroy](#terraform-destroy)
    - [Terraform Lock Files](#terraform-lock-files)
    - [Terraform State Files](#terraform-state-files)
    - [Terraform Directory](#terraform-directory)
- [Issues with Terrform Cloud Login and Gitpod Workspace](#issues-with-terrform-cloud-login-and-gitpod-workspace)

## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The genral format:

**MAJOR.MINOR.PATCH**, e.g `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install Terraform CLI

### Terraform CLI Change Considerations
Terraform CLI installation changes due to gpg keyring changes. Updated to newest install instructions in ([.gitpod.yml](.gitpod.yml)) as provided by Terraform.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Refactoring into Bash Scripts
Created bash script at [./bin/install_terraform_cli](./bin/install_terraform_cli) to install Terraform CLI, keeping ([.gitpod.yml](.gitpod.yml)) file more readable. Also allowing for more portability.

### Gitpod Workspace Lifecycle (Before, Init, Command)

Need to be careful when using `Init` in [.gitpod.yml](.gitpod.yml) as it will not run if restarting an existing Gitpod workspace. Switched to `Before` keyword.

[Gitpod Workspace Lifecycle](https://www.gitpod.io/docs/configure/workspaces/tasks)


### Working with Environment Variables (Env Vars)

List out all Env Vars using the `env` command.

Can filter specifiv Env Vars using grep, e.g. `env | grep AWS_`

#### Setting/Unsetting Env Vars

Set Env Vars in the terminal using `export HELLO='world'`

Unset Env Vars in the terminal using `unset HELLO`

#### Persisting Env Vars in Gitpod

Env Vars can be set to persis in Gitpod by storing them in the Gitpod Secrets Storage.

```sh
gp env HELLO='world'
```

### AWS CLI Installation

AWS CLI is installed for this project via the bash script []`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

Can check if AWS Credentials are configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If successful, a json payload is returned that looks similar to the below:
```json
{
    "UserId": "AIDAQJXN6KVLTQNABC123",
    "Account": "123456789012",
    "Arn": "arn:aws:iam:123456789012:user/terraform-beginner-bootcamp"
}
```

Need to generate AWS CLI credentials from IAM user in order to use the AWS CLI.


## Terraform Basics

### Terraform Registry

Terraform sources providers and modules from the Terrafform registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** are interfaces to APIs that will allow the creationg of resources in Terraform.
- **Modules** are used to make large amounts of Terraform code modular, portable, and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

List all Terraform commands by running the `terraform` command.

### Terraform Init

`terraform init`

Run `terraform init` at the start of a new Terrarform project to download binaries for the Terraform providers that will be needed in the project.

### Terraform Plan

`terraform plan`

Generates a changeset on the state of infrastructure and what will be changed.

Can output changeset to be passed to an apply, but often can just be ignored.

### Terraform Apply

`terraform apply`

Will run a plan and pass the changeset to be executed by Terraform. Apply should prompt `yes` or `no`.

Can automatically approve and apply but using the `--auto-approve` flag, i.e. `terraform apply --auto-approve`

### Terraform Destroy

`terrafrom destroy`
This will destroy resources.

The `--auto-approve` flag can be used to skip the approval prompt, e.g. `terraform destroy --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be committed** to version control.

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastruture.

This file **should not be commited** to version control.

This file can contain sensitive data.

If this file is lost you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform/` directory contains binaries of terraform providers.

## Issues with Terrform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch a bash WYSIWYG view to generate a token. However it does not work as expected in Gitpod VSCode in the browser.

The workaround is mannually generate a token in Terraform Cloud.

```
https://app.terraform.io/app/settings/tokent?source=terraform-login
```

Then create and open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

Automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)
