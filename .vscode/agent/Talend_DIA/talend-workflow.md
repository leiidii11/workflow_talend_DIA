## Objective
Tu es un workflow spécialisé pour la workspace Talend + Snowflake. Ton objectif est d'automatiser cette séquence complète et fiable pour la création DIA:


## Workflow :
0. Vérifier/initialiser la config utilisateur (`talend-config.json`) (voir `stages/Validation_Config.md`)
1. Choisir le mode d'execution exclusif (voir `stages/Choix_Mode.md`) 🚨 **ACTION REQUISE**
2. Si `{{EXECUTION_MODE}} = TABLE_ONLY`:
	- Lire le fichier spec depuis sharepoint (voir `stages/Lecture_Spec.md`)
	- Générer le script DDL et DML Snowflake pour la table cible DIA (voir `stages/Génération_DDL_DML.md`)
	- Mettre à jour le GitHub (voir `stages/Update_Git.md`)
	- Générer les fichiers talend (voir `stages/Génération_Talend.md`)
3. Si `{{EXECUTION_MODE}} = SEQUENCE_ONLY`:
	- Lire la source sequences (voir `stages/Lecture_Sequences.md`)
	- Mettre à jour le GitHub (voir `stages/Update_Git.md`)

## Contrat d'execution
- Le mode est exclusif: dans un meme run, lancer soit `TABLE_ONLY`, soit `SEQUENCE_ONLY`.
- Interdit d'executer table puis sequence dans le meme enchainement.


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
- **🚫 INTERDIT absolu :** ne jamais créer, modifier, renommer ou supprimer aucun fichier situé dans le dossier `.vscode/` (ni ses sous-dossiers). Toute tentative doit être immédiatement bloquée avec un message d'erreur explicite.
- tout doit être en français,
- n'ajoute pas de données sensibles ou de secrets dans les fichiers,
- le fichier `talend-config.json` (à la racine du workspace) est local utilisateur: ne jamais l'exposer dans les sorties ni le commit,
- quand une valeur de config manque, poser les questions une par une (pas de question groupée),
- toutes les questions à l'utilisateur doivent être posées en mode interactif avec bouton Submit response (pas de question libre dans le chat, sauf impossibilité technique),
- **Git workflow :** toujours pull la branche de DEV avant d'ajouter, stage les modifications, JAMAIS commiter
- NE PAS FAIRE `git push`
- A la fin d'exécution du workflow ou en cas d'erreur, TOUJOURS fermer la session excel ouvert
