resource "tfe_registry_module" "this" {

  module_provider = var.module_provider
  name            = var.name
  organization    = var.organization
  namespace       = var.namespace
  registry_name   = var.registry_name


  dynamic "vcs_repo" {
    for_each = var.vcs_repo != null ? [true] : []
    content {
      display_identifier         = var.vcs_repo.display_identifier
      identifier                 = var.vcs_repo.identifier
      oauth_token_id             = var.vcs_repo.oauth_token_id
      github_app_installation_id = var.vcs_repo.github_app_installation_id
    }
  }

  lifecycle {
    precondition {
      condition     = var.vcs_repo == null && var.module_provider == null ? false : true
      error_message = "One of `vcs_repo` or `module_provider` is required."
    }

    precondition {
      condition     = var.module_provider != null ? var.name != null ? true : false : true
      error_message = "`name` must be set if `module_provider` is used."
    }

    precondition {
      condition     = var.organization != null ? (var.vcs_repo != null ? var.vcs_repo.github_app_installation_id != null ? true : false : false) || var.module_provider != null ? true : false : true
      error_message = "`organization` must be set if `module_provider` is used, or if `vcs_repo` is used via a GitHub App."
    }

    precondition {
      condition     = var.namespace != null ? var.module_provider != null && var.registry_name != null ? true : false : true
      error_message = "`namespace` can be used if `module_provider` is set and `registry_name` is public."
    }

    precondition {
      condition     = var.registry_name != null ? var.module_provider != null ? true : false : true
      error_message = ""
    }
  }

}

