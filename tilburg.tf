resource "github_repository" "tilburg" {
  name                        = "tilburg"
  description                 = "Work in Progress: Tilburg Design System based on the NL Design System architecture."
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
  homepage_url                = "https://nl-design-system.github.io/tilburg/"
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

resource "github_branch_default" "tilburg" {
  repository = github_repository.tilburg.name
  branch     = "main"
}

resource "github_repository_ruleset" "tilburg-main" {
  enforcement = "active"
  name        = "main-branch-protection"
  repository  = github_repository.tilburg.name
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
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_approving_review_count   = 1
      required_review_thread_resolution = true
    }

    required_status_checks {
      strict_required_status_checks_policy = false

      required_check {
        context = "install"
      }
      required_check {
        context = "lint"
      }
      required_check {
        context = "test"
      }
      required_check {
        context = "build"
      }
    }
  }
}

resource "github_repository_collaborators" "tilburg" {
  repository = github_repository.tilburg.name

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
    permission = "push"
    team_id    = github_team.tilburg-committer.id
  }

  team {
    permission = "push"
    team_id    = github_team.tilburg-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.tilburg-acato-committer.id
  }

  team {
    permission = "push"
    team_id    = github_team.tilburg-ditp-committer.id
  }

  team {
    permission = "push"
    team_id    = github_team.blueriq-committer.id
  }
}

resource "vercel_project" "tilburg" {
  name             = github_repository.tilburg.name
  output_directory = "packages/storybook/dist/"
  ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"

  git_repository = {
    type = "github"
    repo = "${data.github_organization.nl-design-system.orgname}/${github_repository.tilburg.name}",
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}
