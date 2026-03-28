# zettledeck-core

A project template for ZettleDeck — a structured markdown system for personal knowledge management, built on Obsidian.

## What This Is

ZettleDeck is an opinionated knowledge management framework for Obsidian, built on the spirit of [Zettelkasten](https://en.wikipedia.org/wiki/Zettelkasten). It organizes knowledge through metadata and connections rather than rigid folder hierarchies — documents can live anywhere in the vault and remain meaningfully grouped through shared scope IDs.

Clone this template to start a new vault project. It includes:

- **Scope-based organization** — every document belongs to a scope, linked by a shared `scopeId`. Physical location in the vault is flexible; relationships are carried by metadata.
- **Vault steering** — structural rules and reference documentation for document types, hierarchical addressing, placement, and frontmatter
- **Markdown conventions** — rules for frontmatter management, wikilinks, editing practices, and status values
- **Task management** — Obsidian Tasks plugin format with emoji signifiers, attribution patterns, priority levels, and archival conventions
- **Obsidian vault skill** — CLI-based vault interaction (search, read, create, append, move, tags, links, tasks, properties)
- **Project initialization** — interactive setup skill (`/zettledeck.init`) that walks you through customizing all configuration
- **Module composer** — the `zd` script for installing add-on modules

## Quick Start

```bash
# 1. Clone the template
git clone https://github.com/strye/zettledeck-core.git my-vault
cd my-vault

# 1.3 OPTIONAL Remove the `.git` folder and revision history
# rm -rf .git

# 2. Wire up your AI tool so core skills are visible
#    (Create `.claude` and/or `.kiro` folder(s) first)
.zettledeck/scripts/zd setup

# 3. Run core init (in Claude Code or Kiro) — configures vault identity,
#    folder structure, task paths. Modules need this context.
/zettledeck.init core

# 4. Add add-on modules to .zettledeck/zettledeck.yml, then install them
#    (automatically wires any new agents — no need to re-run zd setup)
.zettledeck/scripts/zd install

# 5. Run module init (in Claude Code or Kiro) — discovers and configures
#    module-specific settings now that their init-steps are available
/zettledeck.init
```

## Project Structure

```
my-vault/
├── .shared/                        # Shared assets (hidden from vault)
│   ├── skills/
│   │   ├── markdown/               # Reference — markdown conventions + task format
│   │   ├── zettledeck/             # Core methodology — help, promote, vault rules
│   │   │   └── resources/
│   │   │       ├── vault-steering.md   # Structural rules (static)
│   │   │       ├── vault-defaults.md   # Reference docs for document types
│   │   │       └── the-way.md          # System philosophy and workspace flow
│   │   └── zettledeck.init/        # Invocable — interactive project setup
│   │       └── resources/
│   │           └── core.md
│   ├── agents/                     # Agent definitions
│   ├── steering/                   # Steering files
│   └── templates/                  # Template files
├── .zettledeck/                    # Infrastructure (hidden from vault)
│   ├── zettledeck.yml              # Add-on module manifest
│   ├── core/
│   │   └── config.json             # Vault configuration (edit directly or via init)
│   ├── init-state.yml              # Init tracking (created by /zettledeck.init)
│   └── scripts/
│       └── zd                      # Module composer CLI
├── .claude/                        # Claude Code wiring (created by zd setup)
│   ├── skills → ../.shared/skills
│   └── agents → ../.shared/agents
├── .kiro/                          # Kiro wiring (created by zd setup)
│   ├── skills → ../.shared/skills
│   ├── steering → ../.shared/steering
│   └── agents/                     # Individual symlinks + generated JSON
├── Reliquary/                      # The vault — permanent structured knowledge
└── README.md
```

## The `zd` Script

Located at `.zettledeck/scripts/zd`. Manages add-on modules and tool wiring.

```bash
zd install   # Install add-on modules from zettledeck.yml
zd update    # Update installed modules to latest
zd setup     # Create tool wiring (Claude Code / Kiro symlinks)
zd status    # Show installed modules and wiring status
```

### What `zd install` Does

1. Reads module declarations from `.zettledeck/zettledeck.yml`
2. Clones each module to a temp directory
3. Copies assets into `.shared/` (skills, agents, steering, templates)
4. Copies module scripts into `.zettledeck/scripts/`
5. Marks each module as `pending` in `.zettledeck/init-state.yml`
6. Auto-wires any new Kiro agents (symlinks + JSON companions)
7. Cleans up temp files

### What `zd setup` Does

One-time wiring that connects AI tools to `.shared/`. Run once after cloning; `zd install` handles subsequent agent wiring automatically.

- **Claude Code**: symlinks `.claude/skills` and `.claude/agents` to `.shared/`, checks `CLAUDE.md` for steering references
- **Kiro**: symlinks `.kiro/skills` and `.kiro/steering` to `.shared/`, creates individual agent symlinks with companion JSON files

### Module Configuration

Edit `.zettledeck/zettledeck.yml`:

```yaml
modules:
  - name: zettledeck-praxis
    repo: github.com/strye/zettledeck-praxis
    ref: main
```

### Requirements

- `git`
- `yq` — install with `brew install yq`
- **Windows**: requires WSL (Windows Subsystem for Linux). The `zd` script uses bash and symlinks, which are not natively supported on Windows outside of WSL.

## Skills

### markdown (reference)

Loaded automatically when working with markdown files or tasks. Defines:
- Obsidian compatibility (wikilinks, CommonMark)
- Frontmatter structure and preservation rules
- Status value lifecycle
- Editing practices
- Task format rules (Obsidian Tasks emoji signifiers, priority markers, attribution patterns, waiting-for format, RP alignment tags)

Archive and inbox paths are project-specific. Configure during `/zettledeck.init core`.

### zettledeck (invocable + reference)

Core methodology skill. Provides vault structure reference, conversational help, and content promotion. Other skills draw on `zettledeck/resources/vault-steering.md` and `vault-defaults.md` for document type and placement rules.

```
/zettledeck help [question]   — Answer questions about ZettleDeck concepts
/zettledeck promote [file]    — Promote content to the Reliquary with full vault structure
```

The `promote` workflow reads the source document, infers docType, scope, and placement, then walks through a confirmation wizard before applying frontmatter and moving the file.

**Vault interaction** (search, create, move, tasks, etc.) is provided by the `zettledeck-obsidian` module.

### zettledeck.init (invocable)

Interactive project setup. Two workflows:

1. **Wizard mode:** Run `/zettledeck.init core` to walk through guided setup. Writes `.zettledeck/core/config.json`.
2. **Manual mode:** Edit `.zettledeck/core/config.json` directly. Changes take effect immediately.

```
/zettledeck.init              Run all available init steps
/zettledeck.init core         Core setup wizard
/zettledeck.init <module>     Module-specific setup
/zettledeck.init status       Show what's configured
```

Covers: vault identity, folder structure, document types, task paths, naming conventions. All configuration is stored in `.zettledeck/core/config.json` (user-editable). Each installed module can contribute its own init steps with their own config files.

## The ZettleDeck Methodology

ZettleDeck is built on one core idea: **relationships between documents should be carried by metadata, not folder location**.

### Scopes and ScopeIds

Every document in a ZettleDeck vault has a `scopeId` — a numeric identifier that binds it to a knowledge domain. All documents sharing a `scopeId` belong to the same scope, regardless of where they physically live in the vault.

Each scope has exactly one **scope document** (prefix `S`) — a lightweight overview file that serves as the anchor and entry point for that domain. From it you can navigate every related focus, project, note, and piece of content in the scope.

```
S1001_CareerDevelopment    ← scope document (the anchor)
  F1001_SkillBuilding      ← focus under this scope
  P1001_CertificationPlan  ← project under this scope
  N1001_BookNotes          ← note that could live anywhere
```

All four files share `scopeId: 1001`. The note could be filed under any folder — its metadata connects it back to the scope.

### Why This Matters

In a traditional folder system, moving a document breaks its organizational context. In ZettleDeck, you can reorganize your vault freely — the `scopeId` always preserves the semantic relationship. This is the Zettelkasten principle applied to structured knowledge work: connections over containers.

### Scope ID Methods

How scope IDs are assigned is configurable:

| Method | How it works |
|--------|-------------|
| **assignedRanges** | Each top-level folder owns a numeric range tied to its prefix. `10_Personal/` owns IDs 1000–1999. IDs immediately signal which domain a document belongs to. |
| **incremental** | A single global counter increments for every new scope. Simpler, no range boundaries. |

Configure in `.zettledeck/core/config.json` via `scopeMethod`.

---

## Vault Configuration

All vault configuration is stored in `.zettledeck/core/config.json`:

- **vaultName / vaultPath** — Vault name and location
- **scopeMethod** — `assignedRanges` or `incremental`
- **topLevelFolders** — Top-level folder structure (with ranges if using assignedRanges)
- **scopeSubTypes** — What kinds of scopes live in each folder
- **prefixesEnabled** — Whether to use single-letter prefixes on filenames (e.g., `P1001_ProjectName`)
- **useEngagements** — Enable the optional engagement document type
- **taskInbox / taskArchive / taskArchiveThreshold** — Task management paths and archival window

Edit this file directly, or run `/zettledeck.init core` to walk through the setup wizard.

### Vault Steering Rules

Two files inside the `obsidian` skill define how the vault works:

- `resources/vault-steering.md` — the structural engine (addressing, front-matter spec, tag rules, validation)
- `resources/vault-defaults.md` — reference documentation showing default structure and document types

## Available Modules

| Module | Purpose | Repo |
|--------|---------|------|
| **zettledeck-core** | Foundation — conventions, vault skill, compose tool | (this repo) |
| **zettledeck-praxis** | Daily practice — diary, email, comms, priorities | Coming soon |
| **zettledeck-nexus** | Knowledge intelligence — vault analysis, ideas, reflection | Coming soon |
| **zettledeck-foundry** | Content creation — research, composition, versioning | Coming soon |
| **rostrum-blackboard** | Human-conducted blackboard orchestration | Coming soon |

## Tool Compatibility

ZettleDeck works with AI coding tools that support skill discovery:

- **Claude Code** — `.claude/skills` and `.claude/agents` symlink to `.shared/`; steering referenced in `CLAUDE.md`
- **Kiro IDE** — `.kiro/skills` and `.kiro/steering` symlink to `.shared/`; agents get individual symlinks with companion JSON

Run `zd setup` to configure wiring for your tool automatically.

## License

MIT
