resource "github_team_members" "frameless" {
  team_id = github_team.frameless.id

  members {
    username = data.github_user.AliKdhim87.username
  }

  members {
    username = data.github_user.savitris.username
  }

  members {
    username = data.github_user.bddjong.username
  }

  members {
    username = data.github_user.MeesoPost.username
  }

  members {
    username = data.github_user.Marwaxhello.username
  }

  members {
    username = data.github_user.TessaViergever.username
  }
}

resource "github_team_members" "frameless-maintainer" {
  team_id = github_team.frameless-maintainer.id

  # Disable Yolijn and Robbert from Frameless maintainer team,
  # while they have conflicting roles with more permissions in nl-design-system/kernteam.

  # members {
  #   username = data.github_user.Yolijn.username
  #   role     = "maintainer"
  # }

  # members {
  #   username = data.github_user.Robbert.username
  #   role     = "maintainer"
  # }

  members {
    username = data.github_user.AliKdhim87.username
  }
}

resource "github_team_members" "kernteam-committer" {
  team_id = github_team.kernteam-committer.id

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.Robbert.username
    role     = "maintainer"
  }

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.Yolijn.username
    role     = "maintainer"
  }

  members {
    username = data.github_user.jeffreylauwers.username
  }

  members {
    username = data.github_user.Rozerinay.username
  }

  members {
    username = data.github_user.eslook.username
  }

  members {
    username = data.github_user.nl-design-system-committer.username
  }

  members {
    username = data.github_user.petergoes.username
  }

  members {
    username = data.github_user.RenateRoke.username
  }

  members {
    username = data.github_user.veslav3.username
  }

  members {
    username = data.github_user.richadr.username
  }

  members {
    username = data.github_user.JuliaTol-properaccess.username
  }
}

resource "github_team_members" "kernteam-maintainer" {
  team_id = github_team.kernteam-maintainer.id

  members {
    username = data.github_user.Robbert.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }

  members {
    username = data.github_user.eslook.username
  }

  members {
    username = data.github_user.petergoes.username
  }

  members {
    username = data.github_user.Yolijn.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }

  members {
    username = data.github_user.veslav3.username
  }

  members {
    username = data.github_user.richadr.username
  }
}

resource "github_team_members" "kernteam-triage" {
  team_id = github_team.kernteam-triage.id

  members {
    username = data.github_user.Robbert.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }

  members {
    username = data.github_user.jeffreylauwers.username
  }

  members {
    username = data.github_user.Yolijn.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }

  members {
    username = data.github_user.Astrid-01.username
  }

  members {
    username = data.github_user.Rozerinay.username
  }

  members {
    username = data.github_user.eslook.username
  }

  members {
    username = data.github_user.petergoes.username
  }

  members {
    username = data.github_user.veslav3.username
  }

  members {
    username = data.github_user.sdejong570.username
  }

  members {
    username = data.github_user.nl-design-system-backup.username
  }
}

resource "github_team_members" "kernteam-ci" {
  team_id = github_team.kernteam-ci.id

  members {
    username = data.github_user.nl-design-system-ci.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }
}

resource "github_team_members" "kernteam-dependabot" {
  team_id = github_team.kernteam-dependabot.id

  members {
    username = data.github_user.Robbert.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }
}

resource "github_team_members" "kernteam-a11y" {
  team_id = github_team.kernteam-a11y.id

  members {
    username = data.github_user.RenateRoke.username
  }

  members {
    username = data.github_user.Robbert.username
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    role = "maintainer"
  }
}

resource "github_team_members" "kernteam-design" {
  team_id = github_team.kernteam-design.id

  members {
    username = data.github_user.jeffreylauwers.username
  }

  members {
    username = data.github_user.Rozerinay.username
  }
}

resource "github_team_members" "logius-triage" {
  team_id = github_team.logius-triage.id

  members {
    username = data.github_user.AlineNap.username
  }

  members {
    username = data.github_user.RNieuwerf.username
  }
}

