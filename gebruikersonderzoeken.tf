resource "github_repository" "gebruikersonderzoeken" {
  name                        = "gebruikersonderzoeken"
  description                 = "Gedeeld gebruikersonderzoek door UX researchers van verschillende organisaties in de Nederlandse overheid."
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
  homepage_url                = "https://gebruikersonderzoeken.nl/"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "docusaurus"]

  template {
    include_all_branches = false
    owner                = "nl-design-system"
    repository           = "example"
  }

  pages {
    build_type = "workflow"
    cname      = "gebruikersonderzoeken.nl"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "gebruikersonderzoeken-main" {
  repository_id = github_repository.gebruikersonderzoeken.node_id

  pattern                         = "main"
  enforce_admins                  = true
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  restrict_pushes {
    blocks_creations = false
    push_allowances = [
      "${data.github_organization.nl-design-system.orgname}/${github_team.kernteam-maintainer.name}",
      "${data.github_organization.nl-design-system.orgname}/${github_team.gebruikersonderzoeken.name}"
    ]
  }

  required_status_checks {
    strict   = false
    contexts = ["Lint code", "Build"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
  }
}

resource "github_branch_protection" "gebruikersonderzoeken-gh-pages" {
  repository_id = github_repository.gebruikersonderzoeken.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}

resource "github_repository_collaborators" "gebruikersonderzoeken" {
  repository = github_repository.gebruikersonderzoeken.name

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
    permission = "maintain"
    team_id    = github_team.gebruikersonderzoeken.id
  }
}
