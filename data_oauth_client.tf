# The following block is use to get information about an OAuth client.
data "tfe_oauth_client" "client" {
  organization = local.organization_name
  name         = local.oauth_client_name
}