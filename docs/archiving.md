# Archiveren van een repository

Het archiveren van een repository gebeurt in 2 stappen.

1. Voeg het volgende toe aan de resource:
   ```tf
   archive_on_destroy = true
   ```
   Zorg ervoor dat deze verandering met `terraform apply` wordt uitgevoerd.
2. Destroy de repository door de betreffende configuration file (de `.tf` file)
   te verwijderen, en apply deze ook.
