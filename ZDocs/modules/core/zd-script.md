---
title: The zd Script
description: Full command reference for zd — setup, install, update, status — plus tool wiring details, module declaration format, and CLI dependency requirements.
---

# The `zd` Script

`.zettledeck/scripts/zd` is the ZettleDeck module composer. It's the command that installs add-on modules, wires them into Claude Code or Kiro, and keeps them current.

Most users run `zd setup` once, `zd update` occasionally, and `zd status` when something seems off. This page is the full reference.

## Command summary


| Command      | What it does                                                                                        |
| ------------ | --------------------------------------------------------------------------------------------------- |
| `zd setup`   | Wire the agentic tool(s) (Claude Code, Kiro) and install any declared modules. Run this first.    |
| `zd install` | Install add-on modules declared in `.zettledeck/zettledeck.yml`                                   |
| `zd update`  | Refresh installed modules from their sources, preserving user-owned fields                         |
| `zd status`  | Show installed skills, agents, steering, MCP servers, providers, init state, document types, wiring |

Run `zd help` for a terse in-terminal summary.

## `zd setup`

One-time project bootstrap. Detects which agentic tool directories exist (`.claude/`, `.kiro/`), creates the symlinks each one needs into `.shared/`, and then runs `zd install` if any modules are declared in `zettledeck.yml`.

### What it wires for Claude Code

If `.claude/` exists at the project root, `zd setup`:

- Symlinks `.claude/skills → ../.shared/skills`
- Symlinks `.claude/agents → ../.shared/agents`
- Symlinks `.mcp.json → .shared/settings/mcp.json` at the project root

Steering is expected to be referenced from `CLAUDE.md` — the setup step doesn't auto-wire steering for Claude Code because Claude Code's steering model is different from Kiro's. Core's `CLAUDE.md` template references `.shared/steering/` already; confirm yours does the same.

### What it wires for Kiro

If `.kiro/` exists at the project root, `zd setup`:

- Symlinks `.kiro/skills → ../.shared/skills`
- Symlinks `.kiro/steering → ../.shared/steering`
- Symlinks `.kiro/settings → ../.shared/settings`
- Creates per-agent symlinks in `.kiro/agents/` with companion JSON files for each agent in `.shared/agents/`

Kiro needs per-agent JSON companions; `zd` generates these automatically and regenerates them whenever `zd install` or `zd update` adds new agents.

### Running setup without any tool directories

If neither `.claude/` nor `.kiro/` exists when you run `zd setup`, it logs a note and exits without wiring. Create one (or both) of the directories first, then re-run:

```bash
mkdir .claude    # for Claude Code
mkdir .kiro      # for Kiro
./.zettledeck/scripts/zd setup
```

You can add the second tool later — re-run `zd setup` and it picks up the new directory without disturbing the existing wiring.

## `zd install`

Reads `.zettledeck/zettledeck.yml`, clones each declared module, and copies its assets into the project.

Step-by-step:

1. Reads module declarations from `.zettledeck/zettledeck.yml`.
2. Clones each module to a temp directory.
3. Copies assets into `.shared/` and project root per the asset-contribution rules.
4. Merges `module-config.json` entries into `.zettledeck/core/config.json` (additive — skips entries already registered).
5. Merges `mcp.json` server definitions into `.shared/settings/mcp.json` (additive — skips duplicates with warnings).
6. Copies `init-steps.md` to `.zettledeck/{module}/init-steps.md`.
7. Copies `note-rules.md` to `.zettledeck/{module}/note-rules.md`.
8. Marks each newly-installed module as `pending` in `.zettledeck/init-state.yml`.
9. Auto-wires any new Kiro agents.
10. Cleans up temp files.

After install, run `/zettledeck.init` in your agentic tool to walk through each newly-installed module's configuration wizard.

## `zd update`

Refreshes installed modules from their sources. Uses the same asset pipeline as install, but with different merge rules to respect what the user and other modules own:

- Skills, agents, steering, templates, scripts, init-steps, note-rules, providers — **overwritten** by the module's latest version.
- `module-config.json` entries — replaced only where `source` matches the module being updated. Entries tagged `source: "custom"` or owned by another module are never touched. Fields listed in `preserveUserFields` (like `enabled` or `folder`) keep their current values.
- `mcp.json` servers — additive only; duplicates skip with warnings.
- `scaffolding/` — non-destructive; creates missing directories and files but never overwrites.

See [[building-modules/module-config|`module-config.json`]] for the source ownership model in detail.

## `zd status`

Diagnostic view of the current project. Shows:

- Path to the module config file and how many modules are declared
- Installed skills (with names)
- Installed agents (with names)
- Installed steering files (with names)
- Registered MCP servers (with their backing command)
- Registered providers (with capability and source)
- Init state — which modules have been initialized and when; which are pending
- Document types registered in `core/config.json` (with prefix, name, source)
- Tool wiring state — whether `.claude/` and `.kiro/` are wired correctly

