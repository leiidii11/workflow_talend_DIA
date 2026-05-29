## Objective
Générer le script DDL et DML Snowflake pour les tables cible et sources du DIA

## Source de données
- Utiliser uniquement les données de l’onglet SharePoint Spec spécifié par l’utilisateur.
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
- La premiere colonne doit être une clé SK: `SK_{{NOM_ONGLET_SPEC}} <NUMERIC_TYPE> NOT NULL AUTOINCREMENT`
- `<NUMERIC_TYPE>` doit utiliser la valeur `NUMERIC_TYPE` du fichier `.vscode/agent/Talend_DIA/snowflake-typing.config.json`.
- Utiliser les règles de typage définies dans `.vscode/agent/Talend_DIA/snowflake-typing.config.json`.
- Déduire les contraintes uniquement à partir des colonnes suivantes :
  - SK ?
  - UK ?
  - Null ?
- Ne pas créer d’index.
- Deduir les foreign key
- Ne pas inventer de colonnes ou de contraintes inexistantes.



#### Stockage fichier DDL
- Nommer le fichier selon la convention:  `ddl_{{NOM_ONGLET_SPEC}}.sql`
- Enregistrer le fichier dans le dossier : `TABLES/{{NOM_ONGLET_SPEC}}/`, si le dossier DDL n'existe pas, créé-le

----------------------------



### Etape 2: Création DML

### 1. Génération du DML
- Générer un fichier sql DML en apuyyant du DDL généré avant
- le DML a pour but d'insérer une ligne avec `SK_{{NOM_ONGLET_SPEC}}`=0 et `SK_{{NOM_ONGLET_SPEC}}`=-1

```sql
INSERT ALL
    WHEN (
        SELECT NOT EXISTS (
            SELECT *
            FROM DIA.D_`{{NOM_ONGLET_SPEC}}`
            WHERE SK_`{{NOM_ONGLET_SPEC}}` = 0
        )
    )
```
- Créer le fichier en respectant les retours à la ligne et la mise en forme SQL, par exemple :
```sql
INSERT ALL 
WHEN (...)
THEN INTO...
VALUES (...)
WHEN ()...
THEN INTO ..
VALUES ()...
```

### Règles de gestion des valeurs des champs
- les colonnes dt_crea, dt_modif, dt_alim doivent être à GETDATE()
- Faire attention selon les types des champs
- Les règles suivantes s’appliquent en fonction de la valeur de SK.

🔹 Cas 1 : SK = 0
Champs commençant par CD, MT ou TAUX → valeur = (vide)
Champs commençant par FK → valeur = 0
Champs commençant par ID → valeur = -2
Tous les autres champs → valeur = NULL

🔹 Cas 2 : SK = -1
Champs commençant par CD → valeur = N/A
Champs commençant par MT`` ou TAUX` → valeur = (vide)
Champs commençant par FK ou ID → valeur = -1
Tous les autres champs → valeur = NULL

# Remarques:
- Les règles sont basées sur le préfixe du nom du champ
- La distinction entre vide et NULL doit être respectée strictement
- Les valeurs numériques (0, -1, -2) doivent être conservées comme types numériques lorsque possible



#### Stockage fichier DML
- Nommer le fichier selon la convention:  `dml_{{NOM_ONGLET_SPEC}}.sql`
- Enregistrer le fichier dans le dossier : `TABLES/{{NOM_ONGLET_SPEC}}/`