resource "github_team_members" "logius-committer" {
  team_id = github_team.logius-committer.id

  members {
    username = data.github_user.AlineNap.username
  }

  members {
    username = data.github_user.rwittenberns.username
  }

  members {
    username = data.github_user.VladAfanasev.username
  }

  members {
    username = data.github_user.MMeijerink.username
  }

  members {
    username = data.github_user.MrGowdy.username
  }

  members {
    username = data.github_user.Kippetje.username
  }

  members {
    username = data.github_user.edblocker.username
  }

  members {
    username = data.github_user.dineshduggal.username
  }

  members {
    username = data.github_user.hvgeertruy.username
  }

  members {
    username = data.github_user.Sanderoost.username
  }

  members {
    username = data.github_user.RNieuwerf.username
  }

  members {
    username = data.github_user.jandekkerr.username
  }

  members {
    username = data.github_user.Floor-Gro.username
  }

  members {
    username = data.github_user.patrickoat.username
  }

  members {
    username = data.github_user.FinnWard.username
  }

  members {
    username = data.github_user.ruurdv.username
  }

  members {
    username = data.github_user.cascassette.username
  }

  members {
    username = data.github_user.mikenicolaes.username
  }

  members {
    username = data.github_user.SabineMeijerNuboer.username
  }

  members {
    username = data.github_user.rnacken.username
  }

  members {
    username = data.github_user.gzeilstra.username
  }

  members {
    username = data.github_user.berryskoop.username
  }

  members {
    username = data.github_user.NeslihanUTUK.username
  }

  members {
    username = data.github_user.JesseLogius.username
  }

  members {
    username = data.github_user.romy-petitjean-logius.username
  }

  members {
    username = data.github_user.DorineLogius.username
  }

  members {
    username = data.github_user.BabsyBabs83.username
  }
}

resource "github_team_members" "logius-maintainer" {
  team_id = github_team.logius-maintainer.id

  members {
    username = data.github_user.cascassette.username
  }

  members {
    username = data.github_user.FinnWard.username
  }
}

resource "github_team_members" "gebruikersonderzoeken" {
  team_id = github_team.gebruikersonderzoeken.id

  members {
    username = data.github_user.JeroenduC.username
  }
}

resource "github_team_members" "tilburg-acato-committer" {
  team_id = github_team.tilburg-acato-committer.id

  members {
    username = data.github_user.joostacato.username
  }

  members {
    username = data.github_user.markacato.username
  }

  members {
    username = data.github_user.jorik-acato.username
  }

  members {
    username = data.github_user.cguijt.username
  }
}

resource "github_team_members" "gemeente-den-haag-maintainer" {
  team_id = github_team.gemeente-den-haag-maintainer.id

  members {
    username = data.github_user.Borai.username
  }

  members {
    username = data.github_user.YourivHDenHaag.username
  }
}

resource "github_team_members" "gemeente-denhaag-acato-committer" {
  team_id = github_team.gemeente-denhaag-acato-committer.id

  members {
    username = data.github_user.marcoderover.username
  }

  members {
    username = data.github_user.paulAcato.username
  }

  members {
    username = data.github_user.richardkorthuis.username
  }

  members {
    username = data.github_user.merelacato.username
  }

  members {
    username = data.github_user.razjar.username
  }

  members {
    username = data.github_user.FrankaBeekman.username
  }

  members {
    username = data.github_user.ZencakeTheBob.username
  }
}

resource "github_team_members" "tilburg-maintainer" {
  team_id = github_team.tilburg-maintainer.id

  members {
    username = data.github_user.banaan666.username
  }

  members {
    username = data.github_user.Tim-van-Oudheusden.username
  }
}

resource "github_team_members" "tilburg-acato-maintainer" {
  team_id = github_team.tilburg-acato-maintainer.id

  members {
    username = data.github_user.jorik-acato.username
  }
}

