resource "github_repository" "rijkshuisstijl-community" {
  name                        = "rijkshuisstijl-community"
  description                 = "Unofficial Rijkshuisstijl components and design tokens based on the NL Design System architecture. This project is not endorsed by the Dutch Ministry of General Affairs."
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
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

resource "github_branch_protection" "rijkshuisstijl-community-main" {
  repository_id = github_repository.rijkshuisstijl-community.node_id

  pattern                         = "main"
  enforce_admins                  = false
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  restrict_pushes {
    blocks_creations = false
    push_allowances = [
      "/${data.github_user.nl-design-system-ci.username}",
      "${data.github_organization.nl-design-system.orgname}/${github_team.kernteam-maintainer.name}",
      "${data.github_organization.nl-design-system.orgname}/${github_team.kernteam-committer.name}",
      "${data.github_organization.nl-design-system.orgname}/${github_team.quintor-rijkshuisstijl-committer.name}",
      "${data.github_organization.nl-design-system.orgname}/${github_team.logius-committer.name}",
    ]
  }

  required_status_checks {
    strict   = false
    contexts = ["build", "lint", "test", "test-a11y"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
    pull_request_bypassers = [
      "/${data.github_user.nl-design-system-ci.username}",
    ]
  }
}

resource "github_branch_protection" "rijkshuisstijl-community-gh-pages" {
  repository_id = github_repository.rijkshuisstijl-community.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
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
}

resource "vercel_project" "rijkshuisstijl-community-templates" {
  name             = "rijkshuisstijl-community-templates"
  output_directory = "apps/rhc-templates/dist/"
  ignore_command   = "[[ $(git log -1 --pretty=%an) == 'dependabot[bot]' ]]"

  git_repository = {
    type = "github"
    repo = "${data.github_organization.nl-design-system.orgname}/${github_repository.rijkshuisstijl-community.name}",
  }

  vercel_authentication = {
    deployment_type = "none"
  }
}
