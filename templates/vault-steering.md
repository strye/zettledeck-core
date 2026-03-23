# Vault Agent Steering File

> **Purpose**: This file gives a vault agent everything it needs to categorize any file, determine its required front-matter metadata, and decide where it should be placed in the vault.
>
> **Setup**: Copy this file to your vault root and customize Sections 5 (subTypes) and 8 (top-level folders) to match your vault's structure.

---

## 1. Vault Overview

This is an **Obsidian** personal knowledge vault. Documents are organized in a strict hierarchy:

```
Scope → Focus → Project → (Objective | Content | Engagement | Meeting | Note | Ideation | Research | Lexicon | Tune | Way)
```

All documents (except `jot`) have a parent. Every document's front-matter encodes its position
in the hierarchy via `zettldex`, `root`, `scope`, `parentFile`, and related fields.

---

## 2. Document Type Identification

### Step 1 — Check the filename prefix

| Prefix | docType    |
|--------|------------|
| `S`    | scope      |
| `F`    | focus      |
| `P`    | project    |
| `O`    | objective  |
| `C`    | content    |
| `E`    | engagement |
| `M`    | meeting    |
| `N`    | note       |
| `I`    | ideation   |
| `L`    | lexicon    |
| `R`    | research   |
| `T`    | tune       |
| `W`    | way        |

**Pattern**: `{PREFIX}{scopeId}_{TitleInPascalCase}.md`
**Example**: `F1001_CareerStrategy.md` → focus, scopeId=1001

**Exception — Jot**: No prefix, filed in `Void/` or `Void/Void_N/`, minimal metadata.

### Step 2 — Check the front-matter `docType` field

```yaml
docType: scope | focus | project | objective | content | engagement | meeting | note | ideation | lexicon | research | tune | way
```

Note: `jot` files have `docType: note` and `subType: jot`.

### Step 3 — Check the file's folder path

| Folder pattern               | Likely docType |
|-----------------------------|----------------|
| `Void/`                     | jot            |
| `{cat}/{sub}/{id}_{name}/`  | scope          |
| `.../1_Foci/{name}/`        | focus          |
| `.../2_Objectives/{name}/`  | objective      |
| `.../3_Projects/{name}/`    | project        |
| `.../4_Meetings/`           | meeting        |
| `.../5_Content/{name}/`     | content        |
| `.../6_Engagements/{name}/` | engagement     |
| `.../Ideation/`             | ideation       |
| `.../Lexicon/`              | lexicon        |

---

## 3. Front-Matter Specification

### 3a. Universal Properties (every document type except jot)

| Property     | Type         | Required | Rule |
|--------------|-------------|----------|------|
| `aliases`    | list[string] | yes      | First item is the human-readable document title |
| `creationDate` | string     | yes      | Format: `dddd Do MMMM YYYY` (e.g., "Friday 28th February 2026") |
| `timestamp`  | string       | yes      | Format: `YYYYMMDDHHmmss` (e.g., "20260228143022") |
| `root`       | string       | yes      | The scope/root ID this document belongs to (quoted numeric string) |
| `zettldex`   | string       | yes      | Hierarchical address — see Section 4 |
| `docType`    | string       | yes      | Primary type keyword (see table in Section 2) |
| `subType`    | string       | yes      | Secondary type keyword (see Section 5 per-type) |
| `tags`       | list         | yes      | See Section 6 — Tag Rules |
| `status`     | string       | cond.    | Omit if `na`; present otherwise (see Section 7) |
| `description`| string       | optional | Short description; omit if empty |
| `cssClasses` | list[string] | optional | `["dashboard"]` for folder-type docs; `["music"]` for tunes |

### 3b. Lineage Properties (inherited from parent)

Add these based on what the parent chain contains:

| Property     | When to add                          | Value |
|--------------|--------------------------------------|-------|
| `scope`      | Always (except scope docs set own)   | The rootmost scope ID |
| `scopeFile`  | When scope exists                    | File name of the scope doc |
| `parentFile` | Always (except scope docs)           | File name of immediate parent |
| `focusFile`  | When parent is focus, or inherited   | File name of the focus ancestor |
| `projectFile`| When parent is project, or inherited | File name of the project ancestor |

### 3c. Type-Specific Additional Properties

**Meeting only:**
```yaml
freqType: once | weeks | months | years
freq: 0 | 1 | 2           # 0=once, 1=weekly/monthly/annual, 2=bi-weekly
start: "YYYY-MM-DD"
end: "YYYY-MM-DD"
time: "HH:MM"
```

