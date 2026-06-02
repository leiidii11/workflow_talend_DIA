# Stage: Lecture_Spec

## Objectif
Lire le fichier de specification de la table DIA depuis SharePoint (ou source equivalente configuree).

## Procedure
1. Recuperer le fichier source specifie par la configuration.
2. Verifier que les colonnes attendues sont presentes.
3. Verifier les types et contraintes minimales necessaires a la generation DDL/DML.
4. Normaliser les metadonnees pour la suite du pipeline.

## Criteres de validation
- Le fichier est lisible.
- Les colonnes obligatoires existent.
- Les metadonnees sont coherentes.

## Erreurs bloquantes
Si Excel est mal lu ou si des colonnes manquent:
- STOP
- decrire precisement les colonnes manquantes/invalides
- demander correction
- ne rien generer
