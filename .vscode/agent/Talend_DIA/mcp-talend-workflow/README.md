# Partage du workflow Talend via MCP

Ce dossier contient un serveur MCP local Python pour partager automatiquement `talend-workflow.md` avec toute l'equipe.

Mode d'execution: zero-install pour les utilisateurs finaux (pas besoin d'installer Python manuellement).

## Objectif

- Eviter l'envoi manuel de fichiers markdown.
- Fournir une version unique et toujours a jour du workflow.
- Permettre a chaque utilisateur de garder ses propres chemins locaux.

## Outils MCP exposes

1. `check_first_launch`
   - Detecte si la config locale existe. Si absent (premier lancement), retourne la liste des chemins a renseigner.
2. `save_user_config`
   - Reçoit les chemins fournis et cree `config/workflow.config.local.json` (jamais versionne).
3. `get_workflow_latest`
   - Retourne le contenu central du workflow et un hash SHA-256.
4. `validate_user_paths`
   - Verifie les chemins de configuration utilisateur (`*_PATH`, `*_DIR`).
5. `render_workflow_for_user`
   - Applique les variables `{{VARIABLE}}` puis produit un rendu personnalise.

## Installation (zero install)

1. Cloner le repo et ouvrir le workspace dans VS Code.
2. VS Code detecte automatiquement le serveur MCP via `.vscode/mcp.json` (deja versionne).
3. Au premier lancement, un bootstrap telecharge Python embeddable + dependances dans `.runtime/`.
4. Appeler `check_first_launch` : il retourne les chemins a renseigner.
5. Appeler `save_user_config` avec vos chemins : la config locale est creee et stockee uniquement sur votre machine.

## Lancer le serveur MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File run-mcp.ps1
```

## Declaration VS Code (mcp.json)

Deja present dans `.vscode/mcp.json` a la racine du workspace. VS Code le charge automatiquement.
Le chemin est relatif (`${workspaceFolder}`) donc fonctionne sur toute machine sans modification.

```json
{
  "servers": {
    "talend-workflow": {
      "type": "stdio",
         "command": "powershell",
      "args": [
            "-NoProfile",
            "-ExecutionPolicy",
            "Bypass",
            "-File",
            "${workspaceFolder}/.vscode/agent/Talend_DIA/mcp-talend-workflow/run-mcp.ps1"
      ]
    }
  }
}
```

## Notes zero-install

1. Le bootstrap est prevu pour Windows PowerShell.
2. Un acces internet est necessaire uniquement au premier lancement pour telecharger le runtime Python et les paquets.
3. Le runtime local est stocke dans `.runtime/` et reutilise ensuite.

## Bonnes pratiques de partage

1. Versionner `talend-workflow.md` dans Git (source unique).
2. Ne jamais versionner `workflow.config.local.json` (deja dans `.gitignore`).
3. Les chemins `STAGE_*_PATH` sont resolus automatiquement par le serveur — ne pas les ajouter dans la config.
4. Faire evoluer les variables `{{VARIABLE}}` dans le workflow quand un chemin doit etre personnalise.
5. Appeler `validate_user_paths` avant `render_workflow_for_user` pour verifier les chemins.

## Variables dynamiques (optionnel)

Si vous voulez rendre le markdown parametrable, utilisez ce format:

- `{{SHAREPOINT_SPEC_PATH}}`
- `{{WORKSPACE_DIR}}`
- `{{STAGE_01_PATH}}`

Les variables absentes dans la config locale restent visibles telles quelles dans le rendu.
