# Partage du workflow Talend via MCP

Ce dossier contient un serveur MCP local Python pour partager automatiquement talend-workflow.md avec l'equipe.

Mode d'execution: zero-install, en mode workspace (pas en global utilisateur).

## Objectif

- Eviter l'envoi manuel de markdown.
- Fournir une version unique et a jour du workflow.
- Garder les chemins locaux de chaque utilisateur hors Git.

## Flux utilisateur recommande (commande unique)

Intention chat cible:

MCP talend-workflow onglet XXXX

Cette intention est couverte par l'outil run_talend_workflow.

Comportement:

1. Premier lancement: retour status needs_user_paths avec les cles a renseigner.
2. Une fois userPaths fournis: relancer run_talend_workflow avec le meme onglet.
3. Lancements suivants: execution directe du workflow sans redemande.

## Etapes nouveau utilisateur

1. Cloner le repository et ouvrir le workspace dans VS Code.
2. Attendre le premier demarrage MCP (bootstrap automatique).
3. Lancer run_talend_workflow avec l'onglet cible.
4. Si status needs_user_paths, fournir userPaths puis relancer run_talend_workflow.
5. Le workflow est rendu automatiquement.

Si les chemins sont invalides:

1. Le serveur retourne status invalid_user_paths ou invalid_saved_config.
2. Corriger les chemins.
3. Relancer run_talend_workflow.

## Exemples d'appel MCP

Premier appel:

```json
{
   "tool": "run_talend_workflow",
   "arguments": {
      "onglet": "D_ASSURE_RETRAITE"
   }
}
```

Relance avec configuration utilisateur:

```json
{
   "tool": "run_talend_workflow",
   "arguments": {
      "onglet": "D_ASSURE_RETRAITE",
      "userPaths": {
         "SHAREPOINT_SPEC_PATH": "C:/.../spec_retraite.xlsx",
         "WORKSPACE_DIR": "C:/.../Workflow Talend",
         "GITHUB_REPO_DIR": "C:/.../Workflow Talend"
      }
   }
}
```

## Outils MCP disponibles

1. check_first_launch: detecte si la config locale existe.
2. save_user_config: enregistre config/workflow.config.local.json.
3. get_workflow_latest: retourne le workflow central + hash.
4. validate_user_paths: verifie les chemins *_PATH et *_DIR.
5. render_workflow_for_user: rend le workflow avec variables.
6. run_talend_workflow: orchestration complete premier lancement + execution.

## Lancer le serveur manuellement (optionnel)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File run-mcp.ps1
```

## Declaration VS Code

Le serveur est deja declare dans .vscode/mcp.json. VS Code le charge automatiquement dans ce workspace.

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

1. Bootstrap prevu pour Windows PowerShell.
2. Internet requis au premier lancement pour telecharger runtime Python et paquets.
3. Runtime local stocke dans .runtime puis reutilise.
4. Pas de droits admin necessaires, mais droits d'ecriture requis dans le workspace.

## Bonnes pratiques

1. Versionner talend-workflow.md.
2. Ne jamais versionner config/workflow.config.local.json.
3. Ne pas definir STAGE_*_PATH dans la config utilisateur (gere automatiquement).
4. En cas de doute, privilegier run_talend_workflow (outil unique).

## Variables dynamiques (optionnel)

Exemples de placeholders:

- {{SHAREPOINT_SPEC_PATH}}
- {{WORKSPACE_DIR}}
- {{STAGE_01_PATH}}

Les variables absentes restent visibles telles quelles dans le rendu.
