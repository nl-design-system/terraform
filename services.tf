resource "github_repository" "services" {
  name                        = "services"
  description                 = "Work in Progress: Templates for government services built on the NL Design System architecture."
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
  homepage_url                = "https://nl-design-system.github.io/services/"
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

resource "github_branch_protection" "services-main" {
  repository_id = github_repository.services.node_id

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
      "nl-design-system/${github_team.kernteam-maintainer.name}",
      "nl-design-system/${github_team.vng-services-committer.name}",
    ]
  }

  required_status_checks {
    strict   = false
    contexts = ["build", "install", "lint", "test"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
    pull_request_bypassers = [
      "/${data.github_user.nl-design-system-ci.username}",
    ]
  }
}

resource "github_repository_collaborators" "services" {
  repository = github_repository.services.name

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
    team_id    = github_team.vng-services-committer.slug
  }

  team {
    permission = "triage"
    team_id    = github_team.vng-services.slug
  }
}
