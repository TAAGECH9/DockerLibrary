# 🐳 Docker Library

This repository is a centralized place for all my Dockerfiles. With the help of Github Actions the docker images get build + pushed automatically directly to the Azure Container registry, which is managed via Terraform as IaC.


## 🧱 Components

### Library
In the library there is a directory for each and every Dockerfile and its corresponding configuration files. Each and every Dockerfile has a header that looks like the following:

```sh
#
# Metadata used by docker-build-and-push.yml GitHub Action Workflow
# IMAGE_NAME: mkdocs
# IMAGE_VERSION: v0.0.1
#
```
This is required to make the automation work.

### Terraform

In the Terraform directory you will find the `iac` directory, that has all the required code to create the ACR resource in azure. The `config` directory contains the required variables to make iac work

### .github

Contains the required Workflows, a containescan directory which allows certain CVE's and the dependabot configuration.


## 📄 How to use

### Prerequisites

- You have a Terraform Cloud Account
- You have an Azure account and have a service principal that can be used


### What to do?

1. Configure Terraform Cloud
  - In Terraform Cloud workspace with the same name you choose for the `backend.hcl` file
  - Configure the Terraform Working directory to `terraform/iac`
  - Configure the Environment Variable for your Workspace
    - key: `TF_CLI_ARGS_plan`
    - value: `-var-file=../environment/prod/variables.tfvars`
  - Configure the following for values in Terraform cloud (using a variable set)
    - subscription_id
    - tenant_id
    - client_id
    - client_secret
