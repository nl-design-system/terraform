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

resource "github_branch_protection" "utrecht-main" {
  repository_id = github_repository.utrecht.node_id

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
    contexts = ["build", "lint", "test", "Block Autosquash Commits", "UI Tests"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
    pull_request_bypassers = [
      "/${data.github_user.nl-design-system-ci.username}",
    ]
  }
}

resource "github_repository_collaborators" "utrecht" {
  repository = github_repository.utrecht.name

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
    team_id    = github_team.gemeente-utrecht.id
  }

  team {
    permission = "push"
    team_id    = github_team.frameless.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.frameless-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.logius-maintainer.id
  }

  team {
    permission = "triage"
    team_id    = github_team.logius-triage.id
  }
}
