resource "github_repository" "matomo" {
  name                        = "matomo"
  description                 = "Track user preferences in Matomo, to help prioritise design system work."
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

  archive_on_destroy = true
  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "matomo" {
  repository = github_repository.matomo.name
  branch     = "main"
}

resource "github_repository_ruleset" "matomo-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.matomo.name
  target      = "branch"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    creation                      = false
    deletion                      = true
    non_fast_forward              = true
    required_linear_history       = true
    required_signatures           = false
    update                        = false
    update_allows_fetch_and_merge = false

    pull_request {
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = true
      require_last_push_approval        = false
      required_approving_review_count   = 1
      required_review_thread_resolution = true
    }
  }
}
resource "github_repository_collaborators" "matomo" {
  repository = github_repository.matomo.name

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
}
