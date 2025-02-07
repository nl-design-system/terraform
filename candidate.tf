resource "github_repository" "candidate" {
  name                        = "candidate"
  description                 = "NL Design System Candidate components"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = true
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/candidate/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "storybook"]

  template {
    owner                = "nl-design-system"
    repository           = "example"
    include_all_branches = false
  }

  pages {
    build_type = "workflow"
  }

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository_ruleset" "candidate-main" {
  name        = "main"
  repository  = github_repository.candidate.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/main"]
      exclude = []
    }
  }

  rules {
    pull_request {
      dismiss_stale_reviews_on_push     = true
      required_approving_review_count   = 1
      required_review_thread_resolution = true
    }
    required_linear_history = true

    required_status_checks {
      required_check {
        context = "build"
      }
      required_check {
        context = "install"
      }
      required_check {
        context = "lint"
      }
      required_check {
        context = "test"
      }
    }
  }

  bypass_actors {
    actor_id    = github_team.kernteam-ci.id
    actor_type  = "Team"
    bypass_mode = "always"
  }
}

resource "github_repository_collaborators" "candidate" {
  repository = github_repository.candidate.name

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

resource "vercel_project" "candidate" {
  name             = github_repository.candidate.name
  output_directory = "packages/storybook/dist"
  ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"

  git_repository = {
    type = "github"
    repo = "${data.github_organization.nl-design-system.orgname}/${github_repository.candidate.name}"
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}

resource "vercel_project" "candidate-storybook-non-conforming" {
  name             = "candidate-storybook-non-conforming"
  output_directory = "packages/storybook-non-conforming/dist/"
  ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"

  git_repository = {
    type = "github"
    repo = "${data.github_organization.nl-design-system.orgname}/${github_repository.candidate.name}"
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}

resource "vercel_project" "candidate-storybook-test" {
  name             = "candidate-storybook-test"
  output_directory = "packages/storybook-test/dist/"
  ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"

  git_repository = {
    type = "github"
    repo = "${data.github_organization.nl-design-system.orgname}/${github_repository.candidate.name}"
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}

