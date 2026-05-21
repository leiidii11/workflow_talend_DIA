import hashlib
import json
import os
import re
from pathlib import Path
from typing import Any

from mcp.server.fastmcp import FastMCP

BASE_DIR = Path(__file__).resolve().parent
WORKFLOW_FILE = (BASE_DIR / "../talend-workflow.md").resolve()
DEFAULT_CONFIG_FILE = (BASE_DIR / "config/workflow.config.local.json").resolve()
DEFAULT_OUTPUT_FILE = (BASE_DIR / "output/talend-workflow.rendered.md").resolve()
STAGES_DIR = (BASE_DIR / "../stages").resolve()

BUILTIN_VARS = {
    "STAGE_01_PATH": str(STAGES_DIR / "01_Lecture_Spec.md"),
    "STAGE_02_PATH": str(STAGES_DIR / "02_Génération_DDL_DML.md"),
    "STAGE_03_PATH": str(STAGES_DIR / "03_Update_Git.md"),
    "STAGE_04_PATH": str(STAGES_DIR / "04_Génération_Talend.md"),
}

WORKFLOW_OUTPUT_DIRS = ["DDL", "XML"]
PLACEHOLDER_REGEX = re.compile(r"{{\s*([A-Z0-9_]+)\s*}}")

mcp = FastMCP(name="talend-workflow-share", version="1.0.0")


def read_utf8(file_path: Path) -> str:
    return file_path.read_text(encoding="utf-8")


def normalize_path(input_path: str | None) -> str:
    if not input_path:
        return ""
    return re.sub(r"%USERPROFILE%", os.environ.get("USERPROFILE", ""), input_path, flags=re.IGNORECASE)


def load_config(config_path: str | None) -> tuple[Path, dict[str, Any]]:
    resolved_path = Path(normalize_path(config_path) if config_path else str(DEFAULT_CONFIG_FILE)).resolve()

    if not resolved_path.exists():
        raise FileNotFoundError(
            f"Fichier de configuration introuvable: {resolved_path}. "
            "Utilisez l'outil check_first_launch puis save_user_config."
        )

    parsed = json.loads(read_utf8(resolved_path))
    if not isinstance(parsed, dict):
        raise ValueError("La configuration doit etre un objet JSON cle/valeur.")

    return resolved_path, parsed


def render_template(content: str, variables: dict[str, Any]) -> str:
    def replace(match: re.Match[str]) -> str:
        key = match.group(1)
        value = variables.get(key)
        if value in (None, ""):
            return match.group(0)
        return str(value)

    return PLACEHOLDER_REGEX.sub(replace, content)


def find_placeholders(content: str) -> list[str]:
    return sorted(set(PLACEHOLDER_REGEX.findall(content)))


def compute_hash(content: str) -> str:
    return hashlib.sha256(content.encode("utf-8")).hexdigest()


def ensure_workspace_dirs(workspace_dir: str) -> list[str]:
    created: list[str] = []
    root = Path(normalize_path(workspace_dir)).resolve()

    for name in WORKFLOW_OUTPUT_DIRS:
        target = root / name
        if not target.exists():
            target.mkdir(parents=True, exist_ok=True)
            created.append(str(target))

    return created


@mcp.tool(name="get_workflow_latest", description="Retourne la version actuelle du workflow et son hash SHA-256.")
def get_workflow_latest() -> dict[str, Any]:
    if not WORKFLOW_FILE.exists():
        raise FileNotFoundError(f"Fichier workflow introuvable: {WORKFLOW_FILE}")

    content = read_utf8(WORKFLOW_FILE)
    return {
        "source": str(WORKFLOW_FILE),
        "hash": compute_hash(content),
        "workflow": content,
    }


@mcp.tool(
    name="validate_user_paths",
    description="Verifie les chemins du fichier de configuration locale (*_PATH, *_DIR).",
)
def validate_user_paths(configPath: str | None = None) -> dict[str, Any]:
    resolved_path, values = load_config(configPath)
    checks: list[dict[str, Any]] = []

    for key, raw_value in values.items():
        if not key.endswith("_PATH") and not key.endswith("_DIR"):
            continue

        expanded = normalize_path(str(raw_value or ""))
        exists = Path(expanded).exists() if expanded else False
        checks.append({"key": key, "value": expanded, "exists": exists})

    missing = [item for item in checks if not item["exists"]]

    return {
        "configPath": str(resolved_path),
        "totalChecked": len(checks),
        "missingCount": len(missing),
        "checks": checks,
    }


