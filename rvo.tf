resource "github_repository" "rvo" {
  name                        = "rvo"
  description                 = "Work in Progress: RVO Design System based on the NL Design System architecture. Rijksdienst voor Ondernemend Nederland / rvo.nl"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = true
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://rvo.nl/roos/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "storybook"]
  default_branch              = "main"

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
}

resource "github_branch_protection" "rvo-master" {
  repository_id = github_repository.rvo.node_id

  pattern                         = "master"
  enforce_admins                  = true
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  required_status_checks {
    strict   = false
    contexts = ["install", "build", "lint", "test"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
  }
}

resource "github_branch_protection" "rvo-gh-pages" {
  repository_id = github_repository.rvo.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}

resource "github_repository_collaborators" "rvo" {
  repository = github_repository.rvo.name

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
    permission = "triage"
    team_id    = github_team.rvo.slug
  }

  team {
    permission = "maintain"
    team_id    = github_team.rvo-maintainer.slug
  }

  team {
    permission = "push"
    team_id    = github_team.rvo-committer.slug
  }

  team {
    permission = "push"
    team_id    = github_team.rvo-dictu.slug
  }
}
