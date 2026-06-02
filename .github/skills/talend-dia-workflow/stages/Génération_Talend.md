# Stage: Generation_Talend

## Objectif
Generer les artefacts Talend (XML/templates associes) pour la table DIA en mode TABLE_ONLY.

## Procedure
1. Utiliser les metadonnees valides et le mapping attendu.
2. Generer les fichiers XML necessaires au flux Talend.
3. Verifier la presence de tous les fichiers sortants attendus.
4. Valider la coherence de nommage et de structure.

## Criteres de validation
- Tous les fichiers Talend attendus sont crees.
- Les contenus sont coherents avec la spec.

## Erreurs bloquantes
Si un fichier sortant manque ou est invalide:
- STOP
- expliquer le detail
- demander correction
- ne rien commiter
