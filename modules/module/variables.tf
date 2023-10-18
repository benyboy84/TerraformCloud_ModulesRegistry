variable "module_provider" {
  description = "(Optional) Specifies the Terraform provider that this module is used for. For example, 'aws'."
  type        = string
  default     = null
}

variable "name" {
  description = "(Optional) The name of registry module. It must be set if `module_provider` is used."
  type        = string
  default     = null
}

variable "organization" {
  description = "(Optional) The name of the organization associated with the registry module. It must be set if `module_provider` is used, or if `vcs_repo` is used via a GitHub App."
  type        = string
  default     = null
}

variable "namespace" {
  description = "(Optional) The namespace of a public registry module. It can be used if `module_provider` is set and `registry_name` is public."
  type        = string
  default     = null
}

variable "registry_name" {
  description = "(Optional) Whether the registry module is private or public. It can be used if `module_provider` is set."
  type        = string
  default     = null
}

variable "vcs_repo" {
  description = <<DESCRIPTION
  (Optional) (Optional) Settings for the registry module's VCS repository. Forces a new resource if changed. One of `vcs_repo` or `module_provider` is required.
    display_identifier         = (Required) The display identifier for your VCS repository. For most VCS providers outside of BitBucket Cloud, this will match the `identifier` string.
    identifier                 = (Required) A reference to your VCS repository in the format `<organization>/<repository>` where `<organization>` and `<repository>` refer to the organization (or project key, for Bitbucket Server) and repository in your VCS provider. The format for Azure DevOps is //_git/.
    oauth_token_id             = (Optional) Token ID of the VCS Connection (OAuth Connection Token) to use. This conflicts with `github_app_installation_id` and can only be used if `github_app_installation_id` is not used.
    github_app_installation_id = (Optional) The installation id of the Github App. This conflicts with `oauth_token_id` and can only be used if `oauth_token_id` is not used.
  DESCRIPTION
  type = object({
    display_identifier         = string
    identifier                 = string
    oauth_token_id             = optional(string, null)
    github_app_installation_id = optional(string, null)
  })
  default = null

  validation {
    condition     = var.vcs_repo != null ? var.vcs_repo.oauth_token_id != null && var.vcs_repo.github_app_installation_id != null ? false : true : true
    error_message = "`oauth_token_id` conflicts with `github_app_installation_id`."
  }
}