## Objective
Mettre à jour le GitHub avec les nouveaux fichiers DDL et DML


## Instruction

### 1. Dossier cible
- Répertoire Git `{{GITHUB_REPO_DIR}}` (ou URL fournie par l’utilisateur)


### 2. Régles
- Si le fichier existe déjà dans le répertoire GIT proposer une version alternative par example `ddl_<NOM_TABLE>_v2.sql`

---

### 3. Actions Git
1. Se positionner sur la branche `dev`
2. Exécuter `git pull`
3. Copier le fichier DDL et DML dans le dossier cible
4. ⚠️ Ne pas exécuter le commit ni le push
   - attendre la validation explicite de l’utilisateur