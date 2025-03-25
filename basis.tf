resource "github_repository" "basis" {
  name                        = "basis"
  description                 = "NL Design System Basis packages"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/basis/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system"]

  template {
    owner                = "nl-design-system"
    repository           = "example"
    include_all_branches = false
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

resource "github_branch_default" "basis" {
  repository = github_repository.basis.name
  branch     = "main"
}

resource "github_repository_ruleset" "basis-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.basis.name
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
      strict_required_status_checks_policy = true

      required_check {
        context = "Block Autosquash Commits"
      }
      required_check {
        context = "build"
      }
      required_check {
        context = "install"
      }
      required_check {
        context = "lint"
      }
      required_check {
        context = "test"
      }
    }
  }
}

resource "github_repository_collaborators" "basis" {
  repository = github_repository.basis.name

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
}
