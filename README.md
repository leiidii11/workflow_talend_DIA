# Partager l'agent Talend_DIA

## But
Utiliser le meme agent sur plusieurs PC et pour plusieurs utilisateurs, sans modifier le code du workflow.


## Ce qui reste local (non commit)
- `.vscode/agent/Talend_DIA/talend-config.json`

Ce fichier contient les chemins propres a chaque utilisateur (spec, workspace, repo Git).

## Premier demarrage sur un nouveau PC
1. Cloner le repository et ouvrir le workspace dans VS Code.
2. Lancer le workflow Talend_DIA.
3. Il vérifie si le fichier de config propre à l'utilisateur existe sinon, il va le créer 


## Bonnes pratiques
- Garder des chemins relatifs dans les references de stages (`stages/...`).
- Ne jamais commiter `talend-config.json`.
- Ne jamais mettre de secrets dans les fichiers versionnes.
