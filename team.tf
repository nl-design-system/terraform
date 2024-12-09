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
  description    = "Admin rights for all repositories, in case of emergency. Configuration via Terraform is preferred."
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_team" "kernteam-committer" {
  description    = "Can create pull requests in all NL Design System repositories"
  name           = "kernteam-committer"
  parent_team_id = github_team.kernteam-triage.id
  privacy        = "closed"
}

resource "github_team" "kernteam-ci" {
  description    = "CI team for nl-design-system-ci that can bypass branch protections"
  name           = "kernteam-ci"
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"
}

resource "github_team" "kernteam-dependabot" {
  name           = "kernteam-dependabot"
  description    = "Default reviewers for Dependabot pull requests"
  parent_team_id = github_team.kernteam.id
  privacy        = "closed"
}

resource "github_team" "kernteam-maintainer" {
  name           = "kernteam-maintainer"
  description    = "Can configure GitHub via Terraform, with approval from kernteam-admin."
  parent_team_id = github_team.kernteam-committer.id
  privacy        = "closed"
}

resource "github_team" "kernteam-triage" {
  description    = "Can contribute to issues and projects."
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

resource "github_team" "gemeente-denhaag-acato-committer" {
  name           = "gemeente-denhaag-acato-committer"
  parent_team_id = github_team.gemeente-den-haag.id
  description    = "Team van Acato dat werkt aan het Den Haag Design System"
  privacy        = "closed"
}

resource "github_team" "gemeente-rotterdam" {
  name        = "gemeente-rotterdam"
  description = "Gemeente Rotterdam"
  privacy     = "closed"
}

resource "github_team" "gemeente-rotterdam-triage" {
  name           = "gemeente-rotterdam-triage"
  parent_team_id = github_team.gemeente-rotterdam.id
  description    = "Rotterdam Design System team (read only)"
  privacy        = "closed"
}

resource "github_team" "gemeente-rotterdam-committer" {
  name           = "gemeente-rotterdam-committer"
  parent_team_id = github_team.gemeente-rotterdam-triage.id
  description    = "Rotterdam Design System team (read and write)"
  privacy        = "closed"
}

resource "github_team" "gemeente-rotterdam-maintainer" {
  name           = "gemeente-rotterdam-maintainer"
  parent_team_id = github_team.gemeente-rotterdam-committer.id
  description    = "Rotterdam Design System team (maintainer)"
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

resource "github_team" "gemeente-utrecht-estafettemodel" {
  name           = "gemeente-utrecht-estafettemodel"
  parent_team_id = github_team.gemeente-utrecht.id
  description    = "Team dat componenten van gemeente Utrecht door het Estafettemodel haalt"
  privacy        = "closed"
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

resource "github_team" "gebruikersonderzoeken" {
  name    = "gebruikersonderzoeken"
  privacy = "closed"
}

resource "github_team" "rvo" {
  name        = "rvo"
  description = "Rijksdienst voor Ondernemend Nederland (RVO)"
  privacy     = "closed"
}

resource "github_team" "rvo-committer" {
  name           = "rvo-committer"
  parent_team_id = github_team.rvo.id
  privacy        = "closed"
}

resource "github_team" "rvo-maintainer" {
  name           = "rvo-maintainer"
  parent_team_id = github_team.rvo-committer.id
  privacy        = "closed"
}

resource "github_team" "rvo-estafettemodel" {
  name           = "rvo-estafettemodel"
  parent_team_id = github_team.rvo.id
  description    = "Team dat componenten van RVO door het Estafettemodel haalt"
  privacy        = "closed"
}

resource "github_team" "logius" {
  name        = "logius"
  description = "Logius"
  privacy     = "closed"
}

resource "github_team" "logius-committer" {
  name           = "logius-committer"
  parent_team_id = github_team.logius.id
  privacy        = "closed"
}

resource "github_team" "logius-maintainer" {
  name           = "logius-maintainer"
  parent_team_id = github_team.logius-committer.id
  privacy        = "closed"
}

resource "github_team" "logius-triage" {
  name           = "logius-triage"
  parent_team_id = github_team.logius.id
  privacy        = "closed"
}

resource "github_team" "logius-estafettemodel" {
  name           = "logius-estafettemodel"
  parent_team_id = github_team.logius.id
  description    = "Team dat componenten van Lux door het Estafettemodel haalt"
  privacy        = "closed"
}

resource "github_team" "rivm" {
  name        = "rivm"
  description = "Rijksinstituut voor Volksgezondheid en Milieu (RIVM)"
  privacy     = "closed"
}

resource "github_team" "rivm-committer" {
  name           = "rivm-committer"
  parent_team_id = github_team.rivm.id
  description    = "Rijksinstituut voor Volksgezondheid en Milieu (RIVM)"
  privacy        = "closed"
}

resource "github_team" "rivm-maintainer" {
  name           = "rivm-maintainer"
  parent_team_id = github_team.rivm-committer.id
  description    = "Rijksinstituut voor Volksgezondheid en Milieu (RIVM)"
  privacy        = "closed"
}

resource "github_team" "gemeente-amsterdam" {
  name        = "gemeente-amsterdam"
  description = "Gemeente Amsterdam"
  privacy     = "closed"
}

resource "github_team" "gemeente-amsterdam-estafettemodel" {
  name           = "gemeente-amsterdam-estafettemodel"
  parent_team_id = github_team.gemeente-amsterdam.id
  description    = "Team dat componenten van gemeente Amsterdam door het Estafettemodel haalt"
  privacy        = "closed"
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

resource "github_team" "tilburg" {
  name    = "tilburg"
  privacy = "closed"
}

resource "github_team" "tilburg-acato-committer" {
  name           = "tilburg-acato"
  parent_team_id = github_team.tilburg.id
  privacy        = "closed"
}

resource "github_team" "tilburg-acato-maintainer" {
  name           = "tilburg-acato-maintainer"
  parent_team_id = github_team.tilburg-acato-committer.id
  privacy        = "closed"
}

resource "github_team" "tilburg-ditp-committer" {
  name           = "tilburg-ditp"
  parent_team_id = github_team.tilburg.id
  privacy        = "closed"
}

resource "github_team" "tilburg-ditp-maintainer" {
  name           = "tilburg-ditp-maintainer"
  parent_team_id = github_team.tilburg-ditp-committer.id
  privacy        = "closed"
}

resource "github_team" "vng-services" {
  name        = "vng-services"
  privacy     = "closed"
  description = "VNG Team dat werkt aan de Overheidsbrede portalen storybook"
}

resource "github_team" "vng-services-committer" {
  name           = "vng-services-committer"
  parent_team_id = github_team.vng-services.id
  privacy        = "closed"
}

resource "github_team" "vng-services-maintainer" {
  name           = "vng-services-maintainer"
  parent_team_id = github_team.vng-services-committer.id
  privacy        = "closed"
}

resource "github_team" "voorbeeld-theme-committer" {
  name        = "voorbeeld-theme-committer"
  privacy     = "closed"
  description = "Team dat werkt aan het Voorbeeld Thema van NL Design System"
}

resource "github_team" "quintor-rijkshuisstijl" {
  name        = "quintor-rijkshuisstijl"
  privacy     = "closed"
  description = "Quintor Team dat werkt aan de Rijkshuisstijl Community Storybook"
}

resource "github_team" "quintor-rijkshuisstijl-committer" {
  name           = "quintor-rijkshuisstijl-committer"
  parent_team_id = github_team.quintor-rijkshuisstijl.id
  privacy        = "closed"
}

resource "github_team" "quintor-rijkshuisstijl-maintainer" {
  name           = "quintor-rijkshuisstijl-maintainer"
  parent_team_id = github_team.quintor-rijkshuisstijl-committer.id
  privacy        = "closed"
}

resource "github_team" "blueriq" {
  name        = "blueriq"
  privacy     = "closed"
  description = "Blueriq team (https://www.blueriq.com)"
}

resource "github_team" "blueriq-committer" {
  name           = "blueriq-committer"
  parent_team_id = github_team.blueriq.id
  privacy        = "closed"
}

resource "github_team" "blueriq-maintainer" {
  name           = "blueriq-maintainer"
  parent_team_id = github_team.blueriq-committer.id
  privacy        = "closed"
}

resource "github_team" "minjus-rijkshuisstijl" {
  name        = "minjus-rijkshuisstijl"
  privacy     = "closed"
  description = "Ministerie van Justitie"
}

resource "github_team" "minjus-rijkshuisstijl-committer" {
  name           = "minjus-rijkshuisstijl-committer"
  parent_team_id = github_team.minjus-rijkshuisstijl.id
  privacy        = "closed"
}

resource "github_team" "minjus-rijkshuisstijl-maintainer" {
  name           = "minjus-rijkshuisstijl-maintainer"
  parent_team_id = github_team.minjus-rijkshuisstijl-committer.id
  privacy        = "closed"
}

resource "github_team" "icons-committer" {
  name        = "icons-committer"
  privacy     = "closed"
  description = "Makers van open source iconen"
}


resource "github_team" "gemeente-almere" {
  name        = "gemeente-almere"
  privacy     = "closed"
  description = "Gemeente Almere"
}

resource "github_team" "gemeente-almere-committer" {
  name           = "gemeente-almere-committer"
  parent_team_id = github_team.gemeente-almere.id
  privacy        = "closed"
}

resource "github_team" "nora" {
  name        = "nora"
  privacy     = "closed"
  description = "Nederlandse Overheid Referentie Architectuur"
}

resource "github_team" "nora-committer" {
  name           = "nora-committer"
  parent_team_id = github_team.nora.id
  privacy        = "closed"
}

resource "github_team" "tiptap" {
  name        = "tiptap"
  privacy     = "closed"
  description = "Tiptap Editor contributors"
}

resource "github_team" "tiptap-committer" {
  name           = "tiptap-committer"
  parent_team_id = github_team.tiptap.id
  privacy        = "closed"
}

resource "github_team" "documentatie" {
  name        = "documentatie"
  privacy     = "closed"
  description = "documentatie contributors"
}

resource "github_team" "community-committer" {
  name        = "community-committer"
  privacy     = "closed"
  description = "Committers who make can make Pull Requests for all public repositories"
}
