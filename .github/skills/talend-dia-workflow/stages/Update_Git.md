# Stage: Update_Git

## Objectif
Mettre a jour les fichiers du repository selon le mode choisi, sans commit et sans push.

## Procedure
1. Faire un pull de la branche DEV avant toute operation d ajout.
2. Ajouter ou mettre a jour les fichiers generes.
3. Stage des modifications autorise.

## Regles obligatoires
- Ne jamais commiter.
- Ne jamais faire de push.
- Ne jamais exposer des secrets.
- Ne jamais inclure `talend-config.json`.

## Erreurs bloquantes
En cas de conflit ou erreur Git:
- STOP
- expliquer le probleme
- demander arbitrage/correction
