resource "github_repository" "documentatie" {
  name                        = "documentatie"
  description                 = "Website met documentatie van NL Design system: componenten, patronen, richtlijnen etcetera. Development-versie: https://documentatie.vercel.app/"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  has_discussions             = true
  vulnerability_alerts        = true
  homepage_url                = "https://www.nldesignsystem.nl/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "website"]

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

resource "github_branch_protection" "documentatie-main" {
  repository_id = github_repository.documentatie.node_id

  pattern                         = "main"
  enforce_admins                  = false
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  required_status_checks {
    strict   = false
    contexts = ["continuous-integration"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
    pull_request_bypassers = [
      "/${data.github_user.nl-design-system-ci.username}",
    ]
  }

  restrict_pushes {
    blocks_creations = false
    push_allowances = [
      "/${data.github_user.nl-design-system-ci.username}",
      "nl-design-system/${github_team.kernteam-committer.name}",
    ]
  }
}

resource "github_branch_protection" "documentatie-gh-pages" {
  repository_id = github_repository.documentatie.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}

resource "github_branch_protection" "documentatie-assets" {
  repository_id = github_repository.documentatie.node_id

  pattern                 = "assets"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}

resource "github_branch_protection" "documentatie-storybook" {
  repository_id = github_repository.documentatie.node_id

  pattern                 = "storybook"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
  }
}

resource "github_repository_collaborators" "documentatie" {
  repository = github_repository.documentatie.name

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
    team_id    = github_team.kernteam-dependabot.slug
  }
}

resource "github_repository_webhook" "documentatie" {
  repository = github_repository.documentatie.name
  events     = ["push"]

  configuration {
    url          = "https://prod.github-push.ictu.nl/modules/git/public/web-hook.php?uuid=${var.PLESK_WEBHOOK_UUID}"
    content_type = "form"
  }
}