**Optionally added later via upsert:**
```yaml
priority: 0 | 30 | 60 | 90   # 0=ruthless, 30=working, 60=standard, 90=pause
sortKey: {rootId}_{custom}    # used for list ordering
```

### 3d. Jot Front-Matter (minimal — standalone quick capture)

```yaml
---
aliases:
  - {docTitle}
creationDate: {dddd Do MMMM YYYY}
timestamp: {YYYYMMDDHHmmss}
docType: note
tags:
  - note
  - jot
subType: jot
status: intake
---
```

---

## 4. Zettldex (Hierarchical Address) Rules

The `zettldex` encodes a document's position in the hierarchy:

| Document                     | Zettldex formula                        | Example      |
|------------------------------|----------------------------------------|--------------|
| scope                        | `{scopeId}.S`                          | `1001.S`     |
| focus (child of scope)       | `{parentZettldex}.F`                   | `1001.S.F`   |
| project (child of focus)     | `{parentZettldex}.P`                   | `1001.S.F.P` |
| note (child of project)      | `{parentZettldex}.N`                   | `1001.S.F.P.N` |
| content (child of project)   | `{parentZettldex}.C`                   | `1001.S.F.P.C` |

**Rule**: Always derive from `parentZettldex` found in the parent file's front-matter, then append `.{subCode}`.

| subCode | docType    |
|---------|------------|
| S       | scope      |
| F       | focus      |
| P       | project    |
| O       | objective  |
| C       | content    |
| E       | engagement |
| M       | meeting    |
| N       | note       |
| I       | ideation   |
| L       | lexicon    |
| R       | research   |
| T       | tune       |
| W       | way        |

---

## 5. Document Type Details

<!-- CUSTOMIZE: Update subType values per docType to match your vault's domains. -->

### scope
- **Purpose**: Top-level container. The root of the knowledge hierarchy.
- **Valid parents**: none (standalone)
- **Default status**: `steady`
- **cssClasses**: `["dashboard"]`
- **Sets its own**: `scope`, `root`, `scopeFile` pointing to itself

**subTypes** (determined by vault area):

<!-- CUSTOMIZE: Define subTypes for each top-level folder in your vault. -->

| Vault Area | subType values |
|-----------|---------------|
| Resources | personal, professional |
| General | general, personal, health, creative, goal |
| Research | personal, professional, sciences, development, creative, goal |
| Journal | general, personal, health, professional, goal |
| Professional | career, professional, growth, goal |
| Creative | fiction, poetry, art, music, goal |
| Hobbies | hobbies, goal |

---

### focus
- **Purpose**: A thematic area or domain within a scope
- **Valid parents**: scope
- **Default status**: `steady`
- **cssClasses**: `["dashboard"]`
- **subTypes**: ideation, domain, research, vision, strategy, wellness, other

---

### project
- **Purpose**: A defined project with deliverables
- **Valid parents**: scope, focus
- **Default status**: `steady`
- **cssClasses**: `["dashboard"]`
- **subTypes**: content, strategy, forecast, research, development, campaign, fiction

---

### objective
- **Purpose**: A trackable goal, milestone, or task unit
- **Valid parents**: scope, focus, project, content
- **Status**: intake | ideation | active (never has default; user must choose)
- **cssClasses**: `["dashboard"]`
- **subTypes**: smart, milestone, todo, create, research, poc, learn, improve, behavior, other

---

### content
- **Purpose**: A produced piece of writing, document, or creative output
- **Valid parents**: scope, focus, project, content
- **Default status**: `active`
- **subTypes by category**:

| Category | subTypes |
|---------|---------|
| Business Ops/Strategy | narrative, brief, presentation, plan, review, strategy |
| Product/Planning | roadmap, requirements, spec, design |
| Knowledge/Learning | forecast, guide, paper, post |
| Creative Writing | prose, screen, stage, comic, reading, flash, poem |

---

### engagement
- **Purpose**: Customer, partner, or team interaction tracking
- **Valid parents**: scope, focus, project
- **Default status**: `active`
- **subTypes**: customer, partner, team, community, workshop, other
- **Template body**: `Customer: X / Goal: / Date: X` + Next Steps section

---

### meeting
- **Purpose**: Meeting notes, one-time or recurring
- **Valid parents**: scope, focus, project, objective
- **Default status**: `na` (one-time) or `steady` (recurring)
- **Tags**: add `"recurring"` if freqType ≠ "once"
- **subTypes**: customer, team, workshop, training, ideation, loop, admin, personal
- **Extra front-matter**: `freqType`, `freq`, `start`, `end`, `time`

---

### note
- **Purpose**: Miscellaneous notes attached to any document
- **Valid parents**: scope, focus, project, objective, content, meeting
- **Default status**: `na` (field omitted)
- **subTypes**: note, jot, draft, tasks, readlist, research, meeting, contact, readarchive, recipe

