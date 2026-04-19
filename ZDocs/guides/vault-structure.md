---
title: Vault Structure
description: How knowledge is organized inside the Reliquary — scopes, scopeIds, document types, frontmatter, placement, and the Zettelkasten principles that shape all of it.
---

# Vault Structure

The vault is *how knowledge is organized* inside ZettleDeck. It governs every document that has graduated into the [[theWay#Reliquary|Reliquary]] for permanent keeping. If [[theWay|The Way]] explains where work happens, this document explains how finished work is structured once it's worth keeping.

> **A reminder on separation:** Workspaces (Atelier, Chrysalis, Praxis, etc.) are where work *happens*. The vault is how knowledge is *organized*. The Reliquary is the bridge — a workspace whose internal structure *is* the vault. See [[theWay#System vs vault — two separate concerns]] if the distinction isn't yet clear.

## The governing principle

Traditional knowledge systems organize by folder location: the folder tells you what kind of document lives inside it, and moving a document breaks its context. ZettleDeck inverts this.

**Relationships are carried by metadata, not by folder location.** A document's frontmatter — its `scopeId`, `docType`, `zettldex`, `parentFile`, and explicit wikilinks — is what ties it to the knowledge graph. Folders are a hint. You can reorganize freely, and the semantic connections hold.

This is the Zettelkasten principle applied to structured knowledge work. Luhmann's branching index numbers and explicit note-to-note links were doing the same job: binding ideas by relationship, not by shelf. ZettleDeck's scopeIds, zettldex addresses, and wikilinks are the modern equivalent.

Four principles shape every structural rule that follows:

- **Atomicity** — document types correspond to different granularities of thought. A scope is a domain; a focus is a theme; a project is a deliverable; a note is an atom. You choose the granularity that fits the idea.
- **Explicit connection** — wikilinks carry the reason they exist. A link without a "why" is a missed thought.
- **Emergent structure** — the vault's shape grows from the material. You don't design the hierarchy first; you let it accrete and use `/zettledeck.init` to formalize new document types or folders as patterns emerge.
- **Thinking partner** — the [[theWay#Nexus|Nexus]] reads across the vault and surfaces what's hidden. A well-structured vault makes that work possible; a well-maintained vault is what makes it useful.

## Scopes and scopeIds

Every document in the vault has a **`scopeId`** — a 4-digit zero-padded identifier that binds it to a knowledge domain.

- `"0001"`, `"1001"`, `"0999"` — always four digits, always quoted as strings in frontmatter, always zero-padded.
- All documents sharing a `scopeId` belong to the same scope.
- ScopeId membership is independent of folder placement.

Each scope has exactly one **scope document** — prefix `S`, zettldex `{scopeId}.S` — that anchors the domain. It's a lightweight overview file, the entry point from which you can navigate every related focus, project, note, and piece of content in the scope.

```
S1001_CareerDevelopment        ← scope document (the anchor)
  F1001_SkillBuilding          ← focus under this scope
  P1001_CertificationPlan      ← project under this scope
  N1001_BookNotes              ← note that could live anywhere
```

All four share `scopeId: "1001"`. The note could be filed under any folder in the vault — its metadata connects it back to the scope regardless.

### Scope ID methods

How new scopeIds are assigned is configurable. Set `scopeMethod` in `.zettledeck/core/config.json`:


| Method             | How it works                                                                                                                                                                    |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **assignedRanges** | Each top-level folder owns a numeric range tied to its prefix. `10_Personal/` owns IDs 1000–1999. IDs immediately signal which domain a document belongs to. This is the default. |
| **incremental**    | A single global counter increments for every new scope. Simpler, no range boundaries, but IDs carry no domain signal.                                                            |

Both methods honor zero-padding — a counter of `7` becomes scopeId `"0007"`.

Use `/zettledeck.init sync-ids` to scan the vault and reconcile the `nextId` counters in your config with what's actually been used.

## Document types

Every document has a **`docType`** that determines its purpose, its valid parents, its default status, its subTypes, and where it gets placed. Core ships six foundational types; modules can register more; you can register your own with `/zettledeck.init add-doc-type`.

### Core document types

| Prefix | docType     | Granularity                                    | Valid parents                               |
| ------ | ----------- | ---------------------------------------------- | ------------------------------------------- |
| `S`    | `scope`     | Domain anchor — root of a knowledge graph     | — (lives at top level)                      |
| `F`    | `focus`     | Thematic area within a scope                  | scope                                       |
| `P`    | `project`   | Defined work with deliverables                | scope, focus                                |
| `O`    | `objective` | Trackable goal, milestone, or task unit       | scope, focus, project, content              |
| `C`    | `content`   | Produced writing, document, or creative output| scope, focus, project, content              |
| `N`    | `note`      | Miscellaneous notes; `subType: jot` for quick | scope, focus, project, objective, content, meeting |

### Additional types from modules

Installed modules register their own document types via `module-config.json`. Common examples:

- `M` / `meeting` — meeting notes (from `zettledeck-praxis`)
- `I` / `ideation` — brainstorming and idea capture
- `R` / `research` — research and analysis notes

See [[modules/core/configuration|Configuration]] for the `documentTypes` schema and the full list of fields each type declares.

### SubTypes

Each docType declares a list of valid subTypes — secondary keywords that refine the primary type. For a content document, subTypes like `narrative`, `brief`, `presentation`, `plan`, `roadmap`, `requirements` distinguish what *kind* of content. For an objective: `smart`, `milestone`, `todo`, `learn`.

SubTypes matter for routing and filtering. Skills and queries can target "all `content` with `subType: brief`" as a meaningful slice.

### Atomicity by type

The document-type system is how ZettleDeck preserves Zettelkasten's atomicity at the right granularity. A scope is atomic *as a domain*; a focus is atomic *as a theme*; a note is atomic *as a thought*. You choose the granularity that fits — you don't jam a project's worth of material into a note, and you don't fracture a single thought across three files.

## Zettldex — hierarchical addressing

The **`zettldex`** encodes a document's position in the hierarchy as a dotted address:

| Document                    | Zettldex formula       | Example          |
| --------------------------- | ---------------------- | ---------------- |
| scope                       | `{scopeId}.S`          | `1001.S`         |
| focus (child of scope)      | `{parentZettldex}.F`   | `1001.S.F`       |
| project (child of focus)    | `{parentZettldex}.P`   | `1001.S.F.P`     |
| objective (child of project)| `{parentZettldex}.O`   | `1001.S.F.P.O`   |
| content (child of project)  | `{parentZettldex}.C`   | `1001.S.F.P.C`   |
| note (child of project)     | `{parentZettldex}.N`   | `1001.S.F.P.N`   |

The zettldex is Luhmann's branching index number, modernized. It tells you at a glance where a document sits and what it descends from. Derive a child's zettldex by reading the parent's frontmatter and appending `.{prefix}`.

The numeric prefix is always 4 digits, zero-padded — `"0001.S"` not `"1.S"`.

## Filename convention

With prefixes enabled (the default):

```
{PREFIX}{scopeId}_{TitleInPascalCase}.md
```

Examples:

- `S1001_CareerDevelopment.md` — a scope document
- `F1001_SkillBuilding.md` — a focus under that scope
- `P1001_CertificationPlan.md` — a project
- `N1001_BookNotes.md` — a note

With prefixes disabled, the leading letter is omitted. This is a per-project choice set by `prefixesEnabled` in `.zettledeck/core/config.json`.

The filename is a fast visual signal. At a glance you can see docType (`P`), scope membership (`1001`), and subject (`CertificationPlan`) without opening the file.

## Frontmatter

Every vault document carries YAML frontmatter at the top of the file. It is the canonical source of truth for the document's identity and relationships.

### Universal fields

Every document has these:


| Field          | Example                         | Purpose                                         |
| -------------- | ------------------------------- | ----------------------------------------------- |
| `aliases`      | `- "Career Development"`        | First item is the human-readable title          |
| `creationDate` | `Friday 28th February 2026`     | Format: `dddd Do MMMM YYYY`                    |
| `timestamp`    | `20260228143022`                | Format: `YYYYMMDDHHmmss`                       |
| `root`         | `"1001"`                        | The scope/root ID — 4-digit zero-padded string |
| `zettldex`     | `"1001.S.F.P"`                  | Hierarchical address                           |
| `docType`      | `project`                       | Primary type keyword                           |
| `subType`      | `development`                   | Secondary type keyword                         |
| `tags`         | (see [[#Tags]])                 | Hierarchical + custom                          |
| `status`       | `active`                        | Lifecycle stage; omit entirely when `na`       |
| `description`  | `"Short description"`           | Optional                                        |

### Lineage fields

These encode the parent chain so you can walk upward without re-parsing the zettldex:


| Field         | When to include                        | Value                                  |
| ------------- | -------------------------------------- | -------------------------------------- |
| `scope`       | Always (scope docs point at themselves)| The rootmost scope ID                  |
| `scopeFile`   | When a scope doc exists                | Filename of the scope doc              |
| `parentFile`  | Always, except scope docs              | Filename of immediate parent           |
| `focusFile`   | When a focus is in the ancestry        | Filename of the focus ancestor         |
| `projectFile` | When a project is in the ancestry      | Filename of the project ancestor       |

### Type-specific fields

Some document types declare extra required fields via the `extraFrontmatter` array in their config entry. For example, meetings include `freqType`, `freq`, `start`, `end`, `time`.

### Preservation rule

**Never overwrite frontmatter fields that aren't part of the current task.** All skills preserve existing fields by default. If a skill needs to rewrite the frontmatter wholesale, it reads the existing block first, applies its changes, and writes the merged result — never a replacement.

## Tags

Tags are always built in a consistent order so machine tooling and human browsing both work:

```yaml
tags:
  - "{zettldex}"          # 1. The document's own hierarchical address — always quoted
  - "{rootId}"            # 2. The scope ID — always quoted
  - {docType}             # 3. Document type — unquoted keyword
  - {subType}             # 4. SubType — unquoted, ONLY if different from docType
  - {custom-tags...}      # 5. User or context tags — unquoted text, quoted if numeric
```

**Quoting rule:** any tag that is numeric or numeric-looking MUST be quoted. Text tags are unquoted.

**System tags** (`zettldex`, `rootId`, `docType`, `subType`) are auto-managed. When editing custom tags, do not touch the system tags.

**Inheritance:** when creating a child document, the parent's custom tags are suggested as starting points. Add, drop, or replace as the child warrants.

## Wikilinks — the explicit "why"

Links between documents use Obsidian-compatible wikilink syntax: `[[filename]]` or `[[filename|Display Text]]`.

In the Zettelkasten tradition, **a link without a reason is a missed thought.** The reason to link belongs in the prose surrounding the link, not in a separate notes field. When you write "this connects back to `[[F1001_SkillBuilding]]` because the certification plan only matters if the underlying skill gap is real," the *why* is the knowledge being created.

Practically:

- Inside the vault, prefer `[[wikilinks]]` over Markdown URL links — they survive file moves and Obsidian resolves them by name.
- When linking from one scope to another, say so in the prose. Cross-scope links are the most valuable and the easiest to lose.
- When a link's reason stops being true, delete the link. Stale links are noise.

## Placement rules

Folder placement is a hint, not a source of truth — but consistent placement makes vaults browsable. Core defines placement rules per docType:


| docType     | Placement                                        |
| ----------- | ------------------------------------------------ |
| `scope`     | `{topLevel}/{subCat}/{scopeId}_{Title}/` — IS the folder |
| `focus`     | `{scopeFolder}/1_Foci/{F}{rootId}_{Title}/`      |
| `project`   | `{parentFolder}/3_Projects/{P}{rootId}_{Title}/` |
| `objective` | `{parentFolder}/2_Objectives/{O}{rootId}_{Title}/` |
| `content`   | `{parentFolder}/5_Content/{C}{rootId}_{Title}/`  |
| `note`      | `{parentFolder}/` (same folder as parent)        |
| `meeting`   | `{parentFolder}/4_Meetings/` (all meetings flat) |

Container types (scope, focus, project) create their own subfolders; leaf types (note, research) go in the parent's folder. The numbered prefixes (`1_Foci`, `3_Projects`) keep related material clustered and alphabetically predictable.

Modules can declare their own placement types; see [[modules/core/configuration|Configuration]] for the `placement` schema.

## Repository folders

The Reliquary itself is partitioned into top-level folders that group related scopes. Default layout:


| Folder             | Theme                              | Scope ID range (assignedRanges) |
| ------------------ | ---------------------------------- | ------------------------------- |
| `00_Resources/`    | Templates, admin, vault docs       | 0–999                           |
| `10_Personal/`     | Personal focuses and projects      | 1000–1999                       |
| `20_Professional/` | Professional focuses and projects  | 2000–2999                       |

These are configured via `repositoryFolders` in `.zettledeck/core/config.json`. Add more via `/zettledeck.init add-folder --repo`.

When using `assignedRanges`, the scope ID range of a folder tells you at a glance which domain a given ID belongs to. `1047` is Personal; `2103` is Professional. This mirrors the old library Dewey decimal trick: if you can read the number, you know where it lives.

## Status lifecycle

Documents carry a `status` field through their lifecycle. The `status` is elided entirely (not set to empty) when `na`:


| Value      | Meaning                    | Typical docTypes                           |
| ---------- | -------------------------- | ------------------------------------------ |
| `intake`   | Just captured, unsorted    | note, objective                            |
| `ideation` | Being explored             | objective, ideation                        |
| `backlog`  | Queued, not started        | objective, project                         |
| `active`   | Actively being worked on   | content, research, engagement              |
| `steady`   | Ongoing, maintained        | scope, focus, project, recurring meetings  |
| `hold`     | Paused temporarily         | any                                        |
| `cleanup`  | Needs revision             | any                                        |
| `complete` | Finished                   | objective, content                         |
| `archive`  | Archived, no longer active | any                                        |
| `silent`   | Hidden                     | any                                        |
| `na`       | Not applicable             | note, one-time meeting, ideation           |

**Rule:** when `status = "na"`, omit the field from frontmatter entirely.

Document-type configurations declare a `defaultStatus` that applies when a new document of that type is created.

## Validation

When a skill places or categorizes a file, it validates:

1. The parent docType is in the document's `validParents` list.
2. The child's zettldex is `{parentZettldex}.{prefix}`.
3. The `root` field matches the scope's `scopeId`.
4. Tags include the system tags (zettldex, rootId, docType).
5. The status value is one of the lifecycle enum values, or absent.
6. The filename matches the naming pattern.
7. The folder matches the docType's placement rule.

`/zettledeck.init sync-ids` reconciles counter state; broader vault validation is a job for [[theWay#Nexus|Nexus]]'s `lint` mode.

## Configuration — where the rules live

Everything on this page — prefixes, scope method, repository folders, document types with their prefixes and subTypes and placement rules — is configured in `.zettledeck/core/config.json`.

- **To customize structure:** run `/zettledeck.init core` for the guided setup, or edit the config directly.
- **To see what's registered:** `/zettledeck.init folders` and `/zettledeck.init doc-types`.
- **To add or remove a docType:** `/zettledeck.init add-doc-type` and `/zettledeck.init remove-doc-type`.
- **To add or remove a folder:** `/zettledeck.init add-folder` and `/zettledeck.init remove-folder`.

Every registered entry carries a `source` field — `core`, a module name, or `custom`. Modules can update their own entries but never touch entries sourced as `custom` or owned by another module. User edits to specific fields (like `enabled` or `folder`) are preserved across updates. See [[modules/core/configuration|Configuration]] for the full ownership model.

## Extending the vault

Two healthy ways to extend the vault structure:

1. **Install a module** that registers new document types and folders via `module-config.json`. Its entries are source-tagged and will be refreshed when the module updates.
2. **Register your own** custom types and folders via `/zettledeck.init`. These are tagged `source: custom` and will never be touched by `zd update`.

Resist the urge to invent a new docType for every new project. The core types combined with `subType` and custom tags cover most cases. New types are warranted when a category of document carries systematically different frontmatter or needs a distinct placement rule.

## The quick-reference template

A complete frontmatter block for a vault document:

```yaml
---
aliases:
  - "Human Readable Title"
description: "Optional short description"
creationDate: "Friday 28th February 2026"
timestamp: "20260228143022"
root: "1001"
zettldex: "1001.S.F.P"
docType: project
subType: development
tags:
  - "1001.S.F.P"
  - "1001"
  - project
  - development
  - custom-tag-here
scope: "1001"
scopeFile: "S1001_CareerDevelopment"
parentFile: "F1001_SkillBuilding"
focusFile: "F1001_SkillBuilding"
status: active
---
```

For a scope document, lineage fields are replaced by:

```yaml
scope: "1001"
scopeFile: "S1001_CareerDevelopment"
# no parentFile, focusFile, or projectFile
```

---

**Next reading:**

- [[theWay|The Way]] — the workspace flow that feeds material into the vault
- [[modules/core/configuration|Configuration]] — key-by-key reference for `.zettledeck/core/config.json`
- [[modules/core/skills|Core Skills]] — `/zettledeck promote` for graduating files into the vault, `/zettledeck.init` for customizing it
