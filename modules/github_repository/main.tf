resource "github_repository" "this" {

  name                                    = var.name
  description                             = var.description
  homepage_url                            = var.homepage_url
  visibility                              = var.visibility
  has_issues                              = var.has_issues
  has_discussions                         = var.has_discussions
  has_projects                            = var.has_projects
  has_wiki                                = var.has_wiki
  is_template                             = var.is_template
  allow_merge_commit                      = var.allow_merge_commit
  allow_squash_merge                      = var.allow_squash_merge
  allow_rebase_merge                      = var.allow_rebase_merge
  allow_auto_merge                        = var.allow_auto_merge
  squash_merge_commit_title               = var.squash_merge_commit_title
  squash_merge_commit_message             = var.squash_merge_commit_message
  merge_commit_title                      = var.merge_commit_title
  merge_commit_message                    = var.merge_commit_message
  delete_branch_on_merge                  = var.delete_branch_on_merge
  auto_init                               = var.auto_init
  gitignore_template                      = var.gitignore_template
  license_template                        = var.license_template
  archived                                = var.archived
  archive_on_destroy                      = var.archive_on_destroy
  topics                                  = var.topics
  vulnerability_alerts                    = var.vulnerability_alerts
  ignore_vulnerability_alerts_during_read = var.ignore_vulnerability_alerts_during_read
  allow_update_branch                     = var.allow_update_branch

  dynamic "pages" {
    for_each = var.pages != null ? [true] : []
    content {
      dynamic "source" {
        for_each = var.pages.source != null ? [true] : []
        content {
          branch = var.pages.source.branch
          path   = var.pages.source.path
        }
      }
      build_type = var.pages.build_type
      cname      = var.pages.cname
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.security_and_analysis != null ? [true] : []
    content {
      dynamic "advanced_security" {
        for_each = var.security_and_analysis.advanced_security != null ? [true] : []
        content {
          status = var.security_and_analysis.advanced_security.status
        }
      }
      dynamic "secret_scanning" {
        for_each = var.security_and_analysis.secret_scanning != null ? [true] : []
        content {
          status = var.security_and_analysis.secret_scanning.status
        }
      }
      dynamic "secret_scanning_push_protection" {
        for_each = var.security_and_analysis.secret_scanning_push_protection != null ? [true] : []
        content {
          status = var.security_and_analysis.secret_scanning_push_protection.status
        }
      }
    }
  }

  dynamic "template" {
    for_each = var.template != null ? [true] : []
    content {
      owner                = var.template.owner
      repository           = var.template.repository
      include_all_branches = var.template.include_all_branches
    }
  }

  lifecycle {
    precondition {
      condition     = var.squash_merge_commit_title != null ? var.allow_squash_merge ? true : false : true
      error_message = "`squash_merge_commit_title` is only applicable if `allow_squash_merge` is true."
    }
    precondition {
      condition     = var.squash_merge_commit_message != null ? var.allow_squash_merge ? true : false : true
      error_message = "`squash_merge_commit_message` is only applicable if `allow_squash_merge` is true."
    }
    precondition {
      condition     = var.merge_commit_title != null ? var.allow_merge_commit ? true : false : true
      error_message = "`merge_commit_title` is only applicable if `allow_merge_commit` is true."
    }
    precondition {
      condition     = var.merge_commit_message != null ? var.allow_merge_commit ? true : false : true
      error_message = "`merge_commit_message` is only applicable if `allow_merge_commit` is true."
    }
    ignore_changes = [
      # Ignore changes to somes properties because they are always updated.
      allow_merge_commit, allow_rebase_merge, allow_squash_merge, delete_branch_on_merge,
      merge_commit_message, merge_commit_title, squash_merge_commit_message, squash_merge_commit_title
    ]
  }

}

resource "github_branch_protection" "this" {
  for_each                        = { for branch_protection in var.branch_protections : branch_protection.pattern => branch_protection }
  repository_id                   = github_repository.this.name
  pattern                         = each.value.pattern
  enforce_admins                  = each.value.enforce_admins
  require_signed_commits          = each.value.require_signed_commits
  required_linear_history         = each.value.required_linear_history
  require_conversation_resolution = each.value.require_conversation_resolution

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks != null ? [true] : []
    content {
      strict   = each.value.required_status_checks.strict
      contexts = each.value.required_status_checks.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews != null ? [true] : []
    content {
      dismiss_stale_reviews           = each.value.required_pull_request_reviews.dismiss_stale_reviews
      restrict_dismissals             = each.value.required_pull_request_reviews.restrict_dismissals
      dismissal_restrictions          = each.value.required_pull_request_reviews.dismissal_restrictions
      pull_request_bypassers          = each.value.required_pull_request_reviews.pull_request_bypassers
      require_code_owner_reviews      = each.value.required_pull_request_reviews.require_code_owner_reviews
      required_approving_review_count = each.value.required_pull_request_reviews.required_approving_review_count
      require_last_push_approval      = each.value.required_pull_request_reviews.require_last_push_approval
    }
  }

  push_restrictions    = each.value.push_restrictions
  force_push_bypassers = each.value.force_push_bypassers
  allows_deletions     = each.value.allows_deletions
  allows_force_pushes  = each.value.allows_force_pushes
  blocks_creations     = each.value.blocks_creations
  lock_branch          = each.value.lock_branch
}

resource "github_actions_secret" "this" {
  for_each        = { for secret in var.actions_secrets : secret.secret_name => secret }
  repository      = github_repository.this.name
  secret_name     = each.value.secret_name
  plaintext_value = each.value.plaintext_value
}

resource "github_actions_repository_permissions" "this" {
  repository      = github_repository.this.name
  allowed_actions = var.allowed_actions
  enabled         = var.enabled
  dynamic "allowed_actions_config" {
    for_each = var.allowed_actions_config != null ? [true] : []
    content {
      github_owned_allowed = var.allowed_actions_config.github_owned_allowed
      patterns_allowed     = var.allowed_actions_config.patterns_allowed
      verified_allowed     = var.allowed_actions_config.verified_allowed
    }
  }
  lifecycle {
    precondition {
      condition     = var.allowed_actions_config != null ? var.allowed_actions == "selected" ? true : false : true
      error_message = "`allowed_actions_config` is only available  if `allowed_actions` is set to `selected`."
    }
  }
}

resource "github_branch" "this" {
  for_each      = { for branch in var.branches : branch.branch => branch }
  repository    = github_repository.this.name
  branch        = each.value.branch
  source_branch = each.value.source_branch
}