---

### ideation
- **Purpose**: Brainstorming and idea capture
- **Valid parents**: scope, focus, project, objective, content
- **Default status**: `na` (field omitted)
- **subTypes**: general, research, professional, hobbies

---

### research
- **Purpose**: Research and analysis notes
- **Valid parents**: scope, focus, project, objective, content, way
- **Default status**: `active`
- **subTypes**: domain, strategic, creative, narrative, foundational, framing

---

### lexicon
- **Purpose**: Structured creative writing reference documents
- **Valid parents**: scope, focus, project, objective, content, way
- **Default status**: `na` (field omitted)
- **cssClasses**: `["dashboard"]`

| subType   | Vault subfolder         |
|-----------|------------------------|
| spine     | Lexicon/Planning       |
| theme     | Lexicon/Planning       |
| plot      | Lexicon/Planning       |
| ideation  | Lexicon/Planning       |
| outline   | Lexicon/Planning       |
| structure | Lexicon/Structure      |
| scenes    | Lexicon/Structure      |
| beatsheet | Lexicon/Structure      |
| character | Lexicon/Characters     |
| location  | Lexicon/Locations      |
| world     | Lexicon/World          |
| system    | Lexicon/World          |

---

### tune
- **Purpose**: Music notation (chords, ABC notation, tablature)
- **Valid parents**: scope, focus, project, content
- **Default status**: `na` (field omitted)
- **cssClasses**: `["music"]`
- **subTypes**: chords, abc, tab
- **Extra front-matter**: `tuneName`, `tuneAuthor`

---

### way
- **Purpose**: Documented processes, recipes, or reusable workflows
- **Valid parents**: scope, focus, project, content
- **Default status**: `na` (field omitted)
- **subTypes**: recipe, mechanism, function

---

## 6. Tag Rules

Tags are **always** built in this order:

```yaml
tags:
  - "{zettldex}"          # 1. Own hierarchical address — always quoted
  - "{rootId}"            # 2. Root scope ID — always quoted (numeric string)
  - {docType}             # 3. Document type — unquoted keyword
  - {subType}             # 4. Sub-type — unquoted, ONLY if different from docType
  - {custom tags...}      # 5. User/context tags — unquoted text, quoted if numeric
  - "recurring"           # 6. Add for recurring meetings
```

**Quoting rule**: Any tag that is numeric or looks numeric MUST be quoted. Text tags are unquoted.

**System tags** (auto-managed, do NOT include in editable custom tags):
- `zettldex` value, `rootId` value, `docType`, `subType`

**Inherited tags**: When creating a child document, the parent's custom tags (minus system tags) are suggested as starting custom tags.

---

## 7. Status Values

| Value    | Meaning                        | Typical docTypes |
|----------|-------------------------------|-----------------|
| `intake` | Just captured, unsorted       | note, objective |
| `ideation` | Being explored              | objective, ideation |
| `backlog` | Queued, not started          | objective, project |
| `active` | Actively being worked on      | content, research, engagement |
| `steady` | Ongoing, maintained           | scope, focus, project, recurring meetings |
| `hold`   | Paused temporarily            | any |
| `cleanup` | Needs revision               | any |
| `complete` | Finished                    | objective, content |
| `archive` | Archived, no longer active   | any |
| `silent` | Hidden                        | any |
| `na`     | Not applicable (field omitted) | note, meeting (one-time), ideation, lexicon, tune, way |

**Rule**: When `status = "na"`, the field is **completely omitted** from front-matter.

---

## 8. Vault Placement Rules

### Top-Level Folder Selection (Scope placement)

<!-- CUSTOMIZE: Define your vault's top-level folders and what content goes in each. -->

| Content theme | Top-level folder |
|--------------|-----------------|
| Admin, resources, templates | `00_Resources/` |
| Personal life, general interests | `10_General/` |
| Academic or domain research | `20_Research/` |
| Daily journaling, reflection | `30_Journal/` |
| Career, professional development | `40_Professional/` |
| Creative writing, art, music | `80_Creator/` |
| Hobbies, games | `90_Hobbies/` |
| Quick capture, scratch notes | `Void/` |

### Scope Folder Structure

Scopes create their own folder:
```
{topLevel}/{subCategory}/{scopeId}_{ScopeTitle}/
```

Example: `40_Professional/41_CareerTech/1001_ProjectAlpha/`

### Child Document Placement

After determining the scope folder, child docs are placed like this:

