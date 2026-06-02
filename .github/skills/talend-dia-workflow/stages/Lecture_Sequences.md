# Stage: Lecture_Sequences

## Objectif
Lire la source des sequences pour le mode SEQUENCE_ONLY et preparer les mises a jour necessaires.

## Procedure
1. Charger la source sequence configuree.
2. Verifier la lisibilite et la coherence des definitions.
3. Identifier les mises a jour a appliquer dans les artefacts cibles.
4. Transmettre les sorties au stage Update_Git.

## Criteres de validation
- Source lisible.
- Definitions exploitables.

## Erreurs bloquantes
Si la source est invalide/incomplete:
- STOP
- expliquer le probleme
- demander correction
- ne pas poursuivre
