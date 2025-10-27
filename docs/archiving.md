# Archiveren van een repository

Het archiveren van een repository gebeurt in 2 stappen.

1. Voeg het volgende toe aan de resource:
   ```tf
   archive_on_destroy = true
   ```
   Zorg ervoor dat deze verandering eerst wordt gemerged met een PR.

2. Destroy de repository door de betreffende configuration file (de `.tf` file)
   te verwijderen, en merge dit ook middels een PR.

   Refereer in de PR naar de vorige, om duidelijk te maken dat archiveren altijd
   in twee stappen moet.
