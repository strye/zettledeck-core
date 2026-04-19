---
title: Conventions & Composition
description: The rules that keep modules composable — naming, placeholder markers for user-configurable paths, and optional dependency detection for soft inter-module integration.
---

# Conventions & Composition

These are the rules that let modules compose. Break them and modules still *work* in isolation — they just stop playing well together when a user installs three or four at once.

## Naming conventions

Module names use the `zettledeck-{name}` pattern: `zettledeck-praxis`, `zettledeck-foundry`, `zettledeck-nexus`. Names outside the core family (like `amazon-toolkit` or `rostrum-blackboard`) use a descriptive dash-separated name.

The module name is used:

- As the `source` field value in `module-config.json` entries
- As the directory name under `.zettledeck/` for `init-steps.md`, `note-rules.md`, and module-specific config
- As the module identifier in `zettledeck.yml`
- In `zd` log output

### Skill names

Skill names within a module use kebab-case: `diary`, `email`, `comms`. Dot notation (`bb.exec`, `zettledeck.init`) is intentional and supported for namespaced skills — ignore linter warnings about dots in skill names.

Prefer short, specific names. Two-word compound skills are a yellow flag — consider whether they should be a single skill with mode routing instead.

### Role uniqueness

Role names in `workspaceFolders` must be unique across all installed modules. If a module needs a role name that might collide, prefix it — `praxis-archive` instead of `archive`.

When in doubt, include your module name or domain as a prefix. Collisions are detected at install time but they're confusing to debug, so make collisions unlikely.

## Placeholder markers

Modules that need user-configurable paths declare them as placeholder markers in `init-steps.md`. Skills reference the markers in their `SKILL.md` files. At init time, `/zettledeck.init {module}` asks the user for a value and writes it into the module's `config.json`. Skills read the config at runtime and substitute the value.

This is how a skill says "use the diary folder" without hardcoding where the diary folder lives.

### Shared markers

A number of markers are already in use across modules. If a marker you need is already listed, **prefer the existing marker** — consistency across modules is a feature.


| Marker                | Default                       | Used by                  |
| --------------------- | ----------------------------- | ------------------------ |
| `{diary-path}`        | `Praxis/diary`                | praxis, nexus, foundry   |
| `{actions-path}`      | `Praxis/actions`              | praxis                   |
| `{rp-path}`           | `Praxis/ruthless-priorities`  | praxis, nexus            |
| `{vault-path}`        | `.` (workspace root)          | nexus                    |
| `{research-path}`     | `Tesseract`                   | foundry                  |
| `{comms-path}`        | `Scriptorium`                 | praxis                   |
| `{calendar-provider}` | `aws-outlook-calendar`        | praxis                   |
| `{email-provider}`    | `aws-outlook-email`           | praxis                   |

Introduce a new marker only when there isn't an equivalent. A new marker should cover a concept that multiple skills or modules will reference — one-off substitutions belong in that module's own `config.json` without promoting them to the shared list.

### How markers resolve

The resolution chain looks like this:

1. Skill references `{diary-path}` in `SKILL.md` or a resource file.
2. At invocation time, the agentic tool reads `.zettledeck/{module}/config.json`.
3. The config contains `"diaryPath": "Praxis/diary"`.
4. The skill substitutes the value and operates on `Praxis/diary`.

If a user renames their diary folder, they update the config once and every skill that uses the marker follows along.

## Optional dependency detection

Skills that integrate with optional modules check for the dependency at invocation time rather than declaring it as a hard requirement. This keeps modules composable — they enhance each other when both are present and degrade gracefully when one is absent.

### Pattern

```markdown
## Board Mode

IF the `bb` skill is available in `.shared/skills/bb/`:
  → Run in board mode with multi-phase orchestration
ELSE:
  → Run in standalone mode (single-pass workflow)
```

The check is a file-existence check, not a manifest lookup. This means:

- No registry of optional dependencies.
- No version-pinning or compatibility matrix.
- No dependency-resolution logic.

If the file exists, the capability is there.

### When to use it

Use optional dependency detection when your skill has a *better* path available if another module is installed, and a *perfectly usable* path if it isn't. Examples:

- Content skills that run deep research via a blackboard module if installed, single-pass otherwise.
- Nexus skills that use a specific analytic sub-skill if available, fallback analysis otherwise.
- Praxis skills that connect to a specific provider if one is registered, prompting for manual input otherwise.

Do **not** use optional dependency detection to fake a hard requirement. If your skill truly cannot function without another module, declare the dependency in your README and let the user know.

---

**Next reading:**

- [[skills-and-agents|Skills & Agents]] — where placeholder markers most often appear
- [[integrations|MCP Servers & Providers]] — the pattern that pairs with provider-style markers (`{email-provider}`, etc.)
- [[reference|Reference & Checklists]] — author checklists that reference these conventions