| docType    | Placement |
|------------|-----------|
| scope      | `{topLevel}/{subCat}/{scopeId}_{Title}/` (IS the folder) |
| focus      | `{scopeFolder}/1_Foci/{F}{rootId}_{Title}/` (creates subfolder) |
| project    | `{parentFolder}/3_Projects/{P}{rootId}_{Title}/` (creates subfolder) |
| objective  | `{parentFolder}/2_Objectives/{O}{rootId}_{Title}/` (optional subfolder) |
| content    | `{parentFolder}/5_Content/{C}{rootId}_{Title}/` (optional subfolder) |
| engagement | `{parentFolder}/6_Engagements/{E}{rootId}_{Title}/` (optional subfolder) |
| meeting    | `{parentFolder}/4_Meetings/` (no subfolder — all meetings flat) |
| note       | `{parentFolder}/` (same folder as parent, no subfolder) |
| ideation   | `{parentFolder}/Ideation/` |
| research   | `{parentFolder}/` (same folder as parent, no subfolder) |
| lexicon    | `{parentFolder}/Lexicon/{subfolder}/` (see Section 5) |
| tune       | `{parentFolder}/` (same folder as parent, no subfolder) |
| way        | `{parentFolder}/` (same folder as parent, no subfolder) |
| jot        | `Void/` or `Void/Void_{N}/` |

---

## 9. File Naming Rules

### Standard documents (all except jot)

```
{subCode}{rootId}_{DocumentTitlePascalCase}
```

- `subCode`: single uppercase letter (S, F, P, O, C, E, M, N, I, L, R, T, W)
- `rootId`: the scope's numeric ID
- `documentTitle`: the human title with spaces removed, each word capitalized (PascalCase)
- No file extension in the name field (`.md` is implicit)

**Examples:**
- `S1001_ProjectAlpha` — scope
- `F1001_StrategyDomain` — focus
- `N1001_MeetingNotes` — note

### Jot documents

```
{Word_Separated_Title}
```

- Title with underscores replacing spaces
- No prefix, no rootId

---

## 10. Categorization Decision Tree

Use this flow when categorizing an unknown file:

```
1. Is the file in Void/ folder?
   YES → docType=note, subType=jot. Done.
   NO → continue

2. Does the file have front-matter?
   NO → it's probably a jot or uncategorized. Treat as jot.
   YES → read docType and subType from front-matter

3. Does the filename match {PREFIX}{number}_{Title} pattern?
   YES → confirm docType from prefix table
   NO → infer from folder location (see placement table)

4. Does the file have a zettldex value?
   NO → it's either a scope or an uncategorized file
   YES → parse depth: "XXXX.S" = scope, "XXXX.S.F" = focus, etc.

5. Verify parent lineage:
   - scope: has scope= pointing to self
   - all others: has parentFile= pointing to a valid file

6. Check status field:
   - absent → status is "na"
   - present → use value as-is

7. Check cssClasses:
   - ["dashboard"] → this is a folder-type/container doc
   - ["music"] → this is a tune
   - absent → leaf/content doc
```

---

## 11. Validation Rules

When placing or categorizing a file, validate:

1. **Parent type is valid** — use the "Valid parents" list per docType (Section 5)
2. **Zettldex extends parent's** — must be `{parentZettldex}.{subCode}`
3. **rootId matches scope** — the `root` field must match the scope's `scopeId`
4. **Tags include system tags** — zettldex, rootId, docType must be in tags
5. **Status is valid** — must be one of the enum values in Section 7, or absent
6. **Filename follows convention** — must match `{subCode}{rootId}_{PascalTitle}`
7. **Folder matches docType** — file must be in the correct subfolder for its type

---

## 12. Quick Reference: Complete Front-Matter Template

```yaml
---
aliases:
  - {Human Readable Title}
description: "{optional short description}"
creationDate: {dddd Do MMMM YYYY}
timestamp: {YYYYMMDDHHmmss}
root: "{scopeId}"
zettldex: "{parentZettldex}.{subCode}"
docType: {docType}
tags:
  - "{zettldex}"
  - "{rootId}"
  - {docType}
  - {subType}
  - {custom tags...}
subType: {subType}
scope: "{scopeId}"
scopeFile: "{scopeFileName}"
parentFile: "{parentFileName}"
focusFile: "{focusFileName}"       # if in focus hierarchy
projectFile: "{projectFileName}"   # if in project hierarchy
status: {status}                   # omit if "na"
cssClasses:                        # omit if none
  - {class}
---
```

For **scope** documents, these lineage fields are replaced by:
```yaml
scope: "{scopeId}"          # points to self
scopeFile: "{ownFileName}"  # points to self
# no parentFile, focusFile, or projectFile
```
