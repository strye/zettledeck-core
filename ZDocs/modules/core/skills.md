---
title: Core Skills
description: Detailed reference for the four skills zettledeck-core ships — zettledeck, zettledeck.init, markdown, and vault.
---

# Core Skills

The four skills that ship with `zettledeck-core`. Two are invocable (`zettledeck`, `zettledeck.init`) — you summon them with a slash command. Two are background references (`markdown`, `vault`) that the assistant loads automatically when the relevant context is active.

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

**`promote`** — moves a document from a workspace (Atelier, Chrysalis, Foundry, etc.) into the Reliquary with full vault structure applied. The three phases:

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

Primarily by the `nexus` and `insight` skills in `zettledeck-nexus` — the vault-analysis modes (`lint`, `map`, `connect`, `link`, `trace`, `orient`, `scan`, `align`) all build on these three primitives.

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
