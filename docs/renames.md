# "Renames" in dit repository

> [!WARNING]  
> Renames zijn lastig. Controleer altijd in de Terraform Cloud omgeving of de wijzigingen die Terraform wil doorvoeren
> ook de wijzigingen zijn die je zou verwachten. Wees je er ook van bewust dat er verschil kan zitten tussen een
> **Plan** en een **Apply**.

## Bestanden hernoemen

Het hernoemen van een Terraform bestand (met de `.tf` extensie) is de eenvoudigste soort naamswijziging. Het is slechts
een Git operatie geen effect op Terraform heeft.

```shell
git mv path/to/old-file.tf path/to/new-file.tf
```

Een Pull Request voor deze wijziging resulteert in een **Plan** zonder wijzigingen. Het mergen van deze Pull Request
resulteert daardoor in het overslaan van de **Apply** stap.

> [!WARNING]  
> Als je in de Terraform Cloud omgeving in je plan ziet dat er toch wijzigingen zullen worden doorgevoerd heb je
> misschien ergens iets over het hoofd gezien. Kijk ook bij dit soort Pull Requests altijd in de Terraform Cloud
> omgeving of wat je daar ziet overeenkomt met wat je verwacht te zien.

## Een GitHub repository hernoemen

Om een GitHub repository te hernoemen moet het `name` argument van de betreffende `github_repository` resource aangepast
worden. Verander:

```HCL
resource "github_repository" "voorbeeld" {
  name = "voorbeeld"
  # …
}
```

Naar:

```HCL
resource "github_repository" "voorbeeld" {
  name = "nieuwe-naam"
  # …
}
```

Een Pull Request voor deze wijziging resulteert in een **Plan** met alleen een zogenaamde 'in-place' wijziging waarbij
de naam van de repository verandert. Het mergen van de pull request zorgt voor een **Apply** waarbij de naamswijziging
van de repository daadwerkelijk wordt doorgevoerd.

> [!WARNING]  
> Als je in de Terraform Cloud omgeving in je plan ziet dat er andere dan 'in-place' wijzigingen zullen worden
> doorgevoerd heb je misschien ergens iets over het hoofd gezien. Kijk daarom altijd in de Terraform Cloud omgeving of
> wat je daar ziet overeenkomt met wat je verwacht te zien.

## Een Terraform resource hernoemen

Voor deze soort naamswijziging heb je [API tokens][api-tokens] nodig. Het hernoemen van een resource gebeurt in twee
stappen.

### 1. De Terraform state aanpassen

Voer de volgende commando's uit.

```shell
 env \
  TF_VAR_GITHUB_TOKEN="GitHub PAT" \
  TF_VAR_VERCEL_API_TOKEN="Vercel API token" \
  TF_VAR_PLESK_WEBHOOK_UUID=1 \
  terraform state mv "github_repository.voorbeeld" "github_repository.nieuwe-naam"
```

Houdt hierbij de Terraform Cloud omgeving in de gaten. Je zult zien dat bij het hernoemen de state gelocked wordt door
jouw user. Nadat de resource hernoemd is wordt deze lock weer vrijgegeven.

### 2. De naamsverandering in code doorvoeren

Nadat de Terraform state is aangepast zul je de code weer in lijn moeten brengen met die nieuwe state. Verander:

```HCL
resource "github_repository" "voorbeeld" {
  name = "voorbeeld"
  # …
}
```

Naar:

```HCL
resource "github_repository" "nieuwe-naam" {
  name = "voorbeeld"
  # …
}
```

> [!NOTE]  
> Deze naamswijziging heeft gevolgen elders in de code. Overal waarvoorheen `github_repository.voorbeeld` gebruikt werd
> zal je dit moeten aanpassen naar `github_repository.nieuwe-naam`.

Een pull request voor deze wijziging resulteert in een **plan** zonder wijzigingen. Het mergen van deze pull request
resulteert daardoor in het overslaan van de **apply** stap.
