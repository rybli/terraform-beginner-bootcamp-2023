# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The genral format:

**MAJOR.MINOR.PATCH**, e.g `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install Terraform CLI

### Terraform CLI change considerations
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