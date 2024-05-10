resource "github_repository" "terraform" {
  name                        = "terraform"
  description                 = "Infrastructure as code: we configure GitHub via Terraform configuration files"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://app.terraform.io/app/nl-design-system/workspaces"
  visibility                  = "public"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "terraform-main" {
  repository_id = github_repository.terraform.node_id

  pattern                         = "main"
  enforce_admins                  = true
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  # Restrict merging PRs to admins

  restrict_pushes {
    blocks_creations = false
    push_allowances = [
      "nl-design-system/${github_team.kernteam-admin.name}",
    ]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
    restrict_dismissals        = false
  }
}

resource "github_repository_collaborators" "terraform" {
  repository = github_repository.terraform.name

  # Restrict merging PRs to admins

  team {
    permission = "admin"
    team_id    = github_team.kernteam-admin.slug
  }

  team {
    permission = "push"
    team_id    = github_team.kernteam-maintainer.slug
  }

  # Allow maintainers of community teams to make PRs and review PRs
  team {
    permission = "push"
    team_id    = github_team.frameless-maintainer.slug
  }

  team {
    permission = "push"
    team_id    = github_team.logius-maintainer.slug
  }

  team {
    permission = "push"
    team_id    = github_team.tilburg-acato-maintainer.slug
  }

  # Restrict pushes to infrastructure as code to admins and maintainers

  team {
    permission = "triage"
    team_id    = github_team.kernteam-triage.slug
  }
}
