resource "github_team_members" "frameless" {
  team_id = github_team.frameless.id

  members {
    username = data.github_user.ali-kadhim.username
  }

  members {
    username = data.github_user.savitris.username
  }

  members {
    username = data.github_user.bddjong.username
  }

  members {
    username = data.github_user.scar055.username
  }

  members {
    username = data.github_user.MeesoPost.username
  }
}

resource "github_team_members" "frameless-maintainer" {
  team_id = github_team.frameless-maintainer.id

  # Disable Yolijn and Robbert from Frameless maintainer team,
  # while they have conflicting roles with more permissions in nl-design-system/kernteam.

  # members {
  #   username = data.github_user.yolijn.username
  #   role     = "maintainer"
  # }

  # members {
  #   username = data.github_user.robbert.username
  #   role     = "maintainer"
  # }

  members {
    username = data.github_user.ali-kadhim.username
  }
}

resource "github_team_members" "kernteam-committer" {
  team_id = github_team.kernteam-committer.id

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.robbert.username
    role     = "maintainer"
  }

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.yolijn.username
    role     = "maintainer"
  }

  members {
    username = data.github_user.hidde.username
  }

  members {
    username = data.github_user.matijs.username
  }

  members {
    username = data.github_user.bddjong.username
  }

  members {
    username = data.github_user.wartburggraaf.username
  }

  members {
    username = data.github_user.jeffreylauwers.username
  }

  members {
    username = data.github_user.rianrietveld.username
  }

  members {
    username = data.github_user.rozerin.username
  }

  members {
    username = data.github_user.nl-design-system-committer.username
  }
}

resource "github_team_members" "kernteam-maintainer" {
  team_id = github_team.kernteam-maintainer.id

  members {
    username = data.github_user.robbert.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }

  members {
    username = data.github_user.hidde.username
  }

  members {
    username = data.github_user.matijs.username
  }

  members {
    username = data.github_user.yolijn.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }
}

resource "github_team_members" "kernteam-triage" {
  team_id = github_team.kernteam-triage.id

  members {
    username = data.github_user.robbert.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }

  members {
    username = data.github_user.hidde.username
  }

  members {
    username = data.github_user.matijs.username
  }

  members {
    username = data.github_user.jeffreylauwers.username
  }

  members {
    username = data.github_user.yolijn.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }

  members {
    username = data.github_user.rianrietveld.username
  }

  members {
    username = data.github_user.renatenlds.username
  }

  members {
    username = data.github_user.peter-berrevoets.username
  }

  members {
    username = data.github_user.astrid-01.username
  }

  members {
    username = data.github_user.rozerin.username
  }

  members {
    username = data.github_user.wartburggraaf.username
  }
}

resource "github_team_members" "kernteam-dependabot" {
  team_id = github_team.kernteam-dependabot.id

  members {
    username = data.github_user.robbert.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }

  members {
    username = data.github_user.matijs.username
  }
}

resource "github_team_members" "logius-committer" {
  team_id = github_team.logius-committer.id

  members {
    username = data.github_user.aline-nap.username
  }

  members {
    username = data.github_user.raoul-wittenberns.username
  }

  members {
    username = data.github_user.remy-parzinski.username
  }

  members {
    username = data.github_user.jaap-hein-wester.username
  }
}

resource "github_team_members" "logius-maintainer" {
  team_id = github_team.logius-maintainer.id

  members {
    username = data.github_user.aline-nap.username
  }
}

resource "github_team_members" "gebruikersonderzoeken" {
  team_id = github_team.gebruikersonderzoeken.id

  members {
    username = data.github_user.jeroenduc.username
  }
}

resource "github_team_members" "tilburg-acato-committer" {
  team_id = github_team.tilburg-acato-committer.id

  members {
    username = data.github_user.acato-joost.username
  }

  members {
    username = data.github_user.acato-mark.username
  }

  members {
    username = data.github_user.acato-jorik-bosman.username
  }

  members {
    username = data.github_user.acato-cguijt.username
  }
}

resource "github_team_members" "tilburg-acato-maintainer" {
  team_id = github_team.tilburg-acato-maintainer.id

  members {
    username = data.github_user.acato-jorik-bosman.username
  }
}

