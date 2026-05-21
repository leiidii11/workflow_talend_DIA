# Partage du workflow Talend via MCP

Ce dossier contient un serveur MCP local pour partager automatiquement `talend-workflow.md` avec toute l'équipe.

## Objectif

- Eviter l'envoi manuel de fichiers markdown.
- Fournir une version unique et toujours a jour du workflow.
- Permettre a chaque utilisateur de garder ses propres chemins locaux.

## Outils MCP exposes

1. `get_workflow_latest`
   - Retourne le contenu central du workflow et un hash SHA-256.
2. `validate_user_paths`
   - Verifie les chemins de configuration utilisateur (`*_PATH`, `*_DIR`).
3. `render_workflow_for_user`
   - Applique les variables `{{VARIABLE}}` puis produit un rendu personnalise.

## Installation

1. Ouvrir un terminal dans ce dossier.
2. Installer les dependances:

```powershell
npm install
```

3. Creer la config utilisateur locale:

```powershell
Copy-Item .\config\workflow.config.example.json .\config\workflow.config.local.json
```

4. Editer `config/workflow.config.local.json` avec vos vrais chemins.

## Lancer le serveur MCP

```powershell
npm start
```

## Exemple de declaration dans VS Code (mcp.json)

```json
{
  "servers": {
    "talend-workflow": {
      "type": "stdio",
      "command": "node",
      "args": [
        "c:/Users/marcelaa/ALPTIS/Projets IA/Workflow Talend/.vscode/agent/Talend_DIA/mcp-talend-workflow/server.js"
      ]
    }
  }
}
```

## Bonnes pratiques de partage

1. Versionner `talend-workflow.md` dans Git (source unique).
2. Ne jamais versionner `workflow.config.local.json`.
3. Faire evoluer les variables `{{VARIABLE}}` dans le workflow quand un chemin doit etre personnalise.
4. Demander aux utilisateurs d'executer `validate_user_paths` avant `render_workflow_for_user`.

## Variables dynamiques (optionnel)

Si vous voulez rendre le markdown parametrable, utilisez ce format:

- `{{SHAREPOINT_SPEC_PATH}}`
- `{{WORKSPACE_DIR}}`
- `{{STAGE_01_PATH}}`

Les variables absentes dans la config locale restent visibles telles quelles dans le rendu.
