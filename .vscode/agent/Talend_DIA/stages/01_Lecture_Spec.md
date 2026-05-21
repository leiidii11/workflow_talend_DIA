## Objective 
Lire le fichier spec depuis sharepoint 


## Instruction

### 1. Entrée
- L’utilisateur fournit le nom de l’onglet Excel à analyser.

### 2. Source de données
- Le fichier Excel se trouve à l’emplacement suivant :
  `C:\Users\marcelaa\ALPTIS\PRJ - Swing - 30 - Spécifications\Spécifications techniques DIA - Mapping.xlsx`

### 3. Utilisation de l’outil
- Utiliser obligatoirement le MCP `@excel-mcp` pour lire et extraire les données du fichier Excel.
- Ne jamais supposer ou reconstituer les données


### 5. Contraintes
- Ne pas inventer de valeurs manquantes.
- Conserver strictement les noms des colonnes tels qu’ils apparaissent dans le fichier.
- Si l’onglet demandé n’existe pas, retourner une erreur claire et arrêter le traitement.