resource "github_team_members" "tilburg-ditp-committer" {
  team_id = github_team.tilburg-ditp-committer.id

  members {
    username = data.github_user.hansregeer.username
  }

  members {
    username = data.github_user.nickditp.username
  }

  members {
    username = data.github_user.rberendsditp.username
  }

  members {
    username = data.github_user.daanditp.username
  }
}

resource "github_team_members" "blueriq-committer" {
  team_id = github_team.blueriq-committer.id

  members {
    username = data.github_user.Margot-UX.username
  }
}

resource "github_team_members" "blueriq-maintainer" {
  team_id = github_team.blueriq-maintainer.id

  members {
    username = data.github_user.Margot-UX.username
  }
}

resource "github_team_members" "rvo" {
  team_id = github_team.rvo.id

  members {
    username = data.github_user.robert-roose.username
  }
}

resource "github_team_members" "rvo-committer" {
  team_id = github_team.rvo-committer.id

  members {
    username = data.github_user.robert-roose.username
  }

  members {
    username = data.github_user.hoofdredactie.username
  }

  members {
    username = data.github_user.christopher1986.username
  }

  members {
    username = data.github_user.mlrfokken.username
  }

  members {
    username = data.github_user.r1kkert.username
  }

  members {
    username = data.github_user.jeroenschipper-dictu.username
  }
}

resource "github_team_members" "rvo-maintainer" {
  team_id = github_team.rvo-maintainer.id

  members {
    username = data.github_user.robert-roose.username
  }
}

resource "github_team_members" "rvo-estafettemodel" {
  team_id = github_team.rvo-estafettemodel.id

  members {
    username = data.github_user.robert-roose.username
  }
}

resource "github_team_members" "gemeente-utrecht-estafettemodel" {
  team_id = github_team.gemeente-utrecht-estafettemodel.id

  members {
    username = data.github_user.jeroenduc.username
  }

  members {
    username = data.github_user.rene-olling.username
  }
}

resource "github_team_members" "gemeente-amsterdam-estafettemodel" {
  team_id = github_team.gemeente-amsterdam-estafettemodel.id

  members {
    username = data.github_user.aram-limpens.username
  }

  members {
    username = data.github_user.niels-roozemond.username
  }

  members {
    username = data.github_user.vincent-smedinga.username
  }
}

resource "github_team_members" "logius-estafettemodel" {
  team_id = github_team.logius-estafettemodel.id

  members {
    username = data.github_user.aline-nap.username
  }

  members {
    username = data.github_user.remy-parzinski.username
  }
}

resource "github_team_members" "vng-services-committer" {
  team_id = github_team.vng-services-committer.id

  members {
    username = data.github_user.francesca.username
  }

  members {
    username = data.github_user.bddjong.username
  }
}

resource "github_team_members" "quintor-rijkshuisstijl-committer" {
  team_id = github_team.quintor-rijkshuisstijl-committer.id

  members {
    username = data.github_user.Rerbun.username
  }

  members {
    username = data.github_user.Rubenoo.username
  }

  members {
    username = data.github_user.sjimbonator.username
  }

  members {
    username = data.github_user.MeesD94.username
  }

  members {
    username = data.github_user.Aref-Akminasi.username
  }

  members {
    username = data.github_user.AdhamAH.username
  }

  members {
    username = data.github_user.GerwinTerpstra.username
  }

  members {
    username = data.github_user.veslav3.username
  }

  members {
    username = data.github_user.JoeriRoijenga.username
  }
}

resource "github_team_members" "quintor-rijkshuisstijl-maintainer" {
  team_id = github_team.quintor-rijkshuisstijl-maintainer.id

  members {
    username = data.github_user.Rerbun.username
  }
}

resource "github_team_members" "minjus-rijkshuisstijl-committer" {
  team_id = github_team.minjus-rijkshuisstijl-committer.id

  members {
    username = data.github_user.michaela-tan.username
  }
}

resource "github_team_members" "voorbeeld-theme-committer" {
  team_id = github_team.voorbeeld-theme-committer.id

  members {
    username = data.github_user.Dtacato.username
  }
}

resource "github_team_members" "icons-committer" {
  team_id = github_team.icons-committer.id

  members {
    username = data.github_user.martijnrietveld.username
  }
}