resource "github_team_members" "tilburg-ditp-committer" {
  team_id = github_team.tilburg-ditp-committer.id

  members {
    username = data.github_user.hansregeer.username
  }

  members {
    username = data.github_user.NickDITP.username
  }

  members {
    username = data.github_user.RberendsDITP.username
  }

  members {
    username = data.github_user.daanditp.username
  }

  members {
    username = data.github_user.Lveditp.username
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
    username = data.github_user.rroose-rvo.username
  }

  members {
    username = data.github_user.sushitommy.username
  }
}

resource "github_team_members" "rvo-committer" {
  team_id = github_team.rvo-committer.id

  members {
    username = data.github_user.rroose-rvo.username
  }

  members {
    username = data.github_user.sushitommy.username
  }

  members {
    username = data.github_user.hoofdredactie.username
  }

  members {
    username = data.github_user.christopher1986.username
  }

  members {
    username = data.github_user.MLRFokken.username
  }

  members {
    username = data.github_user.r1kkert.username
  }

  members {
    username = data.github_user.jeroenschipper-dictu.username
  }

  members {
    username = data.github_user.PLassche-dictu.username
  }

  members {
    username = data.github_user.chelly-dictu.username
  }

  members {
    username = data.github_user.ramonitor.username
  }

  members {
    username = data.github_user.jaseterhaar.username
  }
  members {
    username = data.github_user.dhprins89.username
  }
  members {
    username = data.github_user.PhamNguyenNL.username
  }
  members {
    username = data.github_user.MartijndeLanghDictu.username
  }
  members {
    username = data.github_user.fKasteleinDictu.username
  }
}

resource "github_team_members" "rvo-maintainer" {
  team_id = github_team.rvo-maintainer.id

  members {
    username = data.github_user.rroose-rvo.username
  }
}

resource "github_team_members" "rvo-estafettemodel" {
  team_id = github_team.rvo-estafettemodel.id

  members {
    username = data.github_user.rroose-rvo.username
  }
}

resource "github_team_members" "gemeente-utrecht-maintainer" {
  team_id = github_team.gemeente-utrecht-maintainer.id

  members {
    username = data.github_user.JeroenduC.username
  }

  members {
    username = data.github_user.Ollie-nl.username
  }

  members {
    username = data.github_user.pixelgitter.username
  }
}

resource "github_team_members" "gemeente-utrecht-estafettemodel" {
  team_id = github_team.gemeente-utrecht-estafettemodel.id

  members {
    username = data.github_user.JeroenduC.username
  }

  members {
    username = data.github_user.Ollie-nl.username
  }
}

resource "github_team_members" "gemeente-amsterdam-estafettemodel" {
  team_id = github_team.gemeente-amsterdam-estafettemodel.id

  members {
    username = data.github_user.alimpens.username
  }

  members {
    username = data.github_user.dlnr.username
  }

  members {
    username = data.github_user.VincentSmedinga.username
  }
}

resource "github_team_members" "logius-estafettemodel" {
  team_id = github_team.logius-estafettemodel.id

  members {
    username = data.github_user.AlineNap.username
  }
}

resource "github_team_members" "vng-services-committer" {
  team_id = github_team.vng-services-committer.id

  members {
    username = data.github_user.ux-fran.username
  }

  members {
    username = data.github_user.bddjong.username
  }

  members {
    username = data.github_user.AliKdhim87.username
  }

  members {
    username = data.github_user.TessaViergever.username
  }
}

resource "github_team_members" "vng-services-maintainer" {
  team_id = github_team.vng-services-maintainer.id

  members {
    username = data.github_user.bddjong.username
  }
}

resource "github_team_members" "quintor-rijkshuisstijl-committer" {
  team_id = github_team.quintor-rijkshuisstijl-committer.id

  members {
    username = data.github_user.Ruben-Smit.username
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
    username = data.github_user.JoeriRoijenga.username
  }

  members {
    username = data.github_user.sjimbonator.username
  }

  members {
    username = data.github_user.JanAbe.username
  }

  members {
    username = data.github_user.GerwinTerpstra.username
  }
}

