resource "github_team" "kernteam" {
  name        = "kernteam"
  description = "NL Design System kernteam"
  privacy     = "closed"

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_team" "kernteam-admin" {
  name           = "kernteam-admin"
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_team" "kernteam-committer" {
  name           = "kernteam-committer"
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"
}

resource "github_team" "kernteam-dependabot" {
  name           = "kernteam-dependabot"
  description    = "Default reviewers for Dependabot pull requests"
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"
}

resource "github_team" "kernteam-developers" {
  name           = "kernteam-developers"
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"
}

resource "github_team" "kernteam-maintainer" {
  name           = "kernteam-maintainer"
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"
}

resource "github_team" "kernteam-triage" {
  name           = "kernteam-triage"
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"
}

resource "github_team" "gemeente-den-haag" {
  name        = "gemeente-den-haag"
  description = "Gemeente Den Haag"
  privacy     = "closed"
}

resource "github_team" "denhaag-acato" {
  name           = "denhaag-acato"
  parent_team_id = github_team.gemeente-den-haag.id
  privacy        = "closed"
}

resource "github_team" "denhaag-draad" {
  name           = "denhaag-draad"
  parent_team_id = github_team.gemeente-den-haag.id
  privacy        = "closed"
}
