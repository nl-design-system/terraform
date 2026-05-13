import {
  to = github_repository.hall-of-fame
  id = "hall-of-fame"
}

import {
  to = github_branch_default.hall-of-fame
  id = "hall-of-fame"
}

import {
  to = github_repository_ruleset.hall-of-fame-main
  id = "hall-of-fame:2782000"
}

import {
  to = github_repository_collaborators.hall-of-fame
  id = "hall-of-fame"
}

resource "github_repository" "hall-of-fame" {
  name                        = "hall-of-fame"
  description                 = "NL Design System Hall of Fame components"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/hall-of-fame/"
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

resource "github_branch_default" "hall-of-fame" {
  repository = github_repository.hall-of-fame.name
  branch     = "main"
}

resource "github_repository_ruleset" "hall-of-fame-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.hall-of-fame.name
  target      = "branch"

  bypass_actors {
    actor_id    = github_team.kernteam-ci.id
    actor_type  = "Team"
    bypass_mode = "always"
  }

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
      strict_required_status_checks_policy = true

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
}

resource "github_repository_collaborators" "hall-of-fame" {
  repository = github_repository.hall-of-fame.name

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
    team_id    = github_team.community-contributor.id
  }
}

resource "github_repository_environment" "hall-of-fame-publish" {
  environment       = "Publish"
  repository        = github_repository.hall-of-fame.name
  can_admins_bypass = false

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_environment_deployment_policy" "hall-of-fame-publish-main" {
  repository     = github_repository.hall-of-fame.name
  environment    = github_repository_environment.hall-of-fame-publish.environment
  branch_pattern = github_branch_default.hall-of-fame.branch
}

resource "vercel_project" "hall-of-fame" {
  name                    = github_repository.hall-of-fame.name
  output_directory        = "packages/storybook/dist"
  ignore_command          = "[[ \"$VERCEL_GIT_COMMIT_AUTHOR_LOGIN\" == \"dependabot[bot]\" ]]"
  node_version            = "24.x"
  enable_preview_feedback = false

  git_repository = {
    type = "github"
    repo = github_repository.hall-of-fame.full_name
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}
