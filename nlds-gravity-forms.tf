resource "github_repository" "nlds-gravity-forms" {
  name                        = "nlds-gravity-forms"
  description                 = "WordPress Gravity Forms theme for NL Design System styles. Authors of WordPress websites can now use their NL Design System theme in Gravity Forms. This repository is maintained by the NL Design System community."
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
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "wordpress", "wordpress-plugin", "gravity-forms"]

  template {
    include_all_branches = false
    owner                = "nl-design-system"
    repository           = "example"
  }

  archive_on_destroy = true
  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "nlds-gravity-forms" {
  repository = github_repository.nlds-gravity-forms.name
  branch     = "main"
}

resource "github_repository_ruleset" "nlds-gravity-forms-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.nlds-gravity-forms.name
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
        context = "install"
      }
      required_check {
        context = "lint"
      }
      required_check {
        context = "test"
      }
      required_check {
        context = "message-check"
      }
    }
  }
}

resource "github_repository_collaborators" "nlds-gravity-forms" {
  repository = github_repository.nlds-gravity-forms.name

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
    team_id    = github_team.gravityforms.id
  }
}
