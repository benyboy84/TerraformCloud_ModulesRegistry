# The following block is use to get information about an OAuth client.
data "tfe_oauth_client" "client" {
  organization = var.organization_name
  name         = var.oauth_client_name
}