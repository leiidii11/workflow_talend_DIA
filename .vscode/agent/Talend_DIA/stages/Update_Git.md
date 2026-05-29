## Objective
Mettre à jour le GitHub selon le mode exclusif d'execution et générer la commande MERGE


## Etape 1: Update GIT
### 1. Dossier cible
- Répertoire Git `{{GITHUB_REPO_DIR}}` 

### 2. Régles
- Si le fichier existe déjà dans le répertoire GIT proposer une version alternative par example `ddl_{{NOM_ONGLET_SPEC}}_v2.sql`

### 3. Actions Git
1. Se positionner sur la branche `dev`
2. Exécuter `git pull`
3. Appliquer les copies selon `{{EXECUTION_MODE}}`:
   - Si `TABLE_ONLY`:
     - Source : `TABLES/{{NOM_ONGLET_SPEC}}/ddl_{{NOM_ONGLET_SPEC}}.sql` → Destination : `{{GITHUB_REPO_DIR}}/ddl_{{NOM_ONGLET_SPEC}}.sql`
     - Source : `TABLES/{{NOM_ONGLET_SPEC}}/dml_{{NOM_ONGLET_SPEC}}.sql` → Destination : `{{GITHUB_REPO_DIR}}/dml_{{NOM_ONGLET_SPEC}}.sql`
   - Si `SEQUENCE_ONLY`:
     - Source : `SEQUENCES/{{NOM_ONGLET_SEQUENCE}}/{{NOM_ONGLET_SEQUENCE}}.sql` → Destination : `{{GITHUB_REPO_DIR}}/SEQUENCES/{{NOM_ONGLET_SEQUENCE}}.sql`
     - Créer le dossier `{{GITHUB_REPO_DIR}}/SEQUENCES/` s'il n'existe pas.
4. ⚠️ Interdit de copier les fichiers de l'autre mode.
5. ⚠️ Ne pas exécuter le commit ni le push


------------------------------


## Etape 2: Générer la commande MERGE
## 1. Génération des commandes Git
Créer une seule commande `git checkout dev --` et ajouter les fichiers DDL et DML de manière séquentielle pour chaque valeur présente dans la séquence.

⚠️ Ne pas générer une commande `git checkout` par valeur.  
Tous les fichiers doivent être ajoutés dans la même commande, à la suite les uns des autres.


## 2. Règles de génération
### Si `{{EXECUTION_MODE}} = SEQUENCE_ONLY` et la valeur de la séquence existe
Ajouter les fichiers suivants :

```bash
"Databases/Schémas/DIA/ddl_<VALEUR>.sql"
"Databases/Schémas/DIA/dml_<VALEUR>.sql"
```

### Si `{{EXECUTION_MODE}} = TABLE_ONLY`
Utiliser `{{NOM_ONGLET_SPEC}}` :

```bash
"Databases/Schémas/DIA/ddl_{{NOM_ONGLET_SPEC}}.sql"
"Databases/Schémas/DIA/dml_{{NOM_ONGLET_SPEC}}.sql"
```


#### Stockage fichier DML
- Nommer le fichier selon la convention:  `git_{{NOM_ONGLET_SEQUENCE}}.txt`
- Enregistrer le fichier dans le dossier : `SEQUENCES/GIT/`