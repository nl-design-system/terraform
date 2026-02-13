resource "github_repository" "documentatie" {
  name                        = "documentatie"
  description                 = "Website met documentatie van NL Design system: componenten, patronen, richtlijnen etcetera. Development-versie: https://documentatie.vercel.app/"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_projects                = true
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

resource "github_branch_default" "documentatie" {
  repository = github_repository.documentatie.name
  branch     = "main"
}

resource "github_repository_ruleset" "documentatie-default" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.documentatie.name
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
      strict_required_status_checks_policy = false

      required_check {
        context = "continuous-integration"
      }
    }
  }
}

resource "github_repository_ruleset" "documentatie-other" {
  enforcement = "active"
  name        = "other-branch-protection"
  repository  = github_repository.documentatie.name
  target      = "branch"

  conditions {
    ref_name {
      include = [
        "refs/heads/gh-pages",
        "refs/heads/assets",
        "refs/heads/storybook",
      ]
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
  }
}

resource "github_repository_collaborators" "documentatie" {
  repository = github_repository.documentatie.name

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
    permission = "push"
    team_id    = github_team.kernteam-a11y.id
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
    team_id    = github_team.community-committer.id
  }

  team {
    permission = "push"
    team_id    = github_team.expertteam-digitale-toegankelijkheid-committer.id
  }
}

resource "github_repository_environment" "documentatie-publish" {
  environment       = "Publish"
  repository        = github_repository.documentatie.name
  can_admins_bypass = false

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

removed {
  from = github_repository_deployment_branch_policy.documentatie-publish-main
  lifecycle {
    destroy = false
  }
}

resource "github_repository_environment_deployment_policy" "documentatie-publish-main" {
  repository     = github_repository.documentatie.name
  environment    = github_repository_environment.documentatie-publish.environment
  branch_pattern = github_branch_default.documentatie.branch
}

import {
  id = "documentatie:Publish:37531228"
  to = github_repository_environment_deployment_policy.documentatie-publish-main
}

resource "github_repository_webhook" "documentatie" {
  repository = github_repository.documentatie.name
  events     = ["push"]

  configuration {
    url          = "https://prod.github-push.ictu.nl/modules/git/public/web-hook.php?uuid=${var.PLESK_WEBHOOK_UUID}"
    content_type = "form"
  }
}

resource "vercel_project" "documentatie-next" {
  name                    = "documentatie-next"
  output_directory        = "packages/website/dist/"
  build_command           = "pnpm run build"
  ignore_command          = "[[ \"$VERCEL_GIT_COMMIT_AUTHOR_LOGIN\" == \"dependabot[bot]\" || \"$VERCEL_GIT_COMMIT_REF\" == \"gh-pages\" ]]"
  node_version            = "24.x"
  enable_preview_feedback = false

  git_repository = {
    type = "github"
    repo = github_repository.documentatie.full_name
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}
