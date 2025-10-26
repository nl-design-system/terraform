resource "github_repository" "lux" {
  name                        = "lux"
  description                 = "Lux — Logius Design System"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = true
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/lux/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "storybook"]

  template {
    include_all_branches = false
    owner                = "nl-design-system"
    repository           = "example"
  }

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "lux" {
  repository = github_repository.lux.name
  branch     = "main"
}

resource "github_repository_ruleset" "lux-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.lux.name
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
      require_code_owner_review         = false
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
        context = "UI Tests"
      }
    }
  }
}

resource "github_repository_ruleset" "lux-other" {
  enforcement = "active"
  name        = "other-branch-protection"
  repository  = github_repository.lux.name
  target      = "branch"

  conditions {
    ref_name {
      include = [
        "refs/heads/gh-pages",
      ]
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

resource "github_repository_collaborators" "lux" {
  repository = github_repository.lux.name

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
    permission = "push"
    team_id    = github_team.logius-committer.id
  }

  team {
    permission = "triage"
    team_id    = github_team.logius-triage.id
  }

  team {
    permission = "push"
    team_id    = github_team.community-committer.id
  }
}

resource "github_repository_environment" "lux-publish" {
  environment       = "Publish"
  repository        = github_repository.lux.name
  can_admins_bypass = false

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_deployment_branch_policy" "lux-publish-main" {
  depends_on = [github_repository_environment.lux-publish]

  repository       = github_repository.lux.name
  environment_name = github_repository_environment.lux-publish.environment
  name             = github_branch_default.lux.branch
}
