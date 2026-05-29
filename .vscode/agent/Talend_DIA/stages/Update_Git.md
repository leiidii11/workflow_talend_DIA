## Objective
Mettre à jour le GitHub avec les nouveaux fichiers DDL et DML et Sequences et générer la commande MERGE


## Etape 1: Update GIT
### 1. Dossier cible
- Répertoire Git `{{GITHUB_REPO_DIR}}` 

### 2. Régles
- Si le fichier existe déjà dans le répertoire GIT proposer une version alternative par example `ddl_{{NOM_ONGLET_SPEC}}_v2.sql`

### 3. Actions Git
1. Se positionner sur la branche `dev`
2. Exécuter `git pull`
3. Copier le fichier DDL `ddl_{{NOM_ONGLET_SPEC}}.sql` et DML `dml_{{NOM_ONGLET_SPEC}}.sql` créés avant dans le dossier cible `{{GITHUB_REPO_DIR}}`
4. Copier le fichier sequences SI existe créés avant `{{NOM_ONGLET_SEQUENCE}}.sql` dans le dossier cible `{{GITHUB_REPO_DIR}}\SEQUENCES`
5. ⚠️ Ne pas exécuter le commit ni le push


------------------------------


## Etape 2: Générer la commande MERGE
## 1. Génération des commandes Git
Créer une seule commande `git checkout dev --` et ajouter les fichiers DDL et DML de manière séquentielle pour chaque valeur présente dans la séquence.

⚠️ Ne pas générer une commande `git checkout` par valeur.  
Tous les fichiers doivent être ajoutés dans la même commande, à la suite les uns des autres.


## 2. Règles de génération
### Si la valeur de la séquence existe
Ajouter les fichiers suivants :

```bash
"Databases/Schémas/DIA/ddl_<VALEUR>.sql"
"Databases/Schémas/DIA/dml_<VALEUR>.sql"
```

### Sinon
Utiliser `{{NOM_ONGLET_SPEC}}` :

```bash
"Databases/Schémas/DIA/ddl_{{NOM_ONGLET_SPEC}}.sql"
"Databases/Schémas/DIA/dml_{{NOM_ONGLET_SPEC}}.sql"
```


#### Stockage fichier DML
- Nommer le fichier selon la convention:  `git_{{NOM_ONGLET_SEQUENCE}}.txt`
- Enregistrer le fichier dans le dossier : `SEQUENCES/GIT/`