resource "github_team_members" "quintor-rijkshuisstijl-maintainer" {
  team_id = github_team.quintor-rijkshuisstijl-maintainer.id

  members {
    username = data.github_user.Ruben-Smit.username
  }

  members {
    username = data.github_user.AdhamAH.username
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

resource "github_team_members" "gemeente-almere-committer" {
  team_id = github_team.gemeente-almere-committer.id

  members {
    username = data.github_user.catrinairankhah.username
  }
}

resource "github_team_members" "nora-committer" {
  team_id = github_team.nora-committer.id

  members {
    username = data.github_user.RGRMdesign.username
  }
}

resource "github_team_members" "tiptap-committer" {
  team_id = github_team.tiptap-committer.id

  members {
    username = data.github_user.AliKdhim87.username
  }

  members {
    username = data.github_user.ZwaarContrast.username
  }

  members {
    username = data.github_user.StephanMeijer.username
  }
}

resource "github_team_members" "rivm-committer" {
  team_id = github_team.rivm-committer.id

  members {
    username = data.github_user.Patricia-de-vos.username
  }
}

resource "github_team_members" "rivm-maintainer" {
  team_id = github_team.rivm-maintainer.id

  members {
    username = data.github_user.josvanderzalm.username
  }
}

resource "github_team_members" "gemeente-rotterdam-triage" {
  team_id = github_team.gemeente-rotterdam-triage.id

  members {
    username = data.github_user.bartheijs.username
  }
}

resource "github_team_members" "gemeente-rotterdam-committer" {
  team_id = github_team.gemeente-rotterdam-committer.id

  members {
    username = data.github_user.fiemke.username
  }

  members {
    username = data.github_user.keesvandieren.username
  }

  members {
    username = data.github_user.jstuyts.username
  }

  members {
    username = data.github_user.RicoRobinson.username
  }

  members {
    username = data.github_user.aiden-sjeefr.username
  }
}

resource "github_team_members" "gemeente-rotterdam-maintainer" {
  team_id = github_team.gemeente-rotterdam-maintainer.id

  members {
    username = data.github_user.LeonVanEe.username
  }
}

resource "github_team_members" "gemeente-groningen" {
  team_id = github_team.gemeente-groningen.id

  members {
    username = data.github_user.MariekeBrouwer.username
  }

  members {
    username = data.github_user.hendrik-boerma.username
  }
}

resource "github_team_members" "gemeente-groningen-maintainer" {
  team_id = github_team.gemeente-groningen-maintainer.id

  members {
    username = data.github_user.MariekeBrouwer.username
  }
}

resource "github_team_members" "gemeente-zaanstad" {
  team_id = github_team.gemeente-zaanstad.id

  members {
    username = data.github_user.Michiel-KeenDesign.username
  }
}

resource "github_team_members" "keen-design-maintainer" {
  team_id = github_team.keen-design-maintainer.id

  members {
    username = data.github_user.Michiel-KeenDesign.username
  }
}

resource "github_team_members" "community-committer" {
  team_id = github_team.community-committer.id

  # Quintor folks
  members {
    username = data.github_user.Ruben-Smit.username
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
    username = data.github_user.JoeriRoijenga.username
  }

  members {
    username = data.github_user.sjimbonator.username
  }

  members {
    username = data.github_user.JanAbe.username
  }

  members {
    username = data.github_user.GerwinTerpstra.username
  }

  # Frameless folks

  members {
    username = data.github_user.AliKdhim87.username
  }

  members {
    username = data.github_user.savitris.username
  }

  members {
    username = data.github_user.bddjong.username
  }

  members {
    username = data.github_user.MeesoPost.username
  }

  members {
    username = data.github_user.Marwaxhello.username
  }

  members {
    username = data.github_user.TessaViergever.username
  }

  # Utrecht folks

  members {
    username = data.github_user.JeroenduC.username
  }

  members {
    username = data.github_user.Ollie-nl.username
  }

  members {
    username = data.github_user.dineshduggal.username
  }

  members {
    username = data.github_user.BabsyBabs83.username
  }

  # Den Haag folks
  members {
    username = data.github_user.jiromaykin.username
  }

  # Kernteam alumni
  members {
    username = data.github_user.erikkroes.username
  }

  members {
    username = data.github_user.hidde.username
  }

  # Leiden folks
  members {
    username = data.github_user.LeidscheJurgen.username
  }

  members {
    username = data.github_user.WinsleyJ.username
  }

  members {
    username = data.github_user.webmaster-leiden-nl.username
  }

  # Expertteam Digitale Toegankelijkheid folks
  members {
    username = data.github_user.huijkman.username
  }

  members {
    username = data.github_user.jurgenbelien.username
  }

  members {
    username = data.github_user.hilhorstt.username
  }

  members {
    username = data.github_user.bartveneman.username
  }

  members {
    username = data.github_user.julezrulez.username
  }

  members {
    username = data.github_user.ermenm.username
  }
}

resource "github_team_members" "expertteam-digitale-toegankelijkheid-triage" {
  team_id = github_team.expertteam-digitale-toegankelijkheid-triage.id

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.Robbert.username
    role     = "maintainer"
  }

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.Yolijn.username
    role     = "maintainer"
  }

  members {
    username = data.github_user.huijkman.username
  }

  members {
    username = data.github_user.Astrid-01.username
  }

  members {
    username = data.github_user.pibl.username
  }

  members {
    username = data.github_user.nl-design-system-backup.username
  }
}

