resource "github_repository" "denhaag" {
  name                        = "denhaag"
  description                 = "Work in Progress: Den Haag Design System based on the NL Design System architecture"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = true
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/denhaag/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "storybook", "react", "component-library"]

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

resource "github_branch_protection" "denhaag-main" {
  repository_id = github_repository.denhaag.node_id

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
    contexts = ["build", "UI Tests"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = true
    dismissal_restrictions = [
      "${data.github_organization.nl-design-system.orgname}/${github_team.gemeente-denhaag-admin.slug}",
      "${data.github_organization.nl-design-system.orgname}/${github_team.gemeente-denhaag-design-system.slug}"
    ]
  }
}

resource "github_branch_protection" "denhaag-gh-pages" {
  repository_id = github_repository.denhaag.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}

resource "github_branch_protection" "denhaag-www-denhaag-nl" {
  repository_id = github_repository.denhaag.node_id

  pattern                         = "www.denhaag.nl"
  enforce_admins                  = true
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  required_status_checks {
    strict   = false
    contexts = ["build", "UI Tests"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = true
    dismissal_restrictions = [
      "${data.github_organization.nl-design-system.orgname}/${github_team.denhaag-acato.slug}"
    ]
  }
}

resource "github_repository_collaborators" "denhaag" {
  repository = github_repository.denhaag.name

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
    permission = "admin"
    team_id    = github_team.gemeente-denhaag-admin.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-denhaag-design-system.slug
  }

  team {
    permission = "push"
    team_id    = github_team.denhaag-acato.slug
  }

  team {
    permission = "push"
    team_id    = github_team.frameless.slug
  }

  team {
    permission = "admin"
    team_id    = github_team.frameless-admin.slug
  }
}
