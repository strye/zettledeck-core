---
title: Building Modules
description: The module author's guide to extending ZettleDeck — what a module is, how it's laid out, and where to find the reference for each asset type.
---

# Building Modules

For authors extending ZettleDeck. This guide covers every file a module can contain, what each file does, the format each one takes, and exactly how `zd install` and `zd update` process them.

If you are looking for how the framework itself is structured, read [[theWay|The Way]] and [[vault-structure|Vault Structure]] first. Modules extend both — they add workspaces, skills, document types, and providers on top of what core ships.

## What a module is

A ZettleDeck module is a git repository that contributes assets to a ZettleDeck project when installed. A project declares which modules it uses in `.zettledeck/zettledeck.yml`, and `zd install` clones each module and copies its assets into the right places.

Modules are the unit of distribution. They are the unit of update. They are the boundary of ownership. If you're adding a new capability to ZettleDeck — a new workspace, a new skill family, integration with an external service — it belongs in a module.

## Module root layout

```
{module-name}/
├── module-config.json      # Config sections merged into core/config.json
├── note-rules.md           # Placement, delegation, and exclusion rules for the note skill
├── init-steps.md           # Initialization wizard steps for /zettledeck.init {module}
├── mcp.json                # MCP server definitions
├── skills/                 # Skill directories
│   └── {skill-name}/
│       ├── SKILL.md
│       └── resources/
├── agents/                 # Agent definition files
├── steering/               # Always-on steering files
├── templates/              # Template files
├── scripts/                # Shell scripts
├── scaffolding/            # Directory/file structure to create at project root
└── providers/              # Capability providers (email, calendar, etc.)
```

All files and directories are optional. Include only what the module needs. A minimal module is a single `module-config.json` with one registered docType. A maximal module might include all of the above.

## The guide pages

This guide is split across several pages. Start with whichever page matches what you're building.

### The core file

- [[module-config|`module-config.json`]] — config merging, supported sections, source ownership, `preserveUserFields`. The hardest file to get right and the most important one.

### Behavioral assets

- [[skills-and-agents|Skills & Agents]] — `skills/`, `agents/`, `steering/`. The files that give your module its behavior.

### Project assets

- [[project-assets|Templates, Scaffolding & Scripts]] — `templates/`, `scaffolding/`, `scripts/`. The files that land on disk verbatim.

### External integrations

- [[integrations|MCP Servers & Providers]] — `mcp.json`, `providers/`. Connecting to external services.

### User-facing configuration

- [[user-config|Init & Note Rules]] — `init-steps.md` and `note-rules.md`. What users see during setup and day-to-day note creation.

### Guidance

- [[conventions|Conventions & Composition]] — naming, placeholder markers, optional dependency detection. The rules that keep modules composable.
- [[reference|Reference & Checklists]] — the full install/update behavior matrix, checklists for new and updated modules, publishing and versioning notes.

---

**Next reading outside this guide:**

- [[theWay|The Way]] — what modules are building on top of
- [[vault-structure|Vault Structure]] — what `documentTypes` entries in `module-config.json` hook into
- [[modules/core/zd-script|The `zd` Script]] — the composer that processes everything in this guide
- [[modules/core/configuration|Configuration]] — the `.zettledeck/core/config.json` schema your `module-config.json` merges into
