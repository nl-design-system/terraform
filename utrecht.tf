resource "github_repository" "utrecht" {
  name                        = "utrecht"
  description                 = "Work in Progress: Utrecht Design System based on the NL Design System architecture. Storybook: https://nl-design-system.github.io/utrecht/storybook/"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
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
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "utrecht-main" {
  repository_id = github_repository.utrecht.node_id

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
    contexts = ["build", "lint", "test", "Block Autosquash Commits", "UI Tests"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
  }
}

resource "github_branch_protection" "utrecht-gh-pages" {
  repository_id = github_repository.utrecht.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}

resource "github_repository_collaborators" "utrecht" {
  repository = github_repository.utrecht.name

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
    permission = "maintain"
    team_id    = github_team.gemeente-utrecht.slug
  }

  team {
    permission = "maintain"
    team_id    = github_team.frameless.slug
  }

  team {
    permission = "admin"
    team_id    = github_team.frameless-admin.slug
  }

  team {
    permission = "push"
    team_id    = github_team.frameless-intern.slug
  }
}
