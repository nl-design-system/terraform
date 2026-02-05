resource "github_repository" "rvo" {
  name                        = "rvo"
  description                 = "Work in Progress: RVO Design System based on the NL Design System architecture. Rijksdienst voor Ondernemend Nederland / rvo.nl"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://rvo.nl/roos/"
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  topics                      = ["nl-design-system"]

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

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

resource "github_branch_default" "rvo" {
  repository = github_repository.rvo.name
  branch     = "master"
}

resource "github_repository_ruleset" "rvo-master" {
  enforcement = "active"
  name        = "main"
  repository  = github_repository.rvo.name
  target      = "branch"

  bypass_actors {
    actor_id    = github_team.kernteam-ci.id
    actor_type  = "Team"
    bypass_mode = "always"
  }

  bypass_actors {
    actor_id    = github_team.rvo-maintainer.id
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
    non_fast_forward              = false
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

resource "github_repository_ruleset" "rvo-other" {
  enforcement = "active"
  name        = "other-branch-protection"
  repository  = github_repository.rvo.name
  target      = "branch"

  conditions {
    ref_name {
      include = ["refs/heads/gh-pages"]
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

resource "github_repository_collaborators" "rvo" {
  repository = github_repository.rvo.name

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
    team_id    = github_team.rvo-committer.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.rvo-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.community-committer.id
  }
}

resource "github_repository_environment" "rvo-publish" {
  environment       = "Publish"
  repository        = github_repository.rvo.name
  can_admins_bypass = false

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

removed {
  from = github_repository_deployment_branch_policy.rvo-publish-main
  lifecycle {
    destroy = false
  }
}

resource "github_repository_environment_deployment_policy" "rvo-publish-main" {
  repository     = github_repository.rvo.name
  environment    = github_repository_environment.rvo-publish.environment
  branch_pattern = github_branch_default.rvo.branch
}

import {
  id = "rvo:Publish:37531235"
  to = github_repository_environment_deployment_policy.rvo-publish-main
}
