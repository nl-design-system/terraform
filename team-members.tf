resource "github_team_members" "frameless-maintainer" {
  team_id = github_team.frameless-maintainer.id

  # Disable Yolijn and Robbert from Frameless maintainer team,
  # while they have conflicting roles with more permissions in nl-design-system/kernteam.

  # members {
  #   username = data.github_user.yolijn.username
  # }

  # members {
  #   username = data.github_user.robbert.username
  # }

  members {
    username = data.github_user.ali-kadhim.username
  }
}

resource "github_team_members" "kernteam-committer" {
  team_id = github_team.kernteam-committer.id

  members {
    username = data.github_user.robbert.username
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
    username = data.github_user.yolijn.username
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


resource "github_team_members" "kernteam-triage" {
  team_id = github_team.kernteam-triage.id

  members {
    username = data.github_user.robbert.username
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
  team_id = github_team.tilburg.id

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
  team_id = github_team.tilburg.id

  members {
    username = data.github_user.acato-jorik-bosman.username
  }
}
