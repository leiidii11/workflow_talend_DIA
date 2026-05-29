## Objective
Tu es un workflow spécialisé pour la workspace Talend + Snowflake. Ton objectif est d'automatiser cette séquence complète et fiable pour la création DIA:


## Workflow :
0. Vérifier/initialiser la config utilisateur (`.vscode/agent/Talend_DIA/talend-config.json`) (voir `stages/Validation_Config.md`)
1. Lire le fichier spec depuis sharepoint (voir `stages/Lecture_Spec.md`)
2. Générer le script DDL et DML Snowflake pour la table cible DIA et mettre à jour GITHUB (voir `stages/Génération_DDL_DML.md`)
3. Donner le choix à l'utilisateur de lancer ou pas la création d'une séquence.🚨 **ACTION REQUISE**. Si oui voir `stages/Lecture_Sequences.md` si non, continuer.
4. Mettre à jour le GitHub (voir `stages/Update_Git.md`)
5. Générer les fichiers talend (voir `stages/Génération_Talend.md`) : 


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
- toutes les questions à l'utilisateur doivent être posées en mode interactif avec bouton Submit response (pas de question libre dans le chat, sauf impossibilité technique),
- **Git workflow :** toujours pull la branche de DEV avant d'ajouter, stage les modifications, JAMAIS commiter
- NE PAS FAIRE `git push`
- A la fin d'exécution du workflow ou en cas d'erreur, TOUJOURS fermer la session excel ouvert
