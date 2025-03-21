# API Tokens

Terraform maakt gebruik van verschillende API tokens.

## GitHub Fine-grained Personal Access Token (PAT) genereren

1. Maak onder [Developer Settings/Personal access tokens][developer-settings]een
   nieuw token aan met de volgende permissies:
   - Repository permissions:
     - **Read** access to metadata.
     - **Read** and **Write** access to administration, code, and pages.
   - Organization permissions:
     - **Read** access to or organization administration.
     - **Read** and **Write** access to members.
1. Een custom expiration van 1 dag is voor lokaal gebruik meestal voldoende
   omdat hetzelfde token eenvoudig opnieuw te genereren is met een nieuwe
   expiration date. Het token dat door HCP Terraform (de cloud omgeving)
   gebruikt wordt, is een token met een geldigheid van een jaar.
1. Kopieer het token.

## Vercel API token genereren

1. Ga naar [Account Settings/Tokens][settings-tokens] in je Vercel account en
   log in indien nodig.
1. Maak een nieuw token aan:
   - Geef het een zinnige naam, bijvoorbeeld `NLDS Terraform` of
     `NLDS Terraform local`.
   - Selecteer `nl-design-system` als scope.
   - Gebruik een zinvolle expiration date. Voor lokaal gebruik is 1 dag vaak
     voldoende. Het token dat door HCP Terraform (de cloud omgeving) gebruikt
     wordt, is een token met een geldigheid van een half jaar.
1. Kopieer het token.

## API tokens gebruiken bij HCP Terracloud

1. Ga naar [Workspaces/Variables][workspaces-variables]
1. Werk het betreffende token `VERCEL_API_TOKEN`, `GITHIB_TOKEN`, of
   `PLESK_UUID_TOKEN` bij.
   - Plak onder `value` het token dat je gekopieerd hebt.
   - Werk de description bij zodat duidelijk is hoe lang het token gebruikt kan
     worden.

## API tokens gebruiken op de command line

## Inloggen met Terraform

Zorg dat je in je browser bent ingelogd bij
[terraform](https://app.terraform.io).

In je terminal moet je ook inloggen, dat doe je zo.

```shell
$ terraform login
Terraform will request an API token for app.terraform.io using your browser.

If login is successful, Terraform will store the token in plain text in
the following file for use by subsequent commands:
    /Users/{user}/.terraform.d/credentials.tfrc.json

Do you want to proceed?
  Only 'yes' will be accepted to confirm.

  Enter a value:
```

Antwoord met `yes` voluit geschreven. In je browser kom je hierna terecht op een
pagina om een token te genereren.

> !WARNING: Het is verstandig om daarna dat venster of die tab te sluiten omdat
> de HCP Terraform web applicatie anders steeds opnieuw het dialoogje laat zien
> om een token te generen.

Geef het token een zinvolle naam, bijvoorbeeld “Terraform (naam van je
computer)”, en een zinvolle houdbaarheidsdatum.

Terraform laat het token zien met een kopieerknop. Kopieer het token en plak het
in je terminal achter de prompt `Enter a value:`.

```shell
---------------------------------------------------------------------------------

Terraform must now open a web browser to the tokens page for app.terraform.io.

If a browser does not open this automatically, open the following URL to proceed:
    https://app.terraform.io/app/settings/tokens?source=terraform-login


---------------------------------------------------------------------------------

Generate a token using your browser, and copy-paste it into this prompt.

Terraform will store the token in plain text in the following file
for use by subsequent commands:
    /Users/{user}/.terraform.d/credentials.tfrc.json

Token for app.terraform.io:
  Enter a value:


Retrieved token for user {user}
```

Terraform geeft hierna als het goed is aan dat het inloggen is gelukt.

Om de terraform commandline client goed te laten werken moeten de volgende
variabelen beschikbaar zijn in de shell die je daarvoor gebruikt. Je kunt ze
daarvoor exportere maar het is ook mogelijk om ze voor het `terraform` commando
te zetten. Dat ziet er zo uit.

```shell
# begin het volgende commando's met een spatie zodat het niet terecht komt in de history
$  env TF_VAR_GITHUB_TOKEN={GitHub PAT} TF_VAR_PLESK_UUID_TOKEN={Plesk UUID token} TF_VAR_VERCEL_API_TOKEN={token} \
> terraform [global options] <subcommand> [args]
```

[developer-settings]: https://github.com/settings/personal-access-tokens/
[settings-tokens]: https://vercel.com/account/settings/tokens
[workspaces-variables]: https://app.terraform.io/app/nl-design-system/workspaces/github/variables
