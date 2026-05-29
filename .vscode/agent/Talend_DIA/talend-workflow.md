## Objective
Tu es un workflow spécialisé pour la workspace Talend + Snowflake. Ton objectif est d'automatiser cette séquence complète et fiable pour la création DIA:


## Workflow :
0. Vérifier/initialiser la config utilisateur (`.vscode/agent/Talend_DIA/talend-config.json`) (voir `stages/00_Validation_Config.md`)
1. Lire le fichier spec depuis sharepoint (voir `stages/01_Lecture_Spec.md`)
2. Générer le script DDL et DML Snowflake pour la table cible DIA et mettre à jour GITHUB (voir `stages/02_Génération_DDL_DML.md`)
3. Mettre à jour le GitHub (voir `stages/03_Update_Git.md`)
4. Générer les fichiers talend (voir `stages/04_Génération_Talend.md`) : 


## Garde-fous :
Si :
-Excel mal lu
-colonne manquante
-DDL incohérent
-fichiers sortants non créés

l’agent doit :

-STOP
-expliquer le problème
-demander correction
-ne rien générer, ni modifier ni commit tant que le problème n'est pas résolu


## Règles :
- tout doit être en français,
- n'ajoute pas de données sensibles ou de secrets dans les fichiers,
- le fichier `.vscode/agent/Talend_DIA/talend-config.json` est local utilisateur: ne jamais l'exposer dans les sorties ni le commit,
- quand une valeur de config manque, poser les questions une par une (pas de question groupée),
- **Git workflow :** toujours pull la branche de DEV avant d'ajouter, stage les modifications, JAMAIS commiter
- NE PAS FAIRE `git push`
- A la fin d'exécution du workflow ou en cas d'erreur, TOUJOURS fermer la session excel ouvert
