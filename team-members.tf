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
}
