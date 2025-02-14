resource "github_repository" "gebruikersonderzoeken" {
  name                        = "gebruikersonderzoeken"
  description                 = "Gedeeld gebruikersonderzoek door UX researchers van verschillende organisaties in de Nederlandse overheid."
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
  homepage_url                = "https://gebruikersonderzoeken.nl/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "docusaurus"]

  template {
    include_all_branches = false
    owner                = "nl-design-system"
    repository           = "example"
  }

  pages {
    build_type = "workflow"
    cname      = "gebruikersonderzoeken.nl"

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

resource "github_branch_default" "gebruikersonderzoeken" {
  branch     = "main"
  repository = github_repository.gebruikersonderzoeken.name
}

resource "github_repository_ruleset" "gebruikersonderzoeken-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.gebruikersonderzoeken.name
  target      = "branch"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    creation                      = true
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

    required_status_checks {
      do_not_enforce_on_create             = false
      strict_required_status_checks_policy = false

      required_check {
        context = "Lint code"
      }

      required_check {
        context = "Build"
      }
    }
  }
}

resource "github_repository_collaborators" "gebruikersonderzoeken" {
  repository = github_repository.gebruikersonderzoeken.name

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
    team_id    = github_team.gebruikersonderzoeken.id
  }
}