@mcp.tool(
    name="render_workflow_for_user",
    description="Applique les variables {{VARIABLE}} et peut ecrire le rendu dans un fichier local.",
)
def render_workflow_for_user(
    configPath: str | None = None,
    writeToFile: bool = True,
    outputPath: str | None = None,
) -> dict[str, Any]:
    if not WORKFLOW_FILE.exists():
        raise FileNotFoundError(f"Fichier workflow introuvable: {WORKFLOW_FILE}")

    workflow_content = read_utf8(WORKFLOW_FILE)
    placeholders = find_placeholders(workflow_content)
    resolved_path, values = load_config(configPath)

    all_values = {**BUILTIN_VARS, **values}
    dirs_created = ensure_workspace_dirs(str(all_values["WORKSPACE_DIR"])) if all_values.get("WORKSPACE_DIR") else []

    rendered = render_template(workflow_content, all_values)
    unresolved = [name for name in placeholders if re.search(r"{{\s*" + re.escape(name) + r"\s*}}", rendered)]

    file_written: str | None = None
    if writeToFile:
        resolved_output = Path(normalize_path(outputPath) if outputPath else str(DEFAULT_OUTPUT_FILE)).resolve()
        resolved_output.parent.mkdir(parents=True, exist_ok=True)
        resolved_output.write_text(rendered, encoding="utf-8")
        file_written = str(resolved_output)

    return {
        "source": str(WORKFLOW_FILE),
        "configPath": str(resolved_path),
        "outputPath": file_written,
        "unresolvedPlaceholders": unresolved,
        "dirsCreated": dirs_created,
        "hash": compute_hash(rendered),
        "workflow": rendered,
    }


@mcp.tool(
    name="check_first_launch",
    description="Verifie si la configuration locale existe et retourne les cles attendues en premier lancement.",
)
def check_first_launch() -> dict[str, Any]:
    if DEFAULT_CONFIG_FILE.exists():
        values = json.loads(read_utf8(DEFAULT_CONFIG_FILE))
        return {
            "firstLaunch": False,
            "configPath": str(DEFAULT_CONFIG_FILE),
            "message": "Configuration locale trouvee. Le workflow est pret.",
            "variables": sorted(values.keys()),
        }

    example_path = (BASE_DIR / "config/workflow.config.example.json").resolve()
    example_content = json.loads(read_utf8(example_path)) if example_path.exists() else {}
    required_keys = sorted(example_content.keys())

    return {
        "firstLaunch": True,
        "configPath": str(DEFAULT_CONFIG_FILE),
        "message": "Aucune configuration locale detectee. Fournissez les chemins via save_user_config.",
        "requiredKeys": required_keys,
        "descriptions": {
            "SHAREPOINT_SPEC_PATH": "Chemin complet vers le fichier Excel de spec.",
            "WORKSPACE_DIR": "Dossier racine du workspace Talend.",
            "GITHUB_REPO_DIR": "Dossier racine du depot Git.",
        },
        "note": "Les chemins STAGE_*_PATH sont resolus automatiquement.",
    }


@mcp.tool(
    name="save_user_config",
    description="Enregistre la configuration utilisateur locale apres validation des chemins.",
)
def save_user_config(values: dict[str, str]) -> dict[str, Any]:
    if not isinstance(values, dict):
        raise ValueError("Le parametre 'values' doit etre un objet JSON cle/valeur.")

    validation_errors: list[dict[str, str]] = []
    for key, raw_value in values.items():
        if not key.endswith("_PATH") and not key.endswith("_DIR"):
            continue

        expanded = normalize_path(raw_value)
        if expanded and not Path(expanded).exists():
            validation_errors.append({"key": key, "value": expanded, "error": "Chemin introuvable"})

    if validation_errors:
        return {
            "saved": False,
            "message": "Des chemins sont invalides. Corrigez-les avant de sauvegarder.",
            "validationErrors": validation_errors,
        }

    DEFAULT_CONFIG_FILE.parent.mkdir(parents=True, exist_ok=True)
    DEFAULT_CONFIG_FILE.write_text(json.dumps(values, indent=2, ensure_ascii=False), encoding="utf-8")

    return {
        "saved": True,
        "configPath": str(DEFAULT_CONFIG_FILE),
        "message": "Configuration enregistree avec succes. Le workflow est pret.",
        "variables": sorted(values.keys()),
    }


if __name__ == "__main__":
    mcp.run(transport="stdio")
