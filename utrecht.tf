resource "github_repository" "utrecht" {
  name                        = "utrecht"
  description                 = "Work in Progress: Utrecht Design System based on the NL Design System architecture. Storybook: https://nl-design-system.github.io/utrecht/storybook/"
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
  homepage_url                = "https://nl-design-system.github.io/utrecht/"
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

    # A `source` block is only needed when `build_type` is set to `"legacy"`, but because GitHub keeps it around invisibly, we must add it here to prevent churn
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "utrecht" {
  repository = github_repository.utrecht.name
  branch     = "main"
}

resource "github_repository_ruleset" "utrecht-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.utrecht.name
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
        context = "Block Autosquash Commits"
      }
      required_check {
        context = "UI Tests"
      }
    }
  }
}

resource "github_repository_collaborators" "utrecht" {
  repository = github_repository.utrecht.name

  # kernteam
  team {
    permission = "admin"
    team_id    = github_team.kernteam-admin.id
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
    team_id    = github_team.kernteam-committer.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.kernteam-maintainer.id
  }

  # Utrecht
  team {
    permission = "triage"
    team_id    = github_team.gemeente-utrecht-triage.id
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-utrecht-committer.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.gemeente-utrecht-maintainer.id
  }

  # Frameless
  team {
    permission = "push"
    team_id    = github_team.frameless.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.frameless-maintainer.id
  }

  # Logius
  team {
    permission = "triage"
    team_id    = github_team.logius-triage.id
  }

  team {
    permission = "push"
    team_id    = github_team.logius-maintainer.id
  }

  # Community
  team {
    permission = "push"
    team_id    = github_team.community-committer.id
  }
}
