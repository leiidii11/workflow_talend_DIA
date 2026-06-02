# Stage: Validation_Config

## Objectif
Verifier ou initialiser la configuration utilisateur `talend-config.json` a la racine du workspace.

## Entrees attendues
- Fichier `talend-config.json` (local utilisateur)

## Procedure
1. Verifier si le fichier existe.
2. Si le fichier est absent, demander les informations minimales une par une en mode interactif.
3. Si le fichier existe mais des cles obligatoires manquent, poser les questions une par une.
4. Valider la coherence des valeurs avant de continuer le workflow.

## Regles obligatoires
- Ne jamais afficher le contenu complet de `talend-config.json` dans les sorties.
- Ne jamais commiter ce fichier.
- Toutes les questions doivent etre posees de facon interactive avec validation explicite.

## Erreurs bloquantes
Si une valeur critique est absente ou incoherente:
- STOP
- expliquer l erreur
- demander correction
- ne pas poursuivre les etapes suivantes
