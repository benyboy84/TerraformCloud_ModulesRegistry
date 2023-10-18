# The following block is use to get information about an OAuth client.
data "tfe_oauth_client" "client" {
  organization = data.tfe_organization.this.name
  name         = local.oauth_client_name
}