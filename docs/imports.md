# Importeren met Terraform

Per repository worden de volgende resources met Terraform beheerd:

- `"github_repository"`, de repository zelf.
- `"github_branch_default"`, de default branch van de repository, meestal `main`.
- `"github_repository_ruleset"`, een ruleset om de default branch van de repository te beschermen.
- (optioneel) `"vercel_project"`, een Vercel project gekoppeld aan de repository.

> [!CAUTION]  
> Begin de opdrachten uit dit document die je in de terminal moet uitvoeren met een spatie zodat gevoelige informatie
> zoals tokens niet terecht komen in de history van je shell.

## Een GitHub repository importeren

1. Genereer een Vercel een API token[^1] en gebruik dit waar hieronder `{GitHub PAT}` staat.
1. Genereer een GitHub fine-grained personal access token[^2] en gebruik dit waar hieronder `{Vercel API token}` staat.
1. Maak een nieuwe resource `"github_repository"` aan, kies als naam de naam van de repository. Hieronder wordt
   "voorbeeld" gebruikt.
1. Gebruik bijvoorbeeld [`example.tf`](../example.tf) als sjabloon voor de resource.

```HCL
resource "github_repository" "voorbeeld" {
  name = "voorbeeld"
  …
}
```

Voer de volgende opdracht uit in de terminal.

```shell
 env \
  TF_VAR_GITHUB_TOKEN={GitHub PAT} \
  TF_VAR_VERCEL_API_TOKEN={Vercel API token} \
  TF_VAR_PLESK_UUID_TOKEN=1 \
  terraform import "github_repostory.{voorbeeld}" {voorbeeld}
```

> [!WARNING]  
> Zorg dat je GitHub account voldoende rechten heeft op de repository dat je wilt importeren. Je moet in elk geval bij
> `https://github.com/nl-design-system/{repo}/settings` kunnen anders zal het importeren niet werken.

Als het importeren is gelukt toont Terraform de volgende melding.

```plaintext
Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

Commit nu je wijzigingen, maak een PR aan en controleer of het plan overeenkomt met wat je geïmporteerd hebt.

### De default branch van een GitHub repository importeren

1. Genereer een Vercel een API token[^1] en gebruik dit waar hieronder `{GitHub PAT}` staat.
1. Genereer een GitHub fine-grained personal access token[^2] en gebruik dit waar hieronder `{Vercel API token}` staat.
1. Zoek in de settings van de repository op wat de naam van de default branch is. Hieronder `main`.
1. Maak een nieuwe resource `"github_branch_default"` aan.

```HCL
resource "github_branch_default" "voorbeeld" {
  repository = github_repository.voorbeeld.name
  branch     = "main"
}
```

Voer de volgende opdracht uit in de terminal.

```shell
 env \
  TF_VAR_GITHUB_TOKEN={GitHub PAT} \
  TF_VAR_VERCEL_API_TOKEN={Vercel API token} \
  TF_VAR_PLESK_UUID_TOKEN=1 \
  terraform import "github_branch_default.{voorbeeld}" {voorbeeld}
```

Als het importeren is gelukt toont Terraform de volgende melding.

```plaintext
Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

Commit nu je wijzigingen, maak een PR aan en controleer of het plan overeenkomt met wat je geïmporteerd hebt.

## Een GitHub repository ruleset importeren

1. Genereer een Vercel een API token[^1] en gebruik dit waar hieronder `{GitHub PAT}` staat.
1. Genereer een GitHub fine-grained personal access token[^2] en gebruik dit waar hieronder `{Vercel API token}` staat.
1. Zoek in de settings van de repository op wat het ID van de ruleset is.
   - Ga naar https://github.com/nl-design-system/{voorbeeld}/settings/rules (vervang `{voorbeeld}` met de naam van de
     repository).
   - Open de bestaande ruleset, het id is het laatste deel van de URL. Hieronder gebruiken we `{12345}`.
1. Maak een nieuwe resource `"github_repository_ruleset"` aan.
1. Gebruik bijvoorbeeld [`example.tf`](../example.tf) als sjabloon voor de resource.

```HCL
resource "github_repository_ruleset" "voorbeeld-main" {
  name       = "default-branch-protection"
  repository = github_repository.voorbeeld.name
  …
}
```

Voer de volgende opdracht uit in de terminal.

```shell
 env \
  TF_VAR_GITHUB_TOKEN={GitHub PAT} \
  TF_VAR_VERCEL_API_TOKEN={Vercel API token} \
  TF_VAR_PLESK_UUID_TOKEN=1 \
  terraform import "github_repository_ruleset.{voorbeeld}" {voorbeeld}:{12345}
```

Als het importeren is gelukt toont Terraform de volgende melding.

```plaintext
Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

Commit nu je wijzigingen, maak een PR aan en controleer of het plan overeenkomt met wat je geïmporteerd hebt.

## Een Vercel project importeren

1. Genereer een Vercel een API token[^1] en gebruik dit waar hieronder `{GitHub PAT}` staat.
1. Genereer een GitHub fine-grained personal access token[^2] en gebruik dit waar hieronder `{Vercel API token}` staat.
1. Ga bij Vercel naar [Overview][vercel-nl-design-system] en zoek of selecteer het project.
1. Kies op de project pagina voor ‘Settings’ en kopieer of noteer het ‘Project ID’ dat staat onder ‘General’. Het
   Project ID begint met `prj_`. Gebruik dit waar hieronder `{project ID}` staat.
1. Maak een nieuwe resource `"vercel_project"` aan.
1. Gebruik bijvoorbeeld [`gebruikersonderzoeken.tf`](../gebruikersonderzoeken.tf) als sjabloon voor de resource.

```HCL
resource "vercel_project" "voorbeeld" {
  name = "voorbeeld"
  …

  git_repository = {
    type = "github"
    repo = github_repository.voorbeeld.full_name
  }
}
```

Voer de volgende opdracht uit in de terminal.

```shell
 env \
  TF_VAR_GITHUB_TOKEN={GitHub PAT} \
  TF_VAR_VERCEL_API_TOKEN={Vercel API token} \
  TF_VAR_PLESK_UUID_TOKEN=1 \
  terraform import "vercel_project.{voorbeeld}" {project ID}
```

Als het importeren is gelukt toont Terraform de volgende melding.

```plaintext
Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

Commit nu je wijzigingen, maak een PR aan en controleer of het plan overeenkomt met wat je geïmporteerd hebt.

[^1]: [Een vercel API token genereren](./api-tokens.md#een-vercel-api-token-genereren)
[^2]:
    [Een GitHub fine-grained personal access token (PAT) genereren](./api-tokens.md#een-github-fine-grained-personal-access-token-pat-genereren)

[vercel-nl-design-system]: https://vercel.com/nl-design-system/
