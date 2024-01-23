variable "organization_name" {
  description = "The name of the organization."
  type        = string
}

variable "oauth_client_name" {
  description = "Name of the OAuth client."
  type        = string
}

variable "modules_name" {
  description = "A list of modules name to published."
  type        = list(string)
}

variable "github_organization_name" {
  description = "Name of the GitHub organization."
  type        = string
}