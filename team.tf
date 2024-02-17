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

resource "github_team" "gemeente-denhaag-admin" {
  name           = "gemeente-denhaag-admin"
  parent_team_id = github_team.gemeente-den-haag.id
  description    = "Gemeente Den Haag administrator access"
  privacy        = "closed"
}

resource "github_team" "gemeente-denhaag-design-system" {
  name           = "gemeente-denhaag-design-system"
  parent_team_id = github_team.gemeente-den-haag.id
  description    = "Den Haag System team"
  privacy        = "closed"
}

resource "github_team" "gemeente-rotterdam" {
  name        = "gemeente-rotterdam"
  description = "Gemeente Rotterdam"
  privacy     = "closed"
}

resource "github_team" "gemeente-rotterdam-design-system" {
  name           = "gemeente-rotterdam-design-system"
  parent_team_id = github_team.gemeente-rotterdam.id
  description    = "Rotterdam System team"
  privacy        = "closed"
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

resource "github_team" "gemeente-utrecht" {
  name        = "gemeente-utrecht"
  description = "Gemeente Utrecht"
  privacy     = "closed"
}

resource "github_team" "frameless" {
  name    = "frameless"
  privacy = "closed"
}

resource "github_team" "frameless-admin" {
  name           = "frameless-admin"
  parent_team_id = github_team.frameless.id
  privacy        = "closed"
}

resource "github_team" "frameless-intern" {
  name           = "frameless-intern"
  parent_team_id = github_team.frameless.id
  privacy        = "closed"
}

resource "github_team" "gebruikersonderzoeken" {
  name    = "gebruikersonderzoeken"
  privacy = "closed"
}

resource "github_team" "rvo" {
  name        = "rvo"
  description = "Rijksdienst voor Ondernemend Nederland (RVO)"
  privacy     = "closed"
}

resource "github_team" "logius" {
  name        = "logius"
  description = "Logius"
  privacy     = "closed"
}

resource "github_team" "logius-maintainer" {
  name           = "logius-maintainer"
  parent_team_id = github_team.logius.id
  privacy        = "closed"
}

resource "github_team" "logius-committer" {
  name           = "logius-maintainer"
  parent_team_id = github_team.logius.id
  privacy        = "closed"
}

resource "github_team" "logius-triage" {
  name           = "logius-triage"
  parent_team_id = github_team.logius.id
  privacy        = "closed"
}

resource "github_team" "rivm" {
  name        = "rivm"
  description = "Rijksinstituut voor Volksgezondheid en Milieu (RIVM)"
  privacy     = "closed"
}
