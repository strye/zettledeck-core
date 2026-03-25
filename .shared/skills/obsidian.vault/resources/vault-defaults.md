# Vault Defaults — Customizable Configuration

> **Purpose**: This file defines the document types, folder structure, naming conventions,
> and subTypes for your vault. Customize this file during `/zettledeck.init core` or edit
> directly. The structural rules in `vault-steering.md` reference this file.
>
> Sections marked `<!-- CUSTOMIZE -->` are the primary targets for personalization.

---

## 1. Document Types and Prefixes

<!-- CUSTOMIZE: Enable/disable document types and configure prefix usage. -->

### Prefix Configuration

File prefixes are single uppercase letters prepended to filenames to indicate document type.

**Prefixes enabled:** yes
<!-- Set to "no" if you prefer filenames without type prefixes.
     When disabled, filename pattern becomes: {scopeId}_{TitleInPascalCase}.md
     When enabled, filename pattern is: {PREFIX}{scopeId}_{TitleInPascalCase}.md -->

### Core Document Types (always available)

| Prefix | docType    | subCode | Description |
|--------|------------|---------|-------------|
| `F`    | focus      | F       | A thematic area or domain within a scope |
| `P`    | project    | P       | A defined project with deliverables |
| `O`    | objective  | O       | A trackable goal, milestone, or task unit |
| `C`    | content    | C       | A produced piece of writing or document |
| `M`    | meeting    | M       | Meeting notes, one-time or recurring |
| `N`    | note       | N       | Miscellaneous notes attached to any document |
| `I`    | ideation   | I       | Brainstorming and idea capture |
| `R`    | research   | R       | Research and analysis notes |

### Optional Document Types

<!-- CUSTOMIZE: Uncomment to enable optional types. -->

<!-- Scope — Top-level container and root of the knowledge hierarchy.
     Scopes group related focuses, projects, and documents under a single
     organizational umbrella. Useful for managing distinct life/work domains
     (e.g., a career scope, a health scope, a creative writing scope).
     If you're unsure, start without scopes — you can enable them later.

| `S`    | scope      | S       | Top-level container; root of the hierarchy |
-->

<!-- Engagement — Customer, partner, or team interaction tracking.
     Useful for tracking ongoing relationships and interactions.

| `E`    | engagement | E       | Customer, partner, or team interaction tracking |
-->

---

## 2. Top-Level Folder Structure

<!-- CUSTOMIZE: Define your vault's top-level folders and what content goes in each. -->

| Content theme | Top-level folder |
|--------------|-----------------|
| Admin, resources, templates | `00_Resources/` |
| Personal life, general interests | `10_General/` |
| Academic or domain research | `20_Research/` |
| Daily journaling, reflection | `30_Journal/` |
| Career, professional development | `40_Professional/` |
| Quick capture, scratch notes | `Void/` |

---

## 3. Document Type Details

### focus
- **Purpose**: A thematic area or domain within a scope (or standalone if scopes are disabled)
- **Valid parents**: scope (if enabled), or standalone at top level
- **Default status**: `steady`
- **cssClasses**: `["dashboard"]`
- **subTypes**: ideation, domain, research, vision, strategy, wellness, other

### project
- **Purpose**: A defined project with deliverables
- **Valid parents**: scope, focus
- **Default status**: `steady`
- **cssClasses**: `["dashboard"]`
- **subTypes**: content, strategy, forecast, research, development, campaign

### objective
- **Purpose**: A trackable goal, milestone, or task unit
- **Valid parents**: scope, focus, project, content
- **Status**: intake | ideation | active (never has default; user must choose)
- **cssClasses**: `["dashboard"]`
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
- **Purpose**: Miscellaneous notes attached to any document
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

### Optional: scope (if enabled)
- **Purpose**: Top-level container. The root of the knowledge hierarchy. Groups related focuses, projects, and documents under a single organizational umbrella.
- **Valid parents**: none (standalone)
- **Default status**: `steady`
- **cssClasses**: `["dashboard"]`
- **Sets its own**: `scope`, `root`, `scopeFile` pointing to itself

**subTypes** (determined by vault area):

<!-- CUSTOMIZE: Define subTypes for each top-level folder in your vault. -->

| Vault Area | subType values |
|-----------|---------------|
| Resources | personal, professional |
| General | general, personal, health, goal |
| Research | personal, professional, development, goal |
| Journal | general, personal, health, professional, goal |
| Professional | career, professional, growth, goal |

### Optional: engagement (if enabled)
- **Purpose**: Customer, partner, or team interaction tracking
- **Valid parents**: scope, focus, project
- **Default status**: `active`
- **subTypes**: customer, partner, team, community, workshop, other
- **Template body**: `Customer: X / Goal: / Date: X` + Next Steps section

---

## 4. Child Document Placement

After determining the parent folder, child docs are placed like this:

| docType    | Placement |
|------------|-----------|
| scope      | `{topLevel}/{subCat}/{scopeId}_{Title}/` (IS the folder) — if enabled |
| focus      | `{scopeFolder}/1_Foci/{F}{rootId}_{Title}/` (creates subfolder) |
| project    | `{parentFolder}/3_Projects/{P}{rootId}_{Title}/` (creates subfolder) |
| objective  | `{parentFolder}/2_Objectives/{O}{rootId}_{Title}/` (optional subfolder) |
| content    | `{parentFolder}/5_Content/{C}{rootId}_{Title}/` (optional subfolder) |
| engagement | `{parentFolder}/6_Engagements/{E}{rootId}_{Title}/` (optional subfolder) — if enabled |
| meeting    | `{parentFolder}/4_Meetings/` (no subfolder — all meetings flat) |
| note       | `{parentFolder}/` (same folder as parent, no subfolder) |
| ideation   | `{parentFolder}/Ideation/` |
| research   | `{parentFolder}/` (same folder as parent, no subfolder) |
| jot        | `Void/` or `Void/Void_{N}/` |

**Note**: If prefixes are disabled, omit the prefix letter from folder names
(e.g., `{rootId}_{Title}/` instead of `{P}{rootId}_{Title}/`).

---

## 5. File Naming Rules

### Standard documents (all except jot)

**With prefixes enabled:**
```
{subCode}{rootId}_{DocumentTitlePascalCase}
```

- `subCode`: single uppercase letter (from the prefix table in Section 1)
- `rootId`: the scope's numeric ID
- `documentTitle`: the human title with spaces removed, each word capitalized (PascalCase)
- No file extension in the name field (`.md` is implicit)

**Examples:**
- `P1001_ProjectAlpha` — project
- `F1001_StrategyDomain` — focus
- `N1001_MeetingNotes` — note

**With prefixes disabled:**
```
{rootId}_{DocumentTitlePascalCase}
```

### Jot documents

```
{Word_Separated_Title}
```

- Title with underscores replacing spaces
- No prefix, no rootId
