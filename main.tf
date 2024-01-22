# The following code block is used to create GitHub repository.

module "repository" {
  source = "./modules/github_repository"

  for_each = toset(var.modules_name)

  name                   = each.value
  description            = "Terraform module."
  delete_branch_on_merge = true
  security_and_analysis = {
    # advanced_security = {
    #   status = try(each.value.github_repository.security_and_analysis.advanced_security.status, null)
    # }
    secret_scanning = {
      status = "enabled"
    }
    secret_scanning_push_protection = {
      status = "enabled"
    }
  }
  vulnerability_alerts = true
  allow_update_branch  = false
  branch_protections = [
    {
      pattern                         = "main"
      enforce_admins                  = true
      require_conversation_resolution = true
      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        require_code_owner_reviews      = true
        required_approving_review_count = "0"
      }
    }
  ]
  allowed_actions = "selected"
  allowed_actions_config = {
    github_owned_allowed = true
    patterns_allowed     = ["terraform-docs/gh-actions@*", "super-linter/super-linter@*", "rymndhng/release-on-push-action@*", "hashicorp/*"]
  }
  files = [
    {
      file    = ".gitignore" 
      content = file("./Data/.gitignore")
    }
  ]
  # branches = [for branch in try(each.value.github_repository.branches, []) :
  #   {
  #     branch        = branch.branch
  #     source_branch = try(branch.source_branch, "main")
  #   }
  # ]
}

# The following code block is used to create module resources in the private registry.

module "modules" {
  source = "./modules/tfe_module"

  for_each = toset(var.modules_name)

  vcs_repo = {
    display_identifier = "benyboy84/${each.value}"
    identifier         = "benyboy84/${each.value}"
    oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
  }

}
