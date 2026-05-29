## Objective
Valider et initialiser la configuration utilisateur avant toute exécution du workflow.

## Instruction

### 1. Fichier de configuration attendu
- Chemin: `.talend-config.json`
- Structure de base: `talend-config.template.json`

### 2. Vérification d'existence
1. Vérifier si le fichier `.talend-config.json` existe.
2. S'il n'existe pas:
   - STOP temporaire
   - Poser les questions à l'utilisateur une par une, afin de récuperer la valeur de chaque variable.
   - Créer le fichier de config en reprenant la structure du template.
   - Demander confirmation explicite avant de continuer le workflow.

### 3. Vérification de complétude
1. Lire le fichier de config.
2. Pour chaque clé manquante ou vide:
   - Poser uniquement la question liée à cette clé (une seule question à la fois).
   - Mettre à jour le fichier de config.
3. Demander confirmation explicite avant de continuer le workflow.

### 4. Chargement runtime automatique (sans mapping manuel)
1. Charger toutes les clés non vides du JSON en variables runtime.
2. Appliquer une règle générique de résolution:
   - toute clé JSON `NOM_CLE` est automatiquement disponible comme placeholder `{{NOM_CLE}}`.
3. Si un placeholder `{{...}}` est utilisé dans le workflow mais absent du JSON:
   - STOP
   - expliquer la clé manquante
   - poser la question correspondante
   - mettre à jour `talend-config.json`
   - relancer la résolution des placeholders avant de continuer.

### 5. Garde-fous
- Ne jamais inventer de valeurs.
- Ne pas continuer tant qu'une clé obligatoire est absente ou vide.
- Ne pas exposer les chemins locaux dans les sorties finales.
- Ne jamais proposer de commit du fichier `talend-config.json`.