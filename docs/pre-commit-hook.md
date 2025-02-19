# pre-commit hook

In dit repository is geen tooling aanwezig die het makkelijk maakt om automatisch git hooks te installeren. Maar het is natuurlijk altijd mogelijk om dit handmatig te doen.

Onderstaande `pre-commit` hook zorgt ervoor dat formatting issues of een terraform configuratie die niet valide is niet zo maar gecommit kunnen worden.

1. Sla het volgende shell script op in `.git/hooks/pre-commit`

   ```sh
   #!/usr/bin/env sh

   if ! result=$(terraform fmt -check -recursive); then
     printf "terraform formatting issues in:\n\n"
     printf "%s\n" "$result"
     exit 1
   fi

   if ! result=$(terraform validate); then
     printf "%s" "$result"
     exit 1
   fi

   unset result
   ```

1. Maak het bestand uitvoerbaar met:

   ```sh
   chmod +x .git/hooks/pre-commit
   ```
