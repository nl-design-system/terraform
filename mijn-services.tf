resource "github_repository" "mijn-services" {
  name                        = "mijn-services"
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
  homepage_url                = "https://nl-design-system.github.io/mijn-services/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "storybook"]

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

resource "github_branch_default" "mijn-services" {
  branch     = "main"
  repository = github_repository.mijn-services.name
  rename     = false
}

resource "github_repository_ruleset" "mijn-services-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.mijn-services.name
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

    required_status_checks {
      strict_required_status_checks_policy = false

      required_check {
        context = "install"
      }
      required_check {
        context = "lint"
      }
      required_check {
        context = "build"
      }
    }
  }
}

resource "github_repository_collaborators" "mijn-services" {
  repository = github_repository.mijn-services.name

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
    permission = "push"
    team_id    = github_team.vng-services-committer.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.vng-services-maintainer.id
  }

  team {
    permission = "triage"
    team_id    = github_team.vng-services.id
  }

  team {
    permission = "push"
    team_id    = github_team.community-committer.id
  }
}

resource "github_repository_environment" "mijn-services-publish" {
  environment       = "Publish"
  repository        = github_repository.mijn-services.name
  can_admins_bypass = false

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_deployment_branch_policy" "mijn-services-publish-main" {
  depends_on = [github_repository_environment.mijn-services-publish]

  repository       = github_repository.mijn-services.name
  environment_name = github_repository_environment.mijn-services-publish.environment
  name             = github_branch_default.mijn-services.branch
}

resource "vercel_project" "mijn-services" {
  name             = github_repository.mijn-services.name
  output_directory = "packages/storybook/dist/"
  ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"
  node_version     = "22.x"

  git_repository = {
    type = "github"
    repo = github_repository.mijn-services.full_name
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}
