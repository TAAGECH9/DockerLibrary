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
- You have an Azure account and have a service principal
- The service Principal should have `Contributor` permission assigned on Subscription scope
- The service Principal must have `AcrPush` permissions assigned on ACR scope.


### What to do?

#### Configure Terraform Cloud
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

#### Configure Github Actions

The following secrets need to be created in the Github Actions variables

- **AZURE_CREDENTIALS** as described [here](https://github.com/marketplace/actions/azure-login#workflow-examples).
  ```json
  {
      "clientSecret":  "******",
      "subscriptionId":  "******",
      "tenantId":  "******",
      "clientId":  "******"
  }
  ```

- **REGISTRY_USERNAME** The clientId from the JSON above

- **REGISTRY_PASSWORD** The clientSecret from the JSON above

- **ACR_LOGIN_SERVER** Can be found on the overview page of the ACR
