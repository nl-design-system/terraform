resource "github_repository" "themes" {
  name                        = "themes"
  description                 = "Design Tokens and NL Design System themes for organisations that don't have their own Storybook."
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  vulnerability_alerts        = true
  homepage_url                = "https://nl-design-system.github.io/themes/"
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

resource "github_branch_protection" "themes-main" {
  repository_id = github_repository.themes.node_id

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
    ]
  }

  required_status_checks {
    strict   = false
    contexts = ["Continuous integration"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
    pull_request_bypassers = [
      "/${data.github_user.nl-design-system-ci.username}",
    ]
  }
}

resource "github_branch_protection" "themes-gh-pages" {
  repository_id = github_repository.themes.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}

resource "github_repository_collaborators" "themes" {
  repository = github_repository.themes.name

  team {
    permission = "admin"
    team_id    = github_team.kernteam-admin.slug
  }

  team {
    permission = "maintain"
    team_id    = github_team.kernteam-maintainer.slug
  }

  team {
    permission = "push"
    team_id    = github_team.kernteam-committer.slug
  }

  team {
    permission = "triage"
    team_id    = github_team.kernteam-triage.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-amsterdam.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-bodegraven-reeuwijk.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-bodegraven-reeuwijk.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-borne.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-buren.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-den-haag.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-drechterland.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-duiven.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-enkhuizen.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-groningen.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-haarlem.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-hoorn.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-horst-aan-de-maas.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-leidschendam-voorburg.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-nijmegen.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-noordoostpolder.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-stedebroec.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-tilburg.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-utrecht.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-venray.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-vught.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-westervoort.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-zevenaar.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-zwolle.slug
  }

  team {
    permission = "push"
    team_id    = github_team.rid-de-liemers.slug
  }

  team {
    permission = "push"
    team_id    = github_team.provincie-zuid-holland.slug
  }

  team {
    permission = "push"
    team_id    = github_team.minaz-1overheid.slug
  }

  team {
    permission = "push"
    team_id    = github_team.frameless.slug
  }

  team {
    permission = "push"
    team_id    = github_team.logius.slug
  }

  team {
    permission = "push"
    team_id    = github_team.voorbeeld-theme-committer.slug
  }

  team {
    permission = "push"
    team_id    = github_team.vng-services-committer.slug
  }

  team {
    permission = "push"
    team_id    = github_team.gemeente-almere-committer.slug
  }
}
