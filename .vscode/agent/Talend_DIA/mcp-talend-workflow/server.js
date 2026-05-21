import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const WORKFLOW_FILE = path.resolve(__dirname, "../talend-workflow.md");
const DEFAULT_CONFIG_FILE = path.resolve(__dirname, "config/workflow.config.local.json");
const DEFAULT_OUTPUT_FILE = path.resolve(__dirname, "output/talend-workflow.rendered.md");

function readUtf8(filePath) {
  return fs.readFileSync(filePath, "utf-8");
}

function normalizePath(inputPath) {
  if (!inputPath) {
    return "";
  }

  // Expansion simple de %USERPROFILE% pour Windows.
  return inputPath.replace(/%USERPROFILE%/gi, process.env.USERPROFILE || "");
}

function loadConfig(configPath) {
  const resolvedPath = path.resolve(normalizePath(configPath || DEFAULT_CONFIG_FILE));

  if (!fs.existsSync(resolvedPath)) {
    throw new Error(
      `Fichier de configuration introuvable: ${resolvedPath}. Copiez config/workflow.config.example.json vers config/workflow.config.local.json.`
    );
  }

  const content = readUtf8(resolvedPath);
  const parsed = JSON.parse(content);

  if (!parsed || typeof parsed !== "object" || Array.isArray(parsed)) {
    throw new Error("La configuration doit être un objet JSON clé/valeur.");
  }

  return { resolvedPath, values: parsed };
}

function renderTemplate(content, variables) {
  return content.replace(/{{\s*([A-Z0-9_]+)\s*}}/g, (fullMatch, key) => {
    const value = variables[key];
    if (value === undefined || value === null || value === "") {
      return fullMatch;
    }
    return String(value);
  });
}

function findPlaceholders(content) {
  const regex = /{{\s*([A-Z0-9_]+)\s*}}/g;
  const placeholders = new Set();
  let match = regex.exec(content);

  while (match) {
    placeholders.add(match[1]);
    match = regex.exec(content);
  }

  return Array.from(placeholders);
}

function computeHash(content) {
  return crypto.createHash("sha256").update(content).digest("hex");
}

const server = new McpServer({
  name: "talend-workflow-share",
  version: "1.0.0",
});

server.registerTool(
  "get_workflow_latest",
  {
    title: "Récupérer le workflow central",
    description: "Retourne la version actuelle de talend-workflow.md et son hash SHA-256.",
    inputSchema: {},
  },
  async () => {
    if (!fs.existsSync(WORKFLOW_FILE)) {
      throw new Error(`Fichier workflow introuvable: ${WORKFLOW_FILE}`);
    }

    const content = readUtf8(WORKFLOW_FILE);
    const hash = computeHash(content);

    return {
      content: [
        {
          type: "text",
          text: JSON.stringify(
            {
              source: WORKFLOW_FILE,
              hash,
              workflow: content,
            },
            null,
            2
          ),
        },
      ],
    };
  }
);

server.registerTool(
  "validate_user_paths",
  {
    title: "Valider les chemins utilisateur",
    description:
      "Vérifie les chemins du fichier de configuration locale. Les clés finissant par _PATH ou _DIR sont testées.",
    inputSchema: {
      configPath: z.string().optional(),
    },
  },
  async ({ configPath }) => {
    const { resolvedPath, values } = loadConfig(configPath);
    const checks = [];

    for (const [key, rawValue] of Object.entries(values)) {
      if (!key.endsWith("_PATH") && !key.endsWith("_DIR")) {
        continue;
      }

      const expandedValue = normalizePath(String(rawValue || ""));
      const exists = expandedValue ? fs.existsSync(expandedValue) : false;

      checks.push({
        key,
        value: expandedValue,
        exists,
      });
    }

    const missing = checks.filter((item) => !item.exists);

    return {
      content: [
        {
          type: "text",
          text: JSON.stringify(
            {
              configPath: resolvedPath,
              totalChecked: checks.length,
              missingCount: missing.length,
              checks,
            },
            null,
            2
          ),
        },
      ],
    };
  }
);

server.registerTool(
  "render_workflow_for_user",
  {
    title: "Générer le workflow personnalisé",
    description:
      "Applique les variables utilisateur {{VARIABLE}} dans le workflow central et peut écrire le résultat dans un fichier local.",
    inputSchema: {
      configPath: z.string().optional(),
      writeToFile: z.boolean().default(true),
      outputPath: z.string().optional(),
    },
  },
  async ({ configPath, writeToFile = true, outputPath }) => {
    if (!fs.existsSync(WORKFLOW_FILE)) {
      throw new Error(`Fichier workflow introuvable: ${WORKFLOW_FILE}`);
    }

    const workflowContent = readUtf8(WORKFLOW_FILE);
    const placeholders = findPlaceholders(workflowContent);
    const { resolvedPath, values } = loadConfig(configPath);

    const rendered = renderTemplate(workflowContent, values);

    const unresolved = placeholders.filter((name) => {
      const currentRegex = new RegExp(`{{\\s*${name}\\s*}}`, "g");
      return currentRegex.test(rendered);
    });

    let fileWritten = null;
    if (writeToFile) {
      const resolvedOutput = path.resolve(normalizePath(outputPath || DEFAULT_OUTPUT_FILE));
      fs.mkdirSync(path.dirname(resolvedOutput), { recursive: true });
      fs.writeFileSync(resolvedOutput, rendered, "utf-8");
      fileWritten = resolvedOutput;
    }

    return {
      content: [
        {
          type: "text",
          text: JSON.stringify(
            {
              source: WORKFLOW_FILE,
              configPath: resolvedPath,
              outputPath: fileWritten,
              unresolvedPlaceholders: unresolved,
              hash: computeHash(rendered),
              workflow: rendered,
            },
            null,
            2
          ),
        },
      ],
    };
  }
);

const transport = new StdioServerTransport();
await server.connect(transport);
