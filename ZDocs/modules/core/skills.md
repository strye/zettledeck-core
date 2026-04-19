---
title: Core Skills
description: Detailed reference for the four skills zettledeck-core ships — zettledeck, zettledeck.init, markdown, and vault.
---

# Core Skills

The six skills that ship with `zettledeck-core`. Two are user-invocable (`zettledeck`, `zettledeck.init`) — summoned with a slash command. Two are invocable knowledge-intelligence skills (`nexus`, `insight`). Two are background references (`markdown`, `vault`) that the assistant loads automatically when the relevant context is active.

## How skills are wired in

Skills live in `.shared/skills/{skill-name}/` and are symlinked into the agentic tool by `zd setup`:

- **Claude Code** reads `.claude/skills → ../.shared/skills`.
- **Kiro** reads `.kiro/skills → ../.shared/skills`.

Both tools discover skills by scanning that directory and reading each skill's `SKILL.md` frontmatter. The `description` field in frontmatter tells the tool *when* to auto-trigger the skill, so a well-written description is what makes a skill reliable.

Modules can add their own skills; see [[building-modules/skills-and-agents|Skills & Agents]] for authoring guidance.

## `zettledeck` — methodology + promote

**Type:** invocable + reference
**Invocation:** `/zettledeck help [question]` or `/zettledeck promote [file]`

The methodology skill. It holds the vault-structure knowledge (addressing, frontmatter rules, document types, placement) and handles the single most structurally complex operation in ZettleDeck: promoting content from a workspace into the Reliquary.

### Modes

**`help`** — conversational Q&A about ZettleDeck concepts, workflow, and vault structure. Loads `resources/help.md`. Auto-triggers when the user asks about ZettleDeck concepts, mentions a workspace folder by name, or seems confused about vault structure or placement. Answers plainly first, then follows up with specifics and a pointer to the source document if deeper reading is warranted.

**`promote`** — moves a document from a workspace into the Reliquary with full vault structure applied. The three phases:

1. **Read and Infer** — reads the source, infers title, docType, subType, existing scope membership, and proposes a scopeId.
2. **Propose and Confirm** — presents a promotion proposal (scope, zettldex, destination path, filename) and asks for confirmation before proceeding.
3. **Apply** — writes updated frontmatter, moves the file, creates a new scope document if needed, increments the appropriate `nextId` counter.

Follows the recommend-first principle — nothing moves without user approval.

### Resource files

All loaded on demand rather than all at once:

| Resource | When to load |
|----------|-------------|
| `resources/help.md` | User asks a question about ZettleDeck concepts or workflow |
| `resources/promote.md` | User wants to promote a file to the document repository |
| `resources/the-way.md` | Deep philosophy questions, workspace flow, system design rationale |
| `resources/vault-steering.md` | Structural rules — addressing, frontmatter, tags, placement, validation |
| `resources/vault-defaults.md` | Document types, prefixes, subTypes, folder structure, naming patterns |

Other skills that need vault structure context load `vault-steering.md` and `vault-defaults.md` directly — the `zettledeck` skill acts as the authoritative source for those rules.

### Configuration

The skill reads `.zettledeck/core/config.json` at the start of any operation. Key values:

- `workspaceFolders` — resolves the document repository by finding the entry where `role == "documentRepo"`
- `scopeMethod` — `assignedRanges` or `incremental`
- `repositoryFolders` — internal partitions inside the document repository
- `prefixesEnabled` — whether filenames use single-letter type prefixes

See [[configuration|Configuration]] for the full schema.

## `zettledeck.init` — interactive project setup

**Type:** invocable
**Invocation:** `/zettledeck.init [mode]`

The setup wizard. Writes to `.zettledeck/{module}/config.json` files so users don't have to hand-edit configuration.

### Modes


| Mode                                 | Purpose                                                                                       |
| ------------------------------------ | --------------------------------------------------------------------------------------------- |
| `/zettledeck.init`                   | Run all available init steps — core plus any installed modules                               |
| `/zettledeck.init core`              | Core setup only — vault structure, scope ID method, document naming                           |
| `/zettledeck.init <module>`          | Run init steps for a specific installed module (e.g., `praxis`, `nexus`)                      |
| `/zettledeck.init status`            | Show what has been configured and what still needs setup                                      |
| `/zettledeck.init list`              | Show the mode list in-terminal                                                                |
| `/zettledeck.init folders`           | Show the current top-level folder structure                                                   |
| `/zettledeck.init add-folder`        | Add a workspace folder or repository partition                                                |
| `/zettledeck.init remove-folder`     | Remove a folder entry (subject to the `required` flag)                                        |
| `/zettledeck.init sync-ids`          | Scan the vault and correct all `nextId` values in config                                      |
| `/zettledeck.init doc-types`         | Show all registered document types                                                            |
| `/zettledeck.init add-doc-type`      | Add a new document type                                                                       |
| `/zettledeck.init remove-doc-type`   | Remove a document type                                                                        |

