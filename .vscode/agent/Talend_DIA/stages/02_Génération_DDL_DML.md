## Objective
Générer le script DDL et DML Snowflake pour les tables cible et sources

## Source de données
- Utiliser uniquement les données de l’onglet SharePoint spécifié par l’utilisateur.
- Ne pas utiliser d’autres sources ou données implicites.

---

### Etape 1: Création DDL

### Régles colonnes:
Les colonnes utilisé du excel source des données doivent être celles du DIA  pour toute la étape 1 et 2:
- Column
- Data Type
- Format
- SK ?
- UK ?
- Null?


### 1. Génération du DDL
- Générer un fichier sql DDL à partir des colonnes de l’onglet définit
- La premiere colonne doit être une clé SK: `SK_<NOM_TABLE> NUMBER(38,0) NOT NULL autoincrement`
- Déduire les contraintes uniquement à partir des colonnes suivantes :
  - SK ?
  - UK ?
  - Null ?
- Ne pas créer d’index.
- Ne pas inventer de colonnes ou de contraintes inexistantes.


#### Règles de typage Snowflake :
- Types numériques → `NUMBER(38,0)`
- Types textuels → `VARCHAR(16777216)`
- Types temporels ou date → `TIMESTAMP_NTZ(9)`
- Types boolean `BOOLEAN`


#### Stockage fichier DDL
- Nommer le fichier selon la convention:  `ddl_<NOM_TABLE>.sql`
- Enregistrer le fichier dans le dossier : `DDL/<NOM_TABLE>/`

---


### Etape 2: Création DML

### 1. Génération du DML
- Générer un fichier sql DML en apuyyant du DDL généré avant
- le DML a pour but d'insérer une ligne avec SK_`<NOM_TABLE>`=0 et SK_`<NOM_TABLE>`=-1

```sql
INSERT ALL
    WHEN (
        SELECT NOT EXISTS (
            SELECT *
            FROM DIA.D_`<NOM_TABLE>`
            WHERE SK_`<NOM_TABLE>` = 0
        )
    )
```
- Tous les colonnes ID et colonne d'unicité doivent être à -2 quand le SK_`<NOM_TABLE>`=0 ou à -1 quand le SK_`<NOM_TABLE>`=-1
- les colonnes dt_crea, dt_modif, dt_alim doivent être à GETDATE()
- Faire attention selon les types des champs
- Créer le fichier en respectant les retours à la ligne et la mise en forme SQL, par exemple :
```sql
INSERT ALL 
WHEN (...)
THEN INTO...
VALUES (...)
WHEN ()...)
THEN INTO ..
VALUES ()...)```


#### Stockage fichier DML
- Nommer le fichier selon la convention:  `dml_<NOM_TABLE>.sql`
- Enregistrer le fichier dans le dossier : `DDL/<NOM_TABLE>/`


-----------
