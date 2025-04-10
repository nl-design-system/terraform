resource "github_repository" "rijkshuisstijl-community" {
  name                        = "rijkshuisstijl-community"
  description                 = "Unofficial Rijkshuisstijl components and design tokens based on the NL Design System architecture. This project is not endorsed by the Dutch Ministry of General Affairs."
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_discussions             = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = true
  has_wiki                    = true
  vulnerability_alerts        = true
  homepage_url                = "https://rijkshuisstijl-community.vercel.app/"
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

resource "github_branch_default" "rijkshuisstijl-community" {
  repository = github_repository.rijkshuisstijl-community.name
  branch     = "main"
}

resource "github_repository_ruleset" "rijkshuisstijl-community-main" {
  enforcement = "active"
  name        = "default-branch-protection"
  repository  = github_repository.rijkshuisstijl-community.name
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
        context = "lint"
      }
      required_check {
        context = "test"
      }
      required_check {
        context = "test-a11y"
      }
    }
  }
}

resource "github_repository_ruleset" "rijkshuisstijl-community-other" {
  enforcement = "active"
  name        = "other-branch-protection"
  repository  = github_repository.rijkshuisstijl-community.name
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

resource "github_repository_collaborators" "rijkshuisstijl-community" {
  repository = github_repository.rijkshuisstijl-community.name

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
    team_id    = github_team.frameless.id
  }

  team {
    permission = "push"
    team_id    = github_team.logius.id
  }

  team {
    permission = "push"
    team_id    = github_team.rivm.id
  }

  team {
    permission = "push"
    team_id    = github_team.rvo.id
  }

  team {
    permission = "push"
    team_id    = github_team.quintor-rijkshuisstijl-committer.id
  }

  team {
    permission = "push"
    team_id    = github_team.minjus-rijkshuisstijl-committer.id
  }

  team {
    permission = "push"
    team_id    = github_team.developer_overheid_nl-committer.id
  }

  user {
    permission = "push"
    username   = data.github_user.WebBeest.username
  }
}

resource "vercel_project" "rijkshuisstijl-community-templates" {
  name             = "rijkshuisstijl-community-templates"
  output_directory = "apps/rhc-templates/dist/"
  ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"
  node_version     = "22.x"

  git_repository = {
    type = "github"
    repo = "${data.github_organization.nl-design-system.orgname}/${github_repository.rijkshuisstijl-community.name}"
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}

# resource "vercel_project" "rijkshuisstijl-community-storybook-angular" {
#   name             = "rijkshuisstijl-community-storybook-angular"
#   output_directory = "packages/storybook-angular/dist/"
#   ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"
#   node_version     = "22.x"
#   team_id          = data.vercel_team_config.nl-design-system.id

#   git_repository = {
#     type = "github"
#     repo = "${data.github_organization.nl-design-system.orgname}/${github_repository.rijkshuisstijl-community.name}"
#   }

#   vercel_authentication = {
#     deployment_type = "none"
#   }
# }
