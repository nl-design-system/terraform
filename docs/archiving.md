# Archiveren van een repository

Het archiveren van een repository gebeurt in 2 stappen.

1. Voeg het volgende toe aan de resource:
   ```tf
   archive_on_destroy = true
   ```

   Controleer ook of `prevent_destroy` staat ingesteld.  Zo ja, zet het dan uit.
   ```tf
   lifecycle {
     prevent_destroy = false
   }
   ```

   Zorg ervoor dat deze verandering(en) eerst worden gemerged met een PR.

2. Archiveer de repository door de betreffende configuration file (de `.tf`
   file) te verwijderen, en merge dit ook middels een PR.

   Refereer in de PR naar de vorige, om duidelijk te maken dat archiveren altijd
   uit twee stappen bestaat.
