# zettledeck-core

A project template for ZettleDeck — a structured markdown system for personal knowledge management, built on Obsidian.

## What This Is

ZettleDeck organizes knowledge using a hierarchical vault structure with consistent frontmatter, naming conventions, and task management. Clone this template to start a new vault project. It includes:

- **Vault steering** — structural rules (`vault-steering.md`) and customizable defaults (`vault-defaults.md`) for document types, hierarchical addressing, placement, and frontmatter
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
├── .shared/                        # Shared assets (hidden from Obsidian)
│   ├── skills/
│   │   ├── markdown.conventions/   # Reference — vault markdown rules
│   │   ├── task.management/        # Reference — task format and archival
│   │   ├── obsidian.vault/         # Invocable — CLI vault operations
│   │   │   └── resources/
│   │   │       ├── vault-steering.md   # Structural rules (static)
│   │   │       └── vault-defaults.md   # Customizable config
│   │   └── zettledeck.init/        # Invocable — interactive project setup
│   │       └── resources/
│   │           └── core.md
│   ├── agents/                     # Agent definitions
│   ├── steering/                   # Steering files
│   └── templates/                  # Template files
├── .zettledeck/                    # Infrastructure (hidden from Obsidian)
│   ├── zettledeck.yml              # Add-on module manifest
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
  - name: zettledeck-almanac
    repo: github.com/strye/zettledeck-almanac
    ref: main
```

### Requirements

- `git`
- `yq` — install with `brew install yq`

## Skills

### markdown.conventions (reference)

Loaded automatically when working with markdown files. Defines:
- Obsidian compatibility (wikilinks, CommonMark)
- Frontmatter structure and preservation rules
- Status value lifecycle
- Editing practices

### task.management (reference)

Loaded automatically when creating or modifying tasks. Defines:
- Obsidian Tasks emoji signifiers (➕ 📅 ⏳ 🛫 ✅ ❌)
- Priority signifiers (⏫ 🔼 🔽)
- Attribution patterns for meeting and email sources
- Waiting-for item format
- Archival conventions (14-day threshold)

Archive and inbox paths are project-specific. Configure during `/zettledeck.init core`.

### obsidian.vault (invocable)

Full CLI interface to the Obsidian vault. Invoke with `/obsidian.vault [mode]`.

**Modes:** `search`, `read`, `create`, `append`, `prepend`, `move`, `rename`, `delete`, `open`, `tags`, `links`, `backlinks`, `orphans`, `deadends`, `unresolved`, `tasks`, `properties`, `files`, `folders`, `outline`, `recents`, `vault`, `eval`

**Requirements:** Obsidian 1.12.4+, running in background, CLI registered.

### zettledeck.init (invocable)

Interactive project setup. Invoke with `/zettledeck.init`.

```
/zettledeck.init              Run all available init steps
/zettledeck.init core         Core setup only
/zettledeck.init <module>     Module-specific setup
/zettledeck.init status       Show what's configured
```

Covers: vault identity, folder structure, document types, task paths, naming conventions. Each installed module can contribute its own init steps.

## Vault Steering

Split into two files inside the `obsidian.vault` skill:

- `resources/vault-steering.md` — the structural engine (addressing, front-matter spec, tag rules, validation). Stays static.
- `resources/vault-defaults.md` — customizable document types, folder structure, naming conventions. Personalized during `/zettledeck.init core`.

The defaults file includes `<!-- CUSTOMIZE -->` comments at the sections to modify:

1. **Section 1** — Document types and prefix configuration
2. **Section 2** — Top-level folder structure

## Available Modules

| Module | Purpose | Repo |
|--------|---------|------|
| **zettledeck-core** | Foundation — conventions, vault skill, compose tool | (this repo) |
| **zettledeck-almanac** | Personal organizer — diary, email, priorities | Coming soon |
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
