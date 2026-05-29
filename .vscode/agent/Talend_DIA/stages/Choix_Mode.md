## Objective
Choisir un mode d'execution exclusif pour le workflow.

## Instruction

### 1. Question obligatoire a l'utilisateur
- Poser une question interactive (bouton Submit response) avec 2 choix exclusifs:
  - `TABLE_ONLY` : generer uniquement le flux table (spec + DDL/DML + Talend + Git table)
  - `SEQUENCE_ONLY` : generer uniquement le flux sequence (lecture sequence + SQL sequence + Git sequence)

### 2. Regles
- Interdire toute execution mixte dans un meme run.
- Ne pas enchaîner table puis sequence automatiquement.
- Enregistrer le choix dans `{{EXECUTION_MODE}}`.

### 3. Validation
- Si la valeur n'est pas `TABLE_ONLY` ou `SEQUENCE_ONLY`, afficher une erreur claire et arreter.
