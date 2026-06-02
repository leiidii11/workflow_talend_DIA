# Stage: Generation_DDL_DML

## Objectif
Generer les scripts DDL et DML Snowflake pour la table cible DIA a partir de la specification validee.

## Procedure
1. Construire le DDL de creation/ajustement de table selon la spec.
2. Construire le DML associe selon les regles de transformation.
3. Verifier la coherence schema/types/nullabilite/cles.
4. Ecrire les fichiers SQL dans les emplacements cibles du repository.

## Criteres de validation
- DDL syntaxiquement coherent.
- DML coherent avec la structure cible.
- Fichiers SQL sortants effectivement crees.

## Erreurs bloquantes
Si DDL incoherent ou fichiers non crees:
- STOP
- expliquer l anomalie
- demander correction
- ne rien stage/commiter
