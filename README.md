<!-- BEGIN_TF_DOCS -->
# Terraform Cloud Foundation

Code which manages configuration and life-cycle of all the Terraform Cloud
module in the private registry. It is designed to be used from a dedicated
VCS-Driven Terraform Cloud workspace that would provision and manage the
configuration using Terraform code (IaC).

## Permissions

To manage the module in the private registry from that code, provide a token
from an account with `manage modules` access. Alternatively, you can use a
token from a team with that access instead of a user token.

To manage the GitHub resources, provide a token from an account or a GitHub App with
appropriate permissions. It should have:

* `Administration`: Read and write
* `Content`: Read and write</br>
  *Required, otherwise, allow\_merge\_commit, allow\_rebase\_merge, and allow squash
  merge attributes will be ignored, causing confusing diffs.*
* `Metadata`: Read-only
* `Secrets`: Read and write

## Authentication

### Terraform Cloud

The Terraform Cloud provider requires a Terraform Cloud/Enterprise API token in
order to manage resources.

* Set the `TFE_TOKEN` environment variable: The provider can read the TFE\_TOKEN environment variable and the token stored there
to authenticate. Refer to [Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

### GitHub

The GitHub provider requires a GitHub token or GitHub App installation in order to manage resources.

There are several ways to provide the required token:

* Set the `token` argument in the provider configuration. You can set the `token` argument in the provider configuration. Use an
input variable for the token.
* Set the `GITHUB_TOKEN` environment variable. The provider can read the `GITHUB_TOKEN` environment variable and the token stored there
to authenticate.

There are several ways to provide the required GitHub App installation:

* Set the `app_auth` argument in the provider configuration. You can set the app\_auth argument with the id, installation\_id and pem\_file
in the provider configuration. The owner parameter is also required in this situation.
* Set the `GITHUB_APP_ID`, `GITHUB_APP_INSTALLATION_ID` and `GITHUB_APP_PEM_FILE` environment variables. The provider can read the GITHUB\_APP\_ID,
GITHUB\_APP\_INSTALLATION\_ID and GITHUB\_APP\_PEM\_FILE environment variables to authenticate.

> Because strings with new lines is not support:</br>
> use "\\\n" within the `pem_file` argument to replace new line</br>
> use "\n" within the `GITHUB_APP_PEM_FILE` environment variables to replace new line</br>

## Features

* Manages configuration and life-cycle of Terraform Cloud resources:
  * private module registry
* Manages configuration and life-cycle of GitHub resources:
* repository
* branch protection
* actions repository permissions

## Documentation

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (> 1.6.0)

- <a name="requirement_github"></a> [github](#requirement\_github) (5.44.0)

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (0.51.1)

## Modules

No modules.

## Required Inputs

The following input variables are required:

### <a name="input_modules_name"></a> [modules\_name](#input\_modules\_name)

Description: A list of modules name to published.

Type: `list(string)`

### <a name="input_oauth_client_name"></a> [oauth\_client\_name](#input\_oauth\_client\_name)

Description: The name of the OAuth client.

Type: `string`

### <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name)

Description: The name of the Terraform Cloud organization.

Type: `string`

## Optional Inputs

No optional inputs.

## Resources

The following resources are used by this module:

- [github_repository.this](https://registry.terraform.io/providers/integrations/github/5.44.0/docs/resources/repository) (resource)

## Outputs

No outputs.

<!-- markdownlint-enable -->
<!-- markdownlint-disable first-line-h1 -->
> This GitHub repository as well as the Terraform Cloud workspace is manage
> through Terraform Code.
>
> The code can be found in the [TerraformCloud-Foundation](https://github.com/benyboy84/TerraformCloud-Foundation) repository.
<!-- END_TF_DOCS -->