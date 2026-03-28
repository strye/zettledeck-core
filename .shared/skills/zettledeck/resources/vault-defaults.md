# Vault Defaults — Reference Documentation

> **Note:** This file is reference documentation showing the default structure and document types.
> The actual configuration is stored in `.zettledeck/core/config.json`.
> To customize your vault, edit that file directly or run `/zettledeck.init core` to use the wizard.
>
> **Purpose**: This file documents the default vault structure, document types, folder conventions,
> and naming patterns. The structural rules in `vault-steering.md` govern how these are applied.

---

## 1. Document Types and Prefixes

### Prefix Configuration

File prefixes are single uppercase letters prepended to filenames to indicate document type.
Configured via `prefixesEnabled` in `.zettledeck/core/config.json`.

When enabled, filename pattern: `{PREFIX}{scopeId}_{TitleInPascalCase}.md`
When disabled, filename pattern: `{scopeId}_{TitleInPascalCase}.md`

### Core Document Types

| Prefix | docType    | subCode | Description |
|--------|------------|---------|-------------|
| `S`    | scope      | S       | Domain anchor; root of the knowledge graph |
| `F`    | focus      | F       | A thematic area or domain within a scope |
| `P`    | project    | P       | A defined project with deliverables |
| `O`    | objective  | O       | A trackable goal, milestone, or task unit |
| `C`    | content    | C       | A produced piece of writing or document |
| `M`    | meeting    | M       | Meeting notes, one-time or recurring |
| `N`    | note       | N       | Miscellaneous notes; use subType: jot for quick capture |
| `I`    | ideation   | I       | Brainstorming and idea capture |
| `R`    | research   | R       | Research and analysis notes |

---

## 2. Top-Level Folder Structure

Configured via `topLevelFolders` in `.zettledeck/core/config.json`.

| Content theme | Top-level folder |
|--------------|-----------------|
| Templates, admin, vault docs | `00_Resources/` |
| Personal focuses and projects | `10_Personal/` |
| Professional focuses and projects | `20_Professional/` |

---

## 3. Document Type Details

### scope
- **Purpose**: Domain anchor and root of the knowledge graph. One scope document per domain. Links all related focuses, projects, and documents via scopeId regardless of where they live in the vault.
- **Valid parents**: none (standalone — lives at the top-level folder)
- **Default status**: `steady`
- **Sets its own**: `scope`, `root`, `scopeFile` pointing to itself
- **subTypes**: configured per vault area in `scopeSubTypes` (see config.json)

### focus
- **Purpose**: A thematic area or domain within a scope
- **Valid parents**: scope
- **Default status**: `steady`
- **subTypes**: ideation, domain, research, vision, strategy, wellness, other

### project
- **Purpose**: A defined project with deliverables
- **Valid parents**: scope, focus
- **Default status**: `steady`
- **subTypes**: content, strategy, forecast, research, development, campaign

### objective
- **Purpose**: A trackable goal, milestone, or task unit
- **Valid parents**: scope, focus, project, content
- **Status**: intake | ideation | active (never has default; user must choose)
- **subTypes**: smart, milestone, todo, create, research, poc, learn, improve, behavior, other

### content
- **Purpose**: A produced piece of writing, document, or creative output
- **Valid parents**: scope, focus, project, content
- **Default status**: `active`
- **subTypes**:

| Category | subTypes |
|---------|---------|
| Business Ops/Strategy | narrative, brief, presentation, plan, review, strategy |
| Product/Planning | roadmap, requirements, spec, design |
| Knowledge/Learning | forecast, guide, paper, post |

### meeting
- **Purpose**: Meeting notes, one-time or recurring
- **Valid parents**: scope, focus, project, objective
- **Default status**: `na` (one-time) or `steady` (recurring)
- **Tags**: add `"recurring"` if freqType ≠ "once"
- **subTypes**: customer, team, workshop, training, ideation, loop, admin, personal
- **Extra front-matter**: `freqType`, `freq`, `start`, `end`, `time`

### note
- **Purpose**: Miscellaneous notes attached to any document. Use `subType: jot` for lightweight quick-capture notes with minimal metadata.
- **Valid parents**: scope, focus, project, objective, content, meeting
- **Default status**: `na` (field omitted)
- **subTypes**: note, jot, draft, tasks, research, meeting, contact

### ideation
- **Purpose**: Brainstorming and idea capture
- **Valid parents**: scope, focus, project, objective, content
- **Default status**: `na` (field omitted)
- **subTypes**: general, research, professional

### research
- **Purpose**: Research and analysis notes
- **Valid parents**: scope, focus, project, objective, content
- **Default status**: `active`
- **subTypes**: domain, strategic, foundational, framing

---

## 4. Child Document Placement

After determining the parent folder, child docs are placed like this:

| docType    | Placement |
|------------|-----------|
| scope      | `{topLevel}/{subCat}/{scopeId}_{Title}/` (IS the folder) |
| focus      | `{scopeFolder}/1_Foci/{F}{rootId}_{Title}/` (creates subfolder) |
| project    | `{parentFolder}/3_Projects/{P}{rootId}_{Title}/` (creates subfolder) |
| objective  | `{parentFolder}/2_Objectives/{O}{rootId}_{Title}/` (optional subfolder) |
| content    | `{parentFolder}/5_Content/{C}{rootId}_{Title}/` (optional subfolder) |
| meeting    | `{parentFolder}/4_Meetings/` (no subfolder — all meetings flat) |
| note       | `{parentFolder}/` (same folder as parent, no subfolder) |
| ideation   | `{parentFolder}/Ideation/` |
| research   | `{parentFolder}/` (same folder as parent, no subfolder) |

**Note**: If prefixes are disabled, omit the prefix letter from folder names.

---

## 5. File Naming Rules

### Standard documents

**With prefixes enabled:**
```
{subCode}{rootId}_{DocumentTitlePascalCase}
```

- `subCode`: single uppercase letter (from the prefix table in Section 1)
- `rootId`: the scope's numeric ID — always 4-digit zero-padded (e.g., `0001`, `1001`)
- `documentTitle`: human title with spaces removed, each word capitalized (PascalCase)

**Examples:**
- `P1001_ProjectAlpha` — project
- `F1001_StrategyDomain` — focus
- `N1001_MeetingNotes` — note

**With prefixes disabled:**
```
{rootId}_{DocumentTitlePascalCase}
```
