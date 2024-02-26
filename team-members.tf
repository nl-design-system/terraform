resource "github_team_members" "frameless-maintainer" {
  team_id = github_team.frameless-maintainer.id

  members {
    username = data.github_user.yolijn.username
  }

  members {
    username = data.github_user.robbert.username
  }
}
