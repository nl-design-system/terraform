# GitHub Rate Limits

Een min of meer ideale Terraform workflow ziet er ongeveer zo uit.

1. Je doet een (kleine) wijziging en maakt daarvan een pull request.
2. De pull request zorgt voor een Terraform “plan”, wat betekent dat er API-calls naar de GitHub API worden gedaan.
3. Na goedkeuring en het mergen van de pull request, wordt er opnieuw een Terraform “plan” uitgevoerd, gevolgd door een
   “apply”. Beide zorgen opnieuw voor API-calls naar de GitHub API.

In de praktijk ziet deze workflow er vaak rommeliger uit.

- Je wijziging bevat een fout die je oplost waarna je je branch bijwerkt.
- Degene die je pull request bekijkt en heeft nog een opmerking die je wilt verwerken.
- Het “plan“ werkt wel, maar de uiteindelijke “apply” toch niet wat betekent dat je waarschijnlijk snel een nieuwe pull
  request zult willen maken.

Soms is het een combinatie van bovenstaande of moet het zelfs meerdere malen gedaan worden. Dit kan betekenen dat er in
relatief korte tijd heel veel API-calls gedaan worden met als gevolg dat je de door GitHub bepaalde “rate limit”
overschrijdt en zult moeten wachten voor er nieuwe API-calls gemaakt kunnen worden. Zodra een “rate limit” overschreden
wordt faalt het dan lopende “plan” of de ”apply”.

Hoe dan ook is het cruciaal om na het mergen van een pull request te controleren of zowel het “plan” als de “apply”
succesvol zijn uitgevoerd.

## Hoe los je dit op?

In al de onderstaande voorbeelden is het van belang dat je eerst wacht. De standaard rate limiet van GitHub is 5.000
requests per uur.

### Een plan faalt terwijl je pull request nog niet gemerged is

In dit geval is de nieuwe state nog niet gemerged en klopt de werkelijkheid nog met de oude state. Wacht even en pas dan
lokaal de laatste commit van je branch aan met `git commit --amend --no-edit` gevolgd door `git push --force-with-lease`
om je branch te “force pushen”. Terraform zal dan gewoon opnieuw een “plan“ draaien.

### Een plan faalt nadat je pull request gemerged is

In dit geval is de nieuwe state wel gemerged maar klopt die niet meer met de werkelijkheid op GitHub. Wacht weer even en
gebruik dan de “+ New run” knop in de [HCP Terraform](https://app.terraform.io/) om vanuit de UI je “plan” gevolgd door
“apply” alsnog te draaien.
