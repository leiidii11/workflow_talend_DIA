## Objective
Générer les fichiers au format Talend 

### Sources des templates
- Les fichiers références sont stockés dans le dossier `TEMPLATES`


-------------
### Etape 1. Création fichier SOURCE

## Source de données
- Utiliser uniquement les données de l’onglet SharePoint spécifié par l’utilisateur.
- Ne pas utiliser d’autres sources ou données implicites.

### Régles colonnes:
Les colonnes utilisé du excel source des données doivent être celles du PSA  pour toute la étape 3:
- Source Table
- Source Column
- Source Data Type


### 1. Création des fichier sources
- En utilisant le fichier excel source, générer un fichier conforme le template `tmap.xml` pour chaque `Source Table` du fichier
- Créer les colonnes uniquement à partir des informations présentes dans l’onglet Excel `Source Column`


#### Règles de typage Snowflake :
- Utiliser les règles de typage définies dans `.vscode/agent/Talend_DIA/snowflake-typing.config.json`.


#### Stockage fichier DDL
- Nommer chaque fichier selon la convention:  `source_<Source Table>.xml`



------
### Etape 2. Création fichier TMAP
- En utilisant le template `tmap.xml`et la DDL généré `ddl_{{NOM_ONGLET_SPEC}}.sql`, generer un fichier xml
- Ne prende pas en compte le champ `SK_{{NOM_ONGLET_SPEC}}` ni `DT_ALIM`
- La clé primaire doit être en type textuel (clé `TEXT_TYPE` du fichier `.vscode/agent/Talend_DIA/snowflake-typing.config.json`).
- Tous les autres champs doivent être en `STRING`
- Nommer le fichier selon la convention:  `tmap_{{NOM_ONGLET_SPEC}}.xml`



### Etape 3. Création fichier MINUS
- En utilisant tous les champs du DDL généré, créer un fichier sql avec la query adapté
- où `colonnes` sont tous les champs sauf `SK_{{NOM_ONGLET_SPEC}}` `DT_ALIM`
- voici le sql template:
```sql
CREATE TEMPORARY TABLE DIA.TMP_{{NOM_ONGLET_SPEC}}_MINUS
as 
select
	`colonnes`
	getdate() as DT_CREA,
	getdate() as DT_MODIF
from dia.tmp_{{NOM_ONGLET_SPEC}}
minus
select
    `colonnes`
	getdate() as DT_CREA,
	getdate() as DT_MODIF
from dia.{{NOM_ONGLET_SPEC}} where sk_{{NOM_ONGLET_SPEC}} >0

```
- Nommer le fichier selon la convention:  `minus_{{NOM_ONGLET_SPEC}}.xml`

---------

### Etape 4. Création fichier MERGE
- En utilisant le template `merge.xml`et la DDL généré `ddl_{{NOM_ONGLET_SPEC}}.sql`, generer un fichier xml
- Ne prende pas en compte le champ  `DT_ALIM`
- La `SK_{{NOM_ONGLET_SPEC}}`  doit être en type textuel (clé `TEXT_TYPE` du fichier `.vscode/agent/Talend_DIA/snowflake-typing.config.json`).
- Tous les autres champs doivent être en `STRING`
- Nommer le fichier selon la convention:  `merge_{{NOM_ONGLET_SPEC}}.xml`

----------------


#### Stockage des fichiers

- Enregistrer tous fichier dans le dossier : `XML/{{NOM_ONGLET_SPEC}}/`