### How module discovery works

The skill discovers available init modules by scanning `.zettledeck/*/init-steps.md`. When you install a module via `zd install`, its `init-steps.md` gets copied to `.zettledeck/{module}/init-steps.md`, and `/zettledeck.init` finds it automatically. You never have to register a module with the init skill — it's file-existence-driven.

When you run `/zettledeck.init` with no argument, the skill lists the available modules and asks whether to run all or pick one.

### The key rule: init writes only to config files

`/zettledeck.init` writes *only* to `.zettledeck/` config files, provider files, `CLAUDE.md`, and `init-state.yml`. **Skill files under `.claude/skills/` or `.kiro/skills/` are never modified.** Skill files contain `{placeholder}` tokens that are resolved at runtime by reading the corresponding config.

This separation is why modules can be updated from source without overwriting project-specific configuration — your config is yours, the skills belong to the module.

### Interaction model

Each configuration section follows the same pattern:

1. **Explain** what's being configured and why it matters
2. **Show** the current value or default
3. **Ask** the user for their preference (offering a sensible default)
4. **Apply** the change to the appropriate file
5. **Confirm** what was written

Follows the recommend-first principle throughout.

### State tracking

After initialization, the skill writes `.zettledeck/init-state.yml` to track what's been configured:

```yaml
initialized:
  core: 2026-03-22
  praxis: 2026-03-22
pending:
  - nexus
```

`/zettledeck.init status` reads this file to report what's done and what still needs setup.

## `markdown` — markdown and task conventions

**Type:** reference (not user-invocable)
**Auto-loads when:** creating or editing any markdown file, working with tasks

Defines the conventions that keep markdown files consistent across the vault:

- **Markdown rules** — CommonMark-compatible, wikilink syntax (`[[filename]]`), YAML frontmatter structure, preservation rules for existing fields
- **Task format** — the emoji signifiers used by the Obsidian Tasks plugin (`➕` created, `📅` due, `⏳` scheduled, `🛫` start, `✅` done, `❌` cancelled), priority markers (`⏫` high, `🔼` medium, `🔽` low), attribution patterns (`*(from: source, date)*`), waiting-for format (`@person:` prefix), RP alignment tags (`#rp/priority-name`)
- **Status values** — the content lifecycle (draft → in-review → revised → published → archived) plus general status values (active, steady, hold, archived, na)

### Task format example

```
- [ ] Draft architecture proposal *(from: Acct Review, Tuesday)* ⏫ ➕ 2026-03-08 📅 2026-03-14
```

Field order: description, attribution, priority, dates. Dates in order: created, scheduled, start, due.

Waiting-for items use `@person:` at the start of the description to distinguish them from owned actions:

```
- [ ] @Kate: Send updated timeline *(from: Standup, Monday)* ➕ 2026-03-08 📅 2026-03-14
```

Complete format rules are in `.shared/skills/markdown/task-format.md`. The format is compatible with the Obsidian Tasks plugin but not *dependent* on it — any markdown tool can read and write these files.

### Configuration

None. The markdown rules are universal; task paths are configured by the `zettledeck-praxis` module.

## `vault` — file-level vault analysis

**Type:** reference (not user-invocable)
**Auto-loads when:** another skill needs vault-wide file analysis

The shared infrastructure skill that provides vault analysis operations. It emits TSV to stdout; calling skills do their own reasoning on the data.

### Operations


| Operation                           | What it does                                                                                              |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `vault link-graph <vault-root>`     | Build a wikilink graph — outputs `source`, `target`, `weight` columns                                     |
| `vault temporal-inventory <root>`   | Build a time-ordered inventory — outputs `date`, `file`, `doctype`, `status`, `word_count`                |
| `vault stats <vault-root>`          | Structural statistics — total files, word count, unique doctypes/statuses, orphans, date range, and more  |

All three operations accept `--scope <folder>` to restrict to a subfolder; `link-graph` accepts `--min-weight`; `temporal-inventory` accepts `--since`/`--until`; `stats` accepts `--format tsv|text`.

### Invocation rule

Other skills must invoke vault operations **by name**, never by script path. The `vault` skill manages which scripts back each operation; callers don't need to know where the scripts live.

Scripts live in `.shared/skills/vault/scripts/`. If the implementation of an operation changes, only the `vault` skill has to update — every caller continues to work unchanged.

