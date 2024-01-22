# TFC modules Terraform module

Terraform modules module which manages configuration and life-cycle of all
your Terraform Cloud module in the private registry. It is designed to be used 
from a dedicated Terraform Cloud workspace that would provision and manage 
rest of your modules using Terraform code (IaC).

## Permissions

To manage the module resources, provide a user token from an account with 
appropriate permissions. This user should have `Manage modules` access. 
Alternatively, you can use a token from a team with that access instead of 
a user token.

## Authentication

The Terraform Cloud provider requires a Terraform Cloud/Enterprise API token in 
order to manage resources.

There are several ways to provide the required token:

- Set the `token` argument in the provider configuration. You can set the token argument in the provider configuration. Use an
input variable for the token.
- Set the `TFE_TOKEN` environment variable: The provider can read the TFE_TOKEN environment variable and the token stored there
to authenticate.

## Features

- Import Terraform module into private registry

## Usage example
```hcl
module "module" {
  source = "./modules/tfe_module"

  vcs_repo = {
    display_identifier = "orgs/pepo"
    identifier         = "orgs/pepo"
    oauth_token_id     = "oauth_token_id"
  }

}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (0.48.0)

## Providers

The following providers are used by this module:

- <a name="provider_tfe"></a> [tfe](#provider\_tfe) (0.48.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [tfe_registry_module.this](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/registry_module) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_module_provider"></a> [module\_provider](#input\_module\_provider)

Description: (Optional) Specifies the Terraform provider that this module is used for. For example, 'aws'.

Type: `string`

Default: `null`

### <a name="input_name"></a> [name](#input\_name)

Description: (Optional) The name of registry module. It must be set if `module_provider` is used.

Type: `string`

Default: `null`

### <a name="input_namespace"></a> [namespace](#input\_namespace)

Description: (Optional) The namespace of a public registry module. It can be used if `module_provider` is set and `registry_name` is public.

Type: `string`

Default: `null`

### <a name="input_organization"></a> [organization](#input\_organization)

Description: (Optional) The name of the organization associated with the registry module. It must be set if `module_provider` is used, or if `vcs_repo` is used via a GitHub App.

Type: `string`

Default: `null`

### <a name="input_registry_name"></a> [registry\_name](#input\_registry\_name)

Description: (Optional) Whether the registry module is private or public. It can be used if `module_provider` is set.

Type: `string`

Default: `null`

### <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo)

Description:   (Optional) Settings for the registry module's VCS repository. Forces a new resource if changed. One of `vcs_repo` or `module_provider` is required.  
    display\_identifier         = (Required) The display identifier for your VCS repository. For most VCS providers outside of BitBucket Cloud, this will match the `identifier` string.  
    identifier                 = (Required) A reference to your VCS repository in the format `<organization>/<repository>` where `<organization>` and `<repository>` refer to the organization (or project key, for Bitbucket Server) and repository in your VCS provider. The format for Azure DevOps is //\_git/.  
    oauth\_token\_id             = (Optional) Token ID of the VCS Connection (OAuth Connection Token) to use. This conflicts with `github_app_installation_id` and can only be used if `github_app_installation_id` is not used.  
    github\_app\_installation\_id = (Optional) The installation id of the Github App. This conflicts with `oauth_token_id` and can only be used if `oauth_token_id` is not used.

Type:

```hcl
object({
    display_identifier         = string
    identifier                 = string
    oauth_token_id             = optional(string, null)
    github_app_installation_id = optional(string, null)
  })
```

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output\_id)

Description: The ID of the registry module.

### <a name="output_module_provider"></a> [module\_provider](#output\_module\_provider)

Description: The Terraform provider that this module is used for.

### <a name="output_name"></a> [name](#output\_name)

Description: The name of registry module.

### <a name="output_namespace"></a> [namespace](#output\_namespace)

Description: The namespace of the module. For private modules this is the name of the organization that owns the module.

### <a name="output_organization"></a> [organization](#output\_organization)

Description: The name of the organization associated with the registry module.

### <a name="output_registry_module"></a> [registry\_module](#output\_registry\_module)

Description: Terraform Cloud's private module registry resource.

### <a name="output_registry_name"></a> [registry\_name](#output\_registry\_name)

Description: The registry name of the registry module depicting whether the registry module is private or public.
<!-- END_TF_DOCS -->