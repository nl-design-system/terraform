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

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "nlds-gravity-forms-main" {
  repository_id = github_repository.nlds-gravity-forms.node_id

  pattern                         = "main"
  enforce_admins                  = false
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  restrict_pushes {
    blocks_creations = false
    push_allowances = [
      "/${data.github_user.nl-design-system-ci.username}",
    ]
  }

  required_status_checks {
    strict   = false
    contexts = ["build", "install", "lint", "test", "message-check"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
    pull_request_bypassers = [
      "/${data.github_user.nl-design-system-ci.username}",
    ]
  }
}

resource "github_repository_collaborators" "nlds-gravity-forms" {
  repository = github_repository.nlds-gravity-forms.name

  team {
    permission = "admin"
    team_id    = github_team.kernteam-admin.slug
  }

  team {
    permission = "maintain"
    team_id    = github_team.kernteam-maintainer.slug
  }

  team {
    permission = "push"
    team_id    = github_team.kernteam-committer.slug
  }

  team {
    permission = "triage"
    team_id    = github_team.kernteam-triage.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gravityforms.slug
  }
}
