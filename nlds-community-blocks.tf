resource "github_repository" "nlds-community-blocks" {
  name                        = "nlds-community-blocks"
  description                 = "WordPress Gutenberg Blocks for NL Design System components. Authors of WordPress websites can now use NL Design System components to compose their pages. This repository is maintained by the NL Design System community."
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "wordpress", "wordpress-plugin"]
}

resource "github_branch_protection" "nlds-community-blocks-main" {
  repository_id = github_repository.nlds-community-blocks.node_id

  pattern                         = "main"
  enforce_admins                  = true
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  required_status_checks {
    strict   = false
    contexts = ["build", "install", "lint", "test", "message-check"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
  }
}

resource "github_repository_collaborators" "nlds-community-blocks" {
  repository = github_repository.nlds-community-blocks.name

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
    team_id    = github_team.denhaag-draad.slug
  }

  team {
    permission = "push"
    team_id    = github_team.denhaag-acato.slug
  }
}
