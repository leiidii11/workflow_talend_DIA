## Objective
Générer le fichier sql pour lancer les DDL et DML en Séquences

## Instruction

### 1. Entrée
- L’utilisateur fournit le nom de l’onglet Excel de la séquence à analyser:  `{{NOM_ONGLET_SEQUENCE}}`

### 2. Source de données
- Le fichier Excel `{{SEQUENCES_NOM}}` se trouve à l’emplacement suivant :  `{{SHAREPOINT_SEQUENCES_PATH}}`

### 3. Utilisation de l’outil
- En utilisant @excel-mcp, Lire et extraire les données directement depuis le fichier Excel local indiqué.
- Ne jamais supposer ou reconstituer les données
- Ne JAMAIS modier le fichier en local

### 4. Géneration des sequences
- Générer la sequences (voir `stages/Génération_Sequences.md`)

### 5. Contraintes
- Ne pas inventer de valeurs manquantes.
- Conserver strictement les noms des colonnes tels qu’ils apparaissent dans le fichier.
- Si l’onglet demandé n’existe pas, retourner une erreur claire et arrêter le traitement.
