resource "github_repository" "rvo" {
  name                        = "rvo"
  description                 = "Work in Progress: RVO Design System based on the NL Design System architecture. Rijksdienst voor Ondernemend Nederland / rvo.nl"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  delete_branch_on_merge      = true
  has_issues                  = true
  has_downloads               = true
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

resource "github_branch_protection" "rvo-master" {
  repository_id = github_repository.rvo.node_id

  pattern                         = "master"
  enforce_admins                  = false
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = false
  allows_force_pushes             = true
  lock_branch                     = false

  restrict_pushes {
    blocks_creations = false
    push_allowances = [
      "/${data.github_user.nl-design-system-ci.username}",
      "nl-design-system/${github_team.kernteam-maintainer.name}",
      "nl-design-system/${github_team.rvo-committer.name}",
      "nl-design-system/${github_team.rvo-maintainer.name}",
    ]
  }

  required_status_checks {
    strict   = false
    contexts = []
  }
  required_pull_request_reviews {
    # As agreed with the RVO team mainainer, no PR approvals are needed
    required_approving_review_count = 0
    dismiss_stale_reviews           = true
    restrict_dismissals             = false
    pull_request_bypassers = [
      "/${data.github_user.nl-design-system-ci.username}",
    ]
  }
}


resource "github_branch_protection" "rvo-gh-pages" {
  repository_id = github_repository.rvo.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
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
}
