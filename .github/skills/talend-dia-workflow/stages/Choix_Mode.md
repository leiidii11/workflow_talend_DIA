# Stage: Choix_Mode

## Objectif
Obtenir le mode d execution exclusif du run.

## Modes autorises
- TABLE_ONLY
- SEQUENCE_ONLY

## Procedure
1. Demander explicitement le mode via interaction utilisateur.
2. Valider que la reponse est exactement `TABLE_ONLY` ou `SEQUENCE_ONLY`.
3. Memoriser `EXECUTION_MODE` pour les etapes suivantes.

## Contrat d execution
- Un seul mode par run.
- Interdit d enchainer TABLE_ONLY puis SEQUENCE_ONLY dans le meme run.

## Erreurs bloquantes
Si le mode est vide ou invalide:
- STOP
- expliquer le format attendu
- redemander la valeur
