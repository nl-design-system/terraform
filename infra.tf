resource "github_repository" "hosting" {
  name                        = "infra"
  description                 = "Infrastructure as Code (IaC) for cloud and Kubernetes resources"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = false
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  has_discussions             = false
  vulnerability_alerts        = true
  visibility                  = "public"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "hosting-branch-default" {
  repository = github_repository.hosting.name
  branch     = "main"
}

resource "github_repository_ruleset" "hosting-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.hosting.name
  target      = "branch"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    creation                      = false
    deletion                      = true
    non_fast_forward              = true
    required_linear_history       = true
    required_signatures           = false
    update                        = false
    update_allows_fetch_and_merge = false

    pull_request {
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = true
      require_last_push_approval        = false
      required_approving_review_count   = 2
      required_review_thread_resolution = true
    }
  }
}

resource "github_repository_collaborators" "hosting" {
  repository = github_repository.hosting.name

  # Restrict merging PRs to admins via /.github/CODEOWNERS

  team {
    permission = "admin"
    team_id    = github_team.kernteam-admin.id
  }

  team {
    permission = "triage"
    team_id    = github_team.kernteam-dependabot.id
  }

  team {
    permission = "push"
    team_id    = github_team.kernteam-maintainer.id
  }

  # Expertteam is the main stakeholder for hosting, initially
  team {
    permission = "push"
    team_id    = github_team.expertteam-digitale-toegankelijkheid-infra.id
  }

  team {
    # Allow the entire Expertteam to make PRs to propose changes, others can review.
    permission = "push"
    team_id    = github_team.expertteam-digitale-toegankelijkheid-committer.id
  }

  # Restrict pushes to infrastructure as code to admins and maintainers

  team {
    permission = "triage"
    team_id    = github_team.expertteam-digitale-toegankelijkheid-triage.id
  }
}

resource "github_repository_environment" "hosting-publish" {
  environment       = "Publish"
  repository        = github_repository.hosting.name
  can_admins_bypass = false

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

removed {
  from = github_repository_deployment_branch_policy.hosting-publish-main
  lifecycle {
    destroy = false
  }
}

resource "github_repository_environment_deployment_policy" "hosting-publish-main" {
  repository     = github_repository.hosting.name
  environment    = github_repository_environment.hosting-publish.environment
  branch_pattern = github_branch_default.hosting-branch-default.branch
}

import {
  id = "infra:Publish:41754549"
  to = github_repository_environment_deployment_policy.hosting-publish-main
}
