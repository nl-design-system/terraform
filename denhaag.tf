resource "github_repository" "denhaag" {
  name                        = "denhaag"
  description                 = "Work in Progress: Den Haag Design System based on the NL Design System architecture"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = true
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/denhaag/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "storybook", "react", "component-library"]

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

resource "github_branch_default" "denhaag" {
  repository = github_repository.denhaag.name
  branch     = "main"
}

resource "github_repository_ruleset" "denhaag-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.denhaag.name
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
        context = "build"
      }
      required_check {
        context = "UI Tests"
      }
    }
  }
}

resource "github_repository_ruleset" "denhaag-www-denhaag-nl" {
  enforcement = "active"
  name        = "www-denhaag-nl-branch-protection"
  repository  = github_repository.denhaag.name
  target      = "branch"

  bypass_actors {
    actor_id    = github_team.kernteam-ci.id
    actor_type  = "Team"
    bypass_mode = "always"
  }

  conditions {
    ref_name {
      include = ["refs/heads/www.denhaag.nl"]
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
        context = "build"
      }
      required_check {
        context = "UI Tests"
      }
    }
  }
}

resource "github_repository_ruleset" "denhaag-other" {
  enforcement = "active"
  name        = "other-branch-protection"
  repository  = github_repository.denhaag.name
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

resource "github_repository_collaborators" "denhaag" {
  repository = github_repository.denhaag.name

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
    permission = "admin"
    team_id    = github_team.gemeente-denhaag-admin.id
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-denhaag-design-system.id
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-denhaag-acato-committer.id
  }

  team {
    permission = "push"
    team_id    = github_team.denhaag-acato.id
  }

  team {
    permission = "push"
    team_id    = github_team.frameless.id
  }

  team {
    permission = "maintain"
    team_id    = github_team.frameless-maintainer.id
  }

  team {
    permission = "push"
    team_id    = github_team.community-committer.id
  }
}
