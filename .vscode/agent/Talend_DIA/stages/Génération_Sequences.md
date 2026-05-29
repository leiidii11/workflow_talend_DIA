# Objectif
Générer un unique script SQL permettant d’exécuter les DDL et DML dans l’ordre des séquences.

# Source des données
- Utiliser exclusivement les données de l’onglet SharePoint **Sequences** spécifié par l’utilisateur.
- Ne pas utiliser d’autres sources de données ni de valeurs implicites.

## Règle de lecture des colonnes
- La colonne utilisée dans le fichier Excel source est : `TABLE DIA`.

---

# Instructions

## 1. Génération du fichier SQL
Créer un seul fichier `.sql` contenant l’ensemble des commandes pour chaque valeur présente dans la colonne `TABLE DIA`.

### Structure du fichier SQL
- Le stage doit être créé une seule fois au début du script et supprimé à la fin.
```sql
CREATE OR REPLACE STAGE `{{NOM_USER}}` COMMENT = 'Stage interne pour les fichiers SQL de la séquence';

DROP STAGE IF EXISTS `{{NOM_USER}}`;
```
- Pour chaque valeur de `TABLE DIA`, générer les commandes suivantes :

```sql
PUT file://{{GITHUB_REPO_DIR}}/ddl_<VALEUR>.sql @{{NOM_USER}} AUTO_COMPRESS = FALSE  OVERWRITE = TRUE;
PUT file://{{GITHUB_REPO_DIR}}/dml_<VALEUR>.sql @{{NOM_USER}} AUTO_COMPRESS = FALSE  OVERWRITE = TRUE;

EXECUTE IMMEDIATE FROM '@{{NOM_USER}}/ddl_<VALEUR>.sql';
EXECUTE IMMEDIATE FROM '@{{NOM_USER}}/dml_<VALEUR>.sql';
```

#### Stockage fichier
- Nommer le fichier selon la convention:  `{{NOM_ONGLET_SEQUENCE}}.sql`
- Enregistrer le fichier dans le dossier : `SEQUENCES/{{NOM_ONGLET_SEQUENCE}}/`, si le dossier SEQUENCES n'existe pas, créé-le
