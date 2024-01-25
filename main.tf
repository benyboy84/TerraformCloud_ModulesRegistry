# The following code block is used to create GitHub repository.

resource "github_repository" "this" {
  for_each               = toset(var.modules_name)
  name                   = lower(each.value)
  description            = "Terraform module to manage ${element(split("-", each.value), 1)} resources."
  has_issues             = true
  has_projects           = true
  has_wiki               = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  allow_auto_merge       = false
  delete_branch_on_merge = true
  security_and_analysis {
    # advanced_security {
    #   status = "enabled"
    # }
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
  vulnerability_alerts = true
}

resource "github_branch_protection" "this" {
  for_each                        = toset(var.modules_name)
  repository_id                   = github_repository.this[each.value].name
  pattern                         = "main"
  enforce_admins                  = true
  require_conversation_resolution = true
  # required_status_checks {
  #   strict   = 
  #   contexts = 
  # }
  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = "0"
  }
}

resource "github_actions_repository_permissions" "this" {
  for_each        = toset(var.modules_name)
  repository      = github_repository.this[each.value].name
  allowed_actions = "selected"
  allowed_actions_config {
    github_owned_allowed = true
    patterns_allowed     = ["terraform-docs/gh-actions@*", "super-linter/super-linter@*", "rymndhng/release-on-push-action@*", "hashicorp/*"]
  }
}

resource "github_repository_file" "gitignore" {
  for_each            = toset(var.modules_name)
  repository          = github_repository.this[each.value].name
  file                = ".gitignore"
  content             = file("./files/.gitignore")
  overwrite_on_create = true
}

resource "github_repository_file" "main" {
  for_each            = toset(var.modules_name)
  repository          = github_repository.this[each.value].name
  file                = "main.tf"
  content             = file("./files/main.tf")
  lifecycle {
    ignore_changes = [ content ]
  }
}

resource "github_repository_file" "outputs" {
  for_each            = toset(var.modules_name)
  repository          = github_repository.this[each.value].name
  file                = "outputs.tf"
  content             = file("./files/outputs.tf")
  lifecycle {
    ignore_changes = [ content ]
  }
}

resource "github_repository_file" "readme" {
  for_each            = toset(var.modules_name)
  repository          = github_repository.this[each.value].name
  file                = "README.md"
  content             = file("./files/README.md")
  lifecycle {
    ignore_changes = [ content ]
  }
}

resource "github_repository_file" "variables" {
  for_each            = toset(var.modules_name)
  repository          = github_repository.this[each.value].name
  file                = "variables.tf"
  content             = file("./files/variables.tf")
  lifecycle {
    ignore_changes = [ content ]
  }
}

resource "github_repository_file" "versions" {
  for_each            = toset(var.modules_name)
  repository          = github_repository.this[each.value].name
  file                = "versions.tf"
  content             = file("./files/versions.tf")
  lifecycle {
    ignore_changes = [ content ]
  }
}

# The following block is use to get information about an OAuth client.

data "tfe_oauth_client" "client" {
  organization = var.organization_name
  name         = var.oauth_client_name
}

# The following code block is used to create module resources in the private registry.

resource "tfe_registry_module" "this" {
  for_each     = github_repository.this
  organization = var.organization_name
  test_config {
    tests_enabled = true
  }
  vcs_repo {
    display_identifier = each.value.full_name
    identifier         = each.value.full_name
    oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
    branch             = "main"
  }
}