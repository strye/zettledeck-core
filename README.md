# zettledeck-core

The foundation module for ZettleDeck — a structured markdown system for personal knowledge management, built on Obsidian.

## What This Is

ZettleDeck organizes knowledge using a hierarchical vault structure (Scope → Focus → Project → documents) with consistent frontmatter, naming conventions, and task management. This core module provides:

- **Vault steering template** — the structural framework for organizing your Obsidian vault (document types, hierarchical addressing via Zettldex, placement rules, frontmatter spec)
- **Markdown conventions** — rules for frontmatter management, wikilinks, editing practices, and status values
- **Task management** — Obsidian Tasks plugin format with emoji signifiers, attribution patterns, priority levels, and archival conventions
- **Obsidian vault skill** — CLI-based vault interaction (search, read, create, append, move, tags, links, tasks, properties)
- **Project initialization** — interactive setup skill (`/zettledeck.init`) that walks you through customizing all configuration
- **Compose tooling** — the `zd` script for installing and linking ZettleDeck modules

## Quick Start

### New Project

```bash
# 1. Copy the zd script somewhere on your PATH
cp scripts/zd /usr/local/bin/zd

# 2. In your new project directory
cd ~/my-vault
zd init

# 3. Edit zettledeck.yml to configure your modules

# 4. Install
zd install

# 5. Run interactive setup
/zettledeck.init
```

### What `zd install` Does

1. Clones each declared module into `.zettledeck/modules/`
2. Symlinks skill directories into `.shared/skills/`
3. Symlinks agent definitions into `.claude/agents/`
4. Copies template files (like `vault-steering.md`) to project root (won't overwrite existing)

### Module Configuration

Edit `zettledeck.yml` in your project root:

```yaml
modules:
  - name: zettledeck-core
    repo: github.com/strye/zettledeck-core
    ref: main
  - name: zettledeck-almanac
    repo: github.com/strye/zettledeck-almanac
    ref: main
  # Add more modules as needed
```

### Updating

```bash
zd update    # Pull latest for all modules and re-link
zd status    # See what's installed and linked
zd link      # Re-link without pulling (after manual changes)
```

## Project Structure

```
zettledeck-core/
├── skills/
│   ├── markdown.conventions/   # Reference skill — vault markdown rules
│   │   ├── SKILL.md
│   │   └── rules.md
│   ├── task.management/        # Reference skill — task format and archival
│   │   ├── SKILL.md
│   │   └── rules.md
│   ├── obsidian.vault/         # Invocable skill — CLI vault operations
│   │   └── SKILL.md
│   └── zettledeck.init/        # Invocable skill — interactive project setup
│       ├── SKILL.md
│       └── resources/
│           └── core.md         # Core module init steps
├── templates/
│   └── vault-steering.md       # Vault organization template (customize for your vault)
├── scripts/
│   └── zd                      # Module composer CLI
└── README.md
```

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

**Note:** Archive and inbox paths are project-specific. Configure `task.actions_inbox` and `task.archive_path` in your project's CLAUDE.md.

### obsidian.vault (invocable)

Full CLI interface to the Obsidian vault. Invoke with `/obsidian.vault [mode]`.

**Modes:** `search`, `read`, `create`, `append`, `prepend`, `move`, `rename`, `delete`, `open`, `tags`, `links`, `backlinks`, `orphans`, `deadends`, `unresolved`, `tasks`, `properties`, `files`, `folders`, `outline`, `recents`, `vault`, `eval`

**Requirements:**
- Obsidian 1.12.4+
- Obsidian running in background
- CLI registered: Settings → General → Command line interface → Register CLI

### zettledeck.init (invocable)

Interactive project setup that walks you through all configuration. Invoke with `/zettledeck.init`.

```
/zettledeck.init              Run all available init steps
/zettledeck.init core         Core setup only
/zettledeck.init <module>     Module-specific setup
/zettledeck.init status       Show what's configured
```

Covers: vault identity, folder structure, scope subTypes, task inbox/archive paths, document naming, and document type selection. Each installed module can contribute its own init steps — the skill discovers them automatically.

## Vault Steering Template

The `templates/vault-steering.md` file provides the structural framework for your vault. You can customize it manually or use `/zettledeck.init core` for an interactive walkthrough.

The template includes `<!-- CUSTOMIZE -->` comments at the sections you should modify:

1. **Section 5** — Document subTypes per vault area
2. **Section 8** — Top-level folder structure

## Available Modules

| Module | Purpose | Repo |
|--------|---------|------|
| **zettledeck-core** | Foundation — conventions, vault skill, compose tool | (this repo) |
| **zettledeck-almanac** | Personal organizer — diary, email, priorities | Coming soon |
| **zettledeck-nexus** | Knowledge intelligence — vault analysis, ideas, reflection | Coming soon |
| **zettledeck-foundry** | Content creation — research, composition, versioning | Coming soon |
| **rostrum-blackboard** | Human-conducted blackboard orchestration | Coming soon |

## Tool Compatibility

ZettleDeck skills work with any AI coding tool that supports the `.shared/skills/` convention:
- **Claude Code** — reads from `.shared/skills/` via `.claude/` symlinks
- **Kiro IDE** — reads from `.shared/skills/` via `.kiro/` symlinks

The `zd` script creates symlinks for Claude Code by default. For Kiro, create an additional symlink:
```bash
ln -s .shared/skills .kiro/skills
```

## License

MIT
