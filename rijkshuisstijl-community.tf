resource "github_repository" "rijkshuisstijl-community" {
  name                        = "rijkshuisstijl-community"
  description                 = "Unofficial Rijkshuisstijl components and design tokens based on the NL Design System architecture. This project is not endorsed by the Dutch Ministry of General Affairs."
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/rijkshuisstijl-community/"
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

resource "github_branch_protection" "rijkshuisstijl-community-main" {
  repository_id = github_repository.rijkshuisstijl-community.node_id

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
    contexts = ["build", "lint", "test"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
  }
}

resource "github_branch_protection" "rijkshuisstijl-community-gh-pages" {
  repository_id = github_repository.rijkshuisstijl-community.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}

resource "github_repository_collaborators" "rijkshuisstijl-community" {
  repository = github_repository.rijkshuisstijl-community.name

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
    team_id    = github_team.logius.slug
  }

  team {
    permission = "push"
    team_id    = github_team.rivm.slug
  }

  team {
    permission = "push"
    team_id    = github_team.rvo.slug
  }
}
