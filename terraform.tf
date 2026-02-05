resource "github_repository" "terraform" {
  name                        = "terraform"
  description                 = "Infrastructure as code: we configure GitHub via Terraform configuration files"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = false
  delete_branch_on_merge      = true
  has_issues                  = true
  has_projects                = false
  has_wiki                    = false
  has_discussions             = false
  vulnerability_alerts        = true
  homepage_url                = "https://app.terraform.io/app/nl-design-system/workspaces"
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

resource "github_branch_default" "terraform-branch-default" {
  repository = github_repository.terraform.name
  branch     = "main"
}

resource "github_repository_ruleset" "terraform-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.terraform.name
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

    required_status_checks {
      strict_required_status_checks_policy = true

      required_check {
        context = "Terraform Cloud/nl-design-system/repo-id-1TeEm4rfMfsg6Y6G"
      }
      required_check {
        context = "Terraform format check"
      }
    }
  }
}

resource "github_repository_collaborators" "terraform" {
  repository = github_repository.terraform.name

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
    team_id    = github_team.kernteam-committer.id
  }

  team {
    permission = "push"
    team_id    = github_team.kernteam-maintainer.id
  }

  # Allow maintainers of community teams to make PRs and review PRs
  team {
    permission = "push"
    team_id    = github_team.frameless-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.logius-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-den-haag-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.rvo-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.tilburg-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.tilburg-acato-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.tilburg-ditp-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.quintor-rijkshuisstijl-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.blueriq-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-rotterdam-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-groningen-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.keen-design-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.vng-services-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.rivm-maintainer.id
  }

  team {
    # Allow the entire Expertteam to make PRs to propose changes, kernteam can review.
    # Maintainers for expertteam are to be determined.
    permission = "push"
    team_id    = github_team.expertteam-digitale-toegankelijkheid-committer.id
  }

  # Restrict pushes to infrastructure as code to admins and maintainers

  team {
    permission = "triage"
    team_id    = github_team.kernteam-triage.id
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-voorne-aan-zee-aserio-maintainer.id
  }
}

resource "github_repository_environment" "terraform-publish" {
  environment       = "Publish"
  repository        = github_repository.terraform.name
  can_admins_bypass = false

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

removed {
  from = github_repository_deployment_branch_policy.terraform-publish-main
  lifecycle {
    destroy = false
  }
}

resource "github_repository_environment_deployment_policy" "terraform-publish-main" {
  repository     = github_repository.terraform.name
  environment    = github_repository_environment.terraform-publish.environment
  branch_pattern = github_branch_default.terraform-branch-default.branch
}

import {
  id = "terraform:Publish:37531220"
  to = github_repository_environment_deployment_policy.terraform-publish-main
}
