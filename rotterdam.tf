resource "github_repository" "rotterdam" {
  name                        = "rotterdam"
  description                 = "Work in Progress: Rotterdam Design System (RODS) based on the NL Design System architecture."
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_projects                = true
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/rotterdam/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "storybook"]

  template {
    include_all_branches = false
    owner                = "nl-design-system"
    repository           = "example"
  }

  pages {
    build_type = "workflow"
  }

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

resource "github_branch_default" "rotterdam" {
  repository = github_repository.rotterdam.name
  branch     = "main"
}

resource "github_repository_ruleset" "rotterdam-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.rotterdam.name
  target      = "branch"

  bypass_actors {
    actor_id    = github_team.kernteam-ci.id
    actor_type  = "Team"
    bypass_mode = "always"
  }

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
      required_approving_review_count   = 1
      required_review_thread_resolution = true
    }

    required_status_checks {
      strict_required_status_checks_policy = false

      required_check {
        context = "build"
      }
      required_check {
        context = "lint"
      }
      required_check {
        context = "test"
      }
      required_check {
        context = "Require \"git rebase --autosquash\" of \"fixup!\" commits"
      }
      required_check {
        context = "UI Tests"
      }
    }
  }
}

resource "github_repository_ruleset" "rotterdam-other" {
  enforcement = "active"
  name        = "other-branch-protection"
  repository  = github_repository.rotterdam.name
  target      = "branch"

  conditions {
    ref_name {
      include = ["refs/heads/gh-pages"]
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
  }
}

resource "github_repository_collaborators" "rotterdam" {
  repository = github_repository.rotterdam.name

  team {
    permission = "admin"
    team_id    = github_team.kernteam-admin.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.kernteam-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.kernteam-committer.id
  }

  team {
    permission = "triage"
    team_id    = github_team.kernteam-triage.id
  }

  team {
    permission = "triage"
    team_id    = github_team.kernteam-dependabot.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.gemeente-rotterdam-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-rotterdam-committer.id
  }

  team {
    permission = "triage"
    team_id    = github_team.gemeente-rotterdam-triage.id
  }

  team {
    permission = "push"
    team_id    = github_team.frameless.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.frameless-maintainer.id
  }
}

resource "github_repository_environment" "rotterdam-publish" {
  environment       = "Publish"
  repository        = github_repository.rotterdam.name
  can_admins_bypass = false

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

removed {
  from = github_repository_deployment_branch_policy.rotterdam-publish-main
  lifecycle {
    destroy = false
  }
}

resource "github_repository_environment_deployment_policy" "rotterdam-publish-main" {
  repository     = github_repository.rotterdam.name
  environment    = github_repository_environment.rotterdam-publish.environment
  branch_pattern = github_branch_default.rotterdam.branch
}

import {
  id = "rotterdam:Publish:37531224"
  to = github_repository_environment_deployment_policy.rotterdam-publish-main
}
