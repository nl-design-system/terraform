resource "github_repository" "publiccode-parser-action" {
  name                        = "publiccode-parser-action"
  description                 = "A simple Github action to validate publiccode.yml"
  is_template                 = false
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "publiccode-parser-action-main" {
  repository_id = github_repository.publiccode-parser-action.node_id

  pattern                         = "main"
  enforce_admins                  = true
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false


  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
  }
}

resource "github_repository_collaborators" "publiccode-parser-action" {
  repository = github_repository.publiccode-parser-action.name

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
}