resource "github_team_members" "expertteam-digitale-toegankelijkheid-committer" {
  team_id = github_team.expertteam-digitale-toegankelijkheid-committer.id

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.Robbert.username
    role     = "maintainer"
  }

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.Yolijn.username
    role     = "maintainer"
  }

  members {
    username = data.github_user.huijkman.username
  }

  members {
    username = data.github_user.jurgenbelien.username
  }

  members {
    username = data.github_user.hilhorstt.username
  }

  members {
    username = data.github_user.bartveneman.username
  }

  members {
    username = data.github_user.julezrulez.username
  }

  members {
    username = data.github_user.ermenm.username
  }
}

resource "github_team_members" "expertteam-digitale-toegankelijkheid-maintainer" {
  team_id = github_team.expertteam-digitale-toegankelijkheid-maintainer.id

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.Robbert.username
    role     = "maintainer"
  }

  members {
    # organization owners must be "maintainer", see note at https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members
    username = data.github_user.Yolijn.username
    role     = "maintainer"
  }

  members {
    username = data.github_user.pibl.username
  }

  members {
    username = data.github_user.huijkman.username
  }
}

resource "github_team_members" "expertteam-digitale-toegankelijkheid-infra" {
  team_id = github_team.expertteam-digitale-toegankelijkheid-infra.id

  members {
    username = data.github_user.bartjkdp.username
  }

  members {
    username = data.github_user.georgealpha9.username
  }

  members {
    username = data.github_user.iehkaatee.username
  }
}

resource "github_team_members" "developer_overheid_nl-committer" {
  team_id = github_team.developer_overheid_nl-committer.id

  members {
    username = data.github_user.MrSkippy.username
  }

  members {
    username = data.github_user.tomootes.username
  }
}

resource "github_team_members" "developer_overheid_nl-maintainer" {
  team_id = github_team.developer_overheid_nl-maintainer.id

  members {
    username = data.github_user.dvh.username
    role     = "maintainer"
  }
}

resource "github_team_members" "gemeente-voorne-aan-zee" {
  team_id = github_team.gemeente-voorne-aan-zee.id

  members {
    username = data.github_user.erikhendrikxaserio.username
  }
}

resource "github_team_members" "gemeente-voorne-aan-zee-aserio-maintainer" {
  team_id = github_team.gemeente-voorne-aan-zee-aserio-maintainer.id

  members {
    username = data.github_user.erikhendrikxaserio.username
  }
}