### Used by

Primarily by the `nexus` and `insight` skills — the vault-analysis modes (`lint`, `map`, `connect`, `link`, `trace`, `orient`, `scan`, `align`) all build on these three primitives.

## `nexus` — knowledge intelligence

**Type:** invocable
**Invocation:** `/nexus {mode} [arguments]`

The knowledge intelligence skill. Builds and maintains a persistent, compounding knowledge base from raw sources (the Karpathy LLM Wiki pattern), and analyzes the wider vault for patterns, connections, and structural health.

Nexus operates on two scopes:

- **Knowledge base scope** (`ingest`, `query`, `lint`, `discover`): reads and writes pages inside the Nexus workspace. These modes manage the LLM-owned knowledge base.
- **Vault-wide scope** (`connect`, `trace`, `map`, `link`): reads across the entire vault to analyze patterns, connections, and topology.

### Modes

| Mode | Scope | Description |
|------|-------|-------------|
| `ingest` | Nexus | Process a source: summarize, cross-reference, update index/log |
| `query` | Nexus | Search the knowledge base, synthesize an answer with citations |
| `lint` | Nexus | Health-check: contradictions, orphans, stale claims, missing links |
| `discover` | Nexus | Surface emergent ideas from accumulated knowledge |
| `connect` | Vault | Find hidden bridges between two named domains |
| `trace` | Vault | Track how an idea evolved over time |
| `map` | Vault | Analyze vault topology — clusters, hubs, orphans, gaps |
| `link` | Vault | Score and recommend strategic connections |
| `init` | Nexus | Interactive setup: customize structure, page types, conventions |
| `help` | — | Display quick reference |

### Knowledge base structure

```
Nexus/
├── NEXUS.md        — schema (conventions, page types, workflows)
├── index.md        — content catalog (updated on every ingest)
├── log.md          — chronological activity record
├── raw/            — immutable source documents
└── pages/          — LLM-generated pages
    ├── sources/
    ├── entities/
    ├── concepts/
    └── synthesis/
```

Structure is customizable via `nexus init`. Skills operate on defaults if `NEXUS.md` is absent.

### Key constraint

The LLM never modifies files in `raw/` (immutable source of truth), never deletes pages without explicit approval, and never modifies content in files outside the Nexus root. Metadata enhancements outside the Nexus root (wikilinks, frontmatter, cross-references) are permitted with explicit user approval per operation.

---

## `insight` — vault pattern intelligence

**Type:** invocable
**Invocation:** `/insight {mode} [arguments]`

Surfaces what your accumulated vault is pointing toward — the ideas, depth gaps, and leverage points that your knowledge implies but hasn't stated. Operates across workspace folders configured in `.zettledeck/core/config.json`.

### Modes

| Mode | Description |
|------|-------------|
| `ideate` | Surface implied ideas and generate new ones from vault patterns; accepts role arguments to scope by workspace |
| `score` | Assess execution readiness of accumulated ideas — 4-dimension scoring |
| `learn` | Find 3-7 high-leverage skills where 50-100hr investment produces step-function returns across 3+ domains |
| `scan` | Survey knowledge depth across all domains — produces a ranked compound depth map |
| `temporal` | Show how accumulated context improves answer quality over time |
| `orient` | Systematically read the vault to build deep context before starting work |

### Idea Strength scale

`ideate` output includes an Idea Strength rating (1–4):

- **1 — Signal**: weak evidence, seen once or twice
- **2 — Forming**: recurring pattern across multiple entries
- **3 — Developed**: strong cross-domain evidence, clear shape
- **4 — Ready**: execution-ready, next steps are obvious

### Configuration

`insight ideate` reads `workspaceFolders` from `.zettledeck/core/config.json` to resolve role → folder path. Other modes use vault path placeholders (`{diary-path}`, `{rp-path}`) configured by the `praxis` module.

---

## Adding your own skills

Skills are module assets. To add a skill:

- **Add it to an existing module** if it extends that module's domain.
- **Create your own module** for a self-contained collection of skills you want distributed separately.

See [[building-modules/skills-and-agents|Skills & Agents]] for authoring guidance — frontmatter, mode routing, the `description` field that controls auto-triggering, and how skills read runtime configuration.

---

**Next reading:**

- [[README|zettledeck-core Reference]] — back to the core reference index
- [[configuration|Configuration]] — the `.zettledeck/core/config.json` schema that core skills read
- [[building-modules/skills-and-agents|Skills & Agents]] — for authors building new skills
- [[vault-structure|Vault Structure]] — the rules that the `zettledeck` skill enforces