When something seems off (a skill isn't loading, an agent isn't responding, a module install feels incomplete), `zd status` is the first place to look.

## Module declaration format

`.zettledeck/zettledeck.yml` is the module manifest. Minimal format:

```yaml
modules:
  - name: zettledeck-praxis
    repo: github.com/strye/zettledeck-praxis
    ref: main

  - name: zettledeck-ideation
    repo: github.com/strye/zettledeck-ideation
    ref: main
```

| Field  | Required | Description                                                              |
| ------ | -------- | ------------------------------------------------------------------------ |
| `name` | yes      | The module name — used in log output and as the directory name under `.zettledeck/` |
| `repo` | yes      | Either a GitHub short form (`github.com/user/repo`) or a full git URL   |
| `ref`  | no       | Branch, tag, or commit. Defaults to `main`.                              |

For private repos and non-GitHub hosts, use a full git URL:

```yaml
modules:
  - name: internal-tools
    repo: git@github.com:example-org/internal-tools.git
    ref: main

  - name: corp-integration
    repo: https://internal.example.com/repos/corp-integration.git
    ref: v1.2.0
```

`zd` passes the URL verbatim to `git clone` when it doesn't match the GitHub short form. Authentication uses your existing git credential helpers — `zd` doesn't manage credentials.

## What a module can contribute

The assets a module repository can include. For each, install and update behavior:


| Path in module       | Installed to                                        | Behavior                                                                            |
| -------------------- | --------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `skills/`            | `.shared/skills/`                                   | Copied as subdirectories; existing skills skipped on install, overwritten on update |
| `agents/`            | `.shared/agents/`                                   | Copied as `.md` files                                                                |
| `steering/`          | `.shared/steering/`                                 | Copied as `.md` files                                                                |
| `templates/`         | `.shared/templates/`                                | Copied; never overwrites existing user content                                      |
| `scripts/`           | `.zettledeck/scripts/`                              | Copied and made executable                                                          |
| `scaffolding/`       | Project root                                        | Non-destructive recursive copy — creates missing dirs/files, never overwrites      |
| `providers/`         | `.zettledeck/providers/`                            | Copied as `.md` files                                                                |
| `mcp.json`           | `.shared/settings/mcp.json`                         | MCP servers merged by name; duplicates skipped with diff warning                    |
| `module-config.json` | Merged into `.zettledeck/core/config.json`          | Source-tagged entries; user-owned fields preserved on update                        |
| `init-steps.md`      | `.zettledeck/{module}/init-steps.md`                | Discovered by `/zettledeck.init`                                                    |
| `note-rules.md`      | `.zettledeck/{module}/note-rules.md`                | Module-owned rules for note placement                                               |

For full author guidance on each of these, see the [[building-modules/README|Building Modules]] guide.

## Requirements

- **`git`** — pre-installed on most systems
- **`jq`** — JSON query tool, used by some init operations
- **`yq`** — YAML query tool, used throughout by `zd`
- **`bash`** — `zd` is a bash script

Run `.zettledeck/scripts/bootstrap` once on a new machine — it detects your platform and installs `jq` and `yq` automatically via Homebrew, apt, or equivalent.

### Windows

`zd` uses bash and symlinks. Native Windows doesn't support either cleanly, so Windows users need **WSL** (Windows Subsystem for Linux). Install a Linux distribution via WSL, clone your ZettleDeck project inside WSL's filesystem (not via `/mnt/c/`), and run `zd` from the WSL shell. Your agentic tools can still run on Windows side — they just read the symlinked directories through WSL.

## Troubleshooting

**"yq: command not found"**
Run `.zettledeck/scripts/bootstrap`. If that fails, install manually: `brew install yq` on macOS, see the [yq releases page](https://github.com/mikefarah/yq/releases/latest) for other platforms.

**"Failed to clone {repo}"**
Check the URL (ensure the `repo:` field is right) and that your git credentials can access the repo. For private repos, verify your SSH key or credential helper is configured.

**"{asset} already exists. Skipping."**
Expected behavior on `zd install` when re-running. To force a refresh, use `zd update` — it's idempotent and preserves user-owned fields.

**A skill doesn't load after install**
Run `zd status`. If the skill is listed, the issue is on the agentic tool side — check the tool's skill-loading state. If it's not listed, the module didn't install cleanly; check `zd install` output for errors and verify the module actually contains a `skills/` directory.

**MCP server conflict warning**
Two modules registered the same server name. Open `.shared/settings/mcp.json`, look for the server, and reconcile by hand. `zd` deliberately doesn't auto-merge conflicting MCP configs because they often differ in consequential ways.

**Wiring looks wrong in `zd status`**
Re-run `zd setup`. It's idempotent — running it twice won't cause duplication.

---

**Next reading:**

- [[README|zettledeck-core Reference]] — back to the core reference index
- [[skills|Core skills]] — the four skills that ship with core
- [[configuration|Configuration]] — the schema that `zd install` merges module config into
- [[building-modules/README|Building Modules]] — for authors creating modules that `zd` will install
