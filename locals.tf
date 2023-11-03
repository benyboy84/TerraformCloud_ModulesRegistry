locals {
  # This local is used to define the organization name.
  organization_name = "ConseilsTI"

  # This local is used to define Oauth_client name.
  oauth_client_name = "GitHub.com"

  # A list of all private modules to import into Terraform Cloud private module registry.
  modules = {
    # `modules` is a map of object where the key is the name of the module.
    # Refer to "./modules/module/README.md" for more details.
    # Here is an example of an object:
    # "module_name" = {
    #   vcs_repo = {
    #     display_identifier = "GitHub_Organization/Repository_Name"
    #     identifier         = "GitHub_Organization/Repository_Name"
    #     oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
    #   }
    # }
    "terraform-azurerm-key_vault" = {
      vcs_repo = {
        display_identifier = "benyboy84/terraform-azurerm-key_vault"
        identifier         = "benyboy84/terraform-azurerm-key_vault"
        oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
      }
    }
  }

}