## Objective
Valider et initialiser la configuration utilisateur avant toute exécution du workflow.

## Instruction


## Configuration utilisateur obligatoire
- Fichier de configuration utilisateur : `talend-config.json` (JSON local par user)
- Le fichier contient les variables runtime existantes comme exemple dans `.vscode/agent/Talend_DIA/talend-config.template.json`


### 1. Fichier de configuration attendu
- Chemin: `.vscode/agent/Talend_DIA/talend-config.json`
- Structure de base: `.vscode/agent/Talend_DIA/talend-config.template.json`

### 2. Clés obligatoires
- `SHAREPOINT_SPEC_PATH`
- `WORKSPACE_DIR`
- `GITHUB_REPO_DIR`

### 3. Vérification d'existence
1. Vérifier si le fichier `.vscode/agent/Talend_DIA/talend-config.json` existe.
2. S'il n'existe pas:
   - STOP temporaire
   - Poser les questions à l'utilisateur une par une, dans cet ordre:
     1. Chemin spec SharePoint
     2. Dossier workspace
     3. Dossier repository Git DDL/DML
   - Créer le fichier de config en reprenant la structure du template.
   - Demander confirmation explicite avant de continuer le workflow.

### 4. Vérification de complétude
1. Lire le fichier de config.
2. Vérifier que les 3 clés obligatoires existent et ne sont pas vides.
3. Pour chaque clé manquante ou vide:
   - Poser uniquement la question liée à cette clé (une seule question à la fois).
   - Mettre à jour le fichier de config.
4. Demander confirmation explicite avant de continuer le workflow.

### 5. Garde-fous
- Ne jamais inventer de valeurs.
- Ne pas continuer tant qu'une clé obligatoire est absente ou vide.
- Ne pas exposer les chemins locaux dans les sorties finales.
- Ne jamais proposer de commit du fichier `talend-config.json`.