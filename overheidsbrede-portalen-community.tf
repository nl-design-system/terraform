resource "github_repository" "overheidsbrede-portalen-community" {
  name                        = "overheidsbrede-portalen-community"
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
  homepage_url                = "https://nl-design-system.github.io/overheidsbrede-portalen-community/"
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

resource "github_branch_default" "overheidsbrede-portalen-community" {
  branch     = "main"
  repository = github_repository.overheidsbrede-portalen-community.name
}

resource "github_repository_ruleset" "overheidsbrede-portalen-community-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.overheidsbrede-portalen-community.name
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

resource "github_repository_collaborators" "overheidsbrede-portalen-community" {
  repository = github_repository.overheidsbrede-portalen-community.name

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
}

resource "vercel_project" "overheidsbrede-portalen-community" {
  name             = github_repository.overheidsbrede-portalen-community.name
  output_directory = "packages/storybook/dist/"
  ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"
  node_version     = "22.x"

  git_repository = {
    type = "github"
    repo = github_repository.overheidsbrede-portalen-community.full_name
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}
