resource "github_repository" "matomo" {
  name                        = "matomo"
  description                 = "Track user preferences in Matomo, to help prioritise design system work."
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/matomo/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "matomo"]

  pages {
    source {
      branch = "main"
      path   = "/"
    }
  }
}

resource "github_branch_protection" "matomo-main" {
  repository_id = github_repository.matomo.node_id

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

resource "github_repository_collaborators" "matomo" {
  repository = github_repository.matomo.name

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
