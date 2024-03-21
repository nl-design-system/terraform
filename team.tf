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

resource "github_team" "frameless-maintainer" {
  name           = "frameless-maintainer"
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
  name           = "logius-committer"
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

resource "github_team" "gemeente-amsterdam" {
  name        = "gemeente-amsterdam"
  description = "Gemeente Amsterdam"
  privacy     = "closed"
}

resource "github_team" "gemeente-bodegraven-reeuwijk" {
  name        = "gemeente-bodegraven-reeuwijk"
  description = "Gemeente Bodegraven-Reeuwijk"
  privacy     = "closed"
}

resource "github_team" "gemeente-borne" {
  name        = "gemeente-borne"
  description = "Gemeente Borne"
  privacy     = "closed"
}

resource "github_team" "gemeente-buren" {
  name        = "gemeente-buren"
  description = "Gemeente Buren"
  privacy     = "closed"
}

resource "github_team" "gemeente-drechterland" {
  name        = "gemeente-drechterland"
  description = "Gemeente Drechterland"
  privacy     = "closed"
}

resource "github_team" "gemeente-duiven" {
  name        = "gemeente-duiven"
  description = "Gemeente Duiven"
  privacy     = "closed"
}

resource "github_team" "gemeente-enkhuizen" {
  name        = "gemeente-enkhuizen"
  description = "Gemeente Enkhuizen"
  privacy     = "closed"
}

resource "github_team" "gemeente-groningen" {
  name        = "gemeente-groningen"
  description = "Gemeente Groningen"
  privacy     = "closed"
}

resource "github_team" "gemeente-haarlem" {
  name        = "gemeente-haarlem"
  description = "Gemeente Haarlem"
  privacy     = "closed"
}

resource "github_team" "gemeente-hoorn" {
  name        = "gemeente-hoorn"
  description = "Gemeente Hoorn"
  privacy     = "closed"
}

resource "github_team" "gemeente-horst-aan-de-maas" {
  name        = "gemeente-horst-aan-de-maas"
  description = "Gemeente Horst aan de Maas"
  privacy     = "closed"
}

resource "github_team" "gemeente-leidschendam-voorburg" {
  name        = "gemeente-leidschendam-voorburg"
  description = "Gemeente Leidschendam-Voorburg"
  privacy     = "closed"
}

resource "github_team" "gemeente-nijmegen" {
  name        = "gemeente-nijmegen"
  description = "Gemeente Nijmegen"
  privacy     = "closed"
}

resource "github_team" "gemeente-noordoostpolder" {
  name        = "gemeente-noordoostpolder"
  description = "Gemeente Noordoostpolder"
  privacy     = "closed"
}

resource "github_team" "gemeente-stedebroec" {
  name        = "gemeente-stedebroec"
  description = "Gemeente Stedebroec"
  privacy     = "closed"
}

resource "github_team" "gemeente-tilburg" {
  name        = "gemeente-tilburg"
  description = "Gemeente Tilburg"
  privacy     = "closed"
}

resource "github_team" "gemeente-venray" {
  name        = "gemeente-venray"
  description = "Gemeente Venray"
  privacy     = "closed"
}

resource "github_team" "gemeente-vught" {
  name        = "gemeente-vught"
  description = "Gemeente Vught"
  privacy     = "closed"
}

resource "github_team" "gemeente-westervoort" {
  name        = "gemeente-westervoort"
  description = "Gemeente Westervoort"
  privacy     = "closed"
}

resource "github_team" "gemeente-zevenaar" {
  name        = "gemeente-zevenaar"
  description = "Gemeente Zevenaar"
  privacy     = "closed"
}

resource "github_team" "gemeente-zwolle" {
  name        = "gemeente-zwolle"
  description = "Gemeente Zwolle"
  privacy     = "closed"
}

resource "github_team" "rid-de-liemers" {
  name        = "rid-de-liemers"
  description = "RID De Liemers: gemeenten Duiven, Westervoort en Zevenaar (Regionaal ICT en Inkoop Dienstencentrum)"
  privacy     = "closed"
}

resource "github_team" "minaz" {
  name        = "minaz"
  description = "Ministerie van Algemene Zaken"
  privacy     = "closed"
}

resource "github_team" "minaz-1overheid" {
  name           = "minaz-1overheid"
  description    = "1Overheid"
  parent_team_id = github_team.minaz.id
  privacy        = "closed"
}

resource "github_team" "provincie-zuid-holland" {
  name        = "provincie-zuid-holland"
  description = "Provincie Zuid-Holland"
  privacy     = "closed"
}

resource "github_team" "gravityforms" {
  name        = "gravityforms"
  description = "Gravityforms community"
  privacy     = "closed"
}
