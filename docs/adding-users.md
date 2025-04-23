# GitHub Gebruikers toevoegen

## Een GitHub gebruiker toevoegen aan de NL Design System organisatie

Voeg een nieuwe `"github_user"` data source toe aan [`user.tf`](../user.tf):

```HCL
data "github_user" "Gebruikersnaam" {
  username = "Gebruikersnaam"
}
```

> [!WARNING]  
> Correct hoofdlettergebruik is essentieel. Bezoek eerst de profielpagina van de gebruiker op GitHub om te kijken hoe de
> gebruiker bij GitHub bekend is. Bijvoorbeeld: op de profile pagina van Yolijn https://github.com/yolijn gebruik je de
> niet-vetgedrukte naam, in dit geval ‘Yolijn’. Zorg ervoor dat het hoofdlettergebruik in de naam van de data source
> (`data "github_user" "Gebruikersnaam"`) en het argument (`username = "Gebruikersnaam"`) hetzelfde is.

## Een GitHub gebruiker toevoegen aan een team

Zoek de `"github_team_members"` resource van het team op in [`team-members.tf`](../team-members.tf):

```HCL
resource "github_team_members" "voorbeeld-team" {
  …
}
```

Voeg een extra `members` (meervoud) blok toe aan het team:

```HCL
resource "github_team_members" "voorbeeld-team" {
  team_id = github_team.voorbeeld-team.id

  …

  members {
    username = data.github_user.Gebruikersnaam.username
  }
}
```

Let ook hier op correct hoofdlettergebruik en vergeet de `.username` aan het eind van de regel niet.

> [!WARNING]  
> Als je een GitHub gebruiker wilt toevoegen aan de NL Design System organisatie en deze gebruiker ook meteen wilt
> opnemen in een team moet dat in 1 pull request.
