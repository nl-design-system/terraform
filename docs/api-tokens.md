# API Tokens

Terraform maakt gebruik van verschillende API tokens.

## Een GitHub Fine-grained Personal Access Token (PAT) genereren

1. Ga bij GitHub naar [Developer Settings/Personal access tokens][github-developer-settings] en log in als dat nodig is.
1. Maak een nieuw token aan (het kan zijn dat je (nogmaals) met 2-factor authenticatie moet bevestigen):
   - Geef het token een zinnige naam, bijvoorbeeld `NLDS Terraform` voor cloud-gebruik of `NLDS Terraform local` voor
     lokaal gebruik op de command line.
   - Kies `nl-design-system` onder ‘Resource owner’.
   - Geef het token toegang tot `All repositories`.
   - Geef het token de volgende ‘Repository permissions’:
     - **Read** access tot 'Metadata' (deze permissie is default en niet aan te passen).
     - **Read** and **Write** access tot ‘Administration’, ‘Contents’, en ‘Pages’.
   - Geef het token de volgende ‘Organization permissions’:
     - **Read** access tot ‘Administration’.
     - **Read** and **Write** access tot ‘Members’.
1. Gebruik een zinvolle expiration. Een custom expiration van 1 dag is voor lokaal gebruik vaak voldoende omdat
   hetzelfde token eenvoudig opnieuw te genereren is met een nieuwe expiration date. Voor het token dat door HCP
   Terraform (de cloud omgeving) gebruikt wordt, is een token met een custom expiration date tot het eind van de
   beheerovereenkomst een goede keuze.
1. Kopieer het token.

## Een Vercel API token genereren

1. Ga bij Vercel naar [Account Settings/Tokens][vercel-settings-tokens] en log in als dat nodig is.
1. Maak een nieuw token aan:
   - Geef het een zinnige naam, bijvoorbeeld `NLDS Terraform` voor cloud-gebruik of `NLDS Terraform local` voor lokaal
     gebruik op de command line.
   - Selecteer `nl-design-system` als scope.
   - Gebruik een zinvolle expiration date. Voor lokaal gebruik is 1 dag vaak voldoende. Voor HCP Terraform (de cloud
     omgeving), is een token met een geldigheid van één jaar een goede keuze mits die datum voor het eind van de
     beheerovereenkomst is, anders is 180 dagen de betere optie.
1. Kopieer het token.

## API tokens gebruiken bij HCP Terracloud

1. Ga bij HCP Terraform naar [Workspaces/Variables][terraform-workspaces-variables]
1. Werk het betreffende token `VERCEL_API_TOKEN`, `GITHIB_TOKEN`, of `PLESK_UUID_TOKEN` bij.
   - Vul bij ‘Key’ de naam van het token in.
   - Plak onder ‘Value’ het token dat je gekopieerd hebt.
   - Geef aan dat het om een ‘sensitive’ token gaat.
   - Werk de ‘Description’ bij zodat duidelijk is waar en door wie het token gegenereerd is en hoe lang het gebruikt kan
     worden.

## API tokens gebruiken op de command line

Zorg dat je in je browser bent ingelogd bij [terraform](https://app.terraform.io).

In je terminal moet je ook inloggen, dat doe je zo.

```shell
terraform login
```

Resultaat:

```plaintext
Terraform will request an API token for app.terraform.io using your browser.

If login is successful, Terraform will store the token in plain text in
the following file for use by subsequent commands:
    /Users/{user}/.terraform.d/credentials.tfrc.json

Do you want to proceed?
  Only 'yes' will be accepted to confirm.

  Enter a value:
```

Antwoord met `yes` voluit geschreven. In je browser kom je hierna terecht op een pagina om een token te genereren.

> [!WARNING]  
> Het is verstandig om daarna dat venster of die tab te sluiten omdat de HCP Terraform web applicatie anders steeds
> opnieuw het dialoogje laat zien om een token te generen.

Geef het token een zinvolle naam, bijvoorbeeld “Terraform (naam van je computer)”, en een zinvolle houdbaarheidsdatum.

Terraform laat het token zien met een kopieerknop. Kopieer het token en plak het in je terminal achter de prompt
`Enter a value:`.

Resultaat:

```plaintext
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

Om de terraform commandline client goed te laten werken moeten de volgende environment variabelen beschikbaar zijn in de
shell die je daarvoor gebruikt. Je kunt de environment variabelen exporteren maar het is ook mogelijk om ze voor het
`terraform` commando te zetten. Dat ziet er zo uit.

> [!WARNING]  
> begin het volgende commando met een spatie zodat de tokens niet terecht komen in de history van je shell.

```shell
 env \
  TF_VAR_GITHUB_TOKEN={GitHub PAT} \
  TF_VAR_VERCEL_API_TOKEN={Vercel API token} \
  TF_VAR_PLESK_UUID_TOKEN=1 \
  terraform [global options] <subcommand> [args]
```

We gebruiken `TF_VAR_PLESK_UUID_TOKEN=1` als dummy omdat Terraform een waarde verwacht. De variabele wordt niet gebruikt
bij het gebruik van Terraform op de command line.

[github-developer-settings]: https://github.com/settings/personal-access-tokens/
[vercel-settings-tokens]: https://vercel.com/account/settings/tokens
[terraform-workspaces-variables]: https://app.terraform.io/app/nl-design-system/workspaces/github/variables
