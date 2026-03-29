# ZettleDeck Vault Steering

> **Purpose**: This file gives a skill or agent everything it needs to understand the structural
> rules of a ZettleDeck vault — hierarchical addressing, front-matter specification, tag construction,
> status lifecycle, placement logic, and validation.
>
> **Customization**: Document types, folder structure, subTypes, and naming conventions are
> defined in `.zettledeck/core/config.json` and documented in `vault-defaults.md` (same directory).
> This file stays static.

---

## 1. Vault Overview

This is a **ZettleDeck** personal knowledge vault. Documents are organized in a hierarchy
with consistent front-matter metadata encoding each document's position via `zettldex`,
`root`, `scope`, `parentFile`, and related fields.

Relationships between documents are carried by metadata — documents can live anywhere
in the vault and remain connected through shared `scopeId` values. The available document
types and hierarchy are defined in `.zettledeck/core/config.json` under `documentTypes`.
`vault-defaults.md` documents the default set for reference.

---

## 2. Document Type Identification

### Step 1 — Check the filename prefix

If file prefixes are enabled (see `vault-defaults.md`), the filename encodes the document type:

**Pattern**: `{PREFIX}{scopeId}_{TitleInPascalCase}.md`
**Example**: `P1001_CareerStrategy.md` → project, scopeId="1001"

**ScopeId format**: Always a 4-digit zero-padded string — `"0001"` not `"1"`, `"0999"` not `"999"`. This applies in filenames, frontmatter, tags, and zettldex values everywhere.

If prefixes are disabled, the pattern is: `{scopeId}_{TitleInPascalCase}.md`

The prefix-to-docType mapping is defined in `.zettledeck/core/config.json` under `documentTypes` (`prefix` field).

### Step 2 — Check the front-matter `docType` field

```yaml
docType: {one of the enabled document types from vault-defaults.md}
```

### Step 3 — Check the file's folder path

Use the placement rules in Section 6 of this file to infer docType from folder location.

---

## 3. Front-Matter Specification

### 3a. Universal Properties (every document type)

| Property       | Type         | Required | Rule |
|----------------|-------------|----------|------|
| `aliases`      | list[string] | yes      | First item is the human-readable document title |
| `creationDate` | string       | yes      | Format: `dddd Do MMMM YYYY` (e.g., "Friday 28th February 2026") |
| `timestamp`    | string       | yes      | Format: `YYYYMMDDHHmmss` (e.g., "20260228143022") |
| `root`         | string       | yes      | The scope/root ID — 4-digit zero-padded string (e.g., `"0001"`, `"1001"`) |
| `zettldex`     | string       | yes      | Hierarchical address — see Section 4 |
| `docType`      | string       | yes      | Primary type keyword (from vault-defaults.md) |
| `subType`      | string       | yes      | Secondary type keyword (see vault-defaults.md per-type) |
| `tags`         | list         | yes      | See Section 5 — Tag Rules |
| `status`       | string       | cond.    | Omit if `na`; present otherwise (see Section 7) |
| `description`  | string       | optional | Short description; omit if empty |

### 3b. Lineage Properties (inherited from parent)

Add these based on what the parent chain contains:

| Property      | When to add                          | Value |
|---------------|--------------------------------------|-------|
| `scope`       | Always (except scope docs set own)   | The rootmost scope ID |
| `scopeFile`   | When scope exists                    | File name of the scope doc |
| `parentFile`  | Always (except scope docs)           | File name of immediate parent |
| `focusFile`   | When parent is focus, or inherited   | File name of the focus ancestor |
| `projectFile` | When parent is project, or inherited | File name of the project ancestor |

### 3c. Type-Specific Additional Properties

Some document types declare extra required frontmatter fields via the `extraFrontmatter` array in their `documentTypes` config entry. Read the active type's entry and include those fields.

**Default example — meeting:**
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

---

## 4. Zettldex (Hierarchical Address) Rules

The `zettldex` encodes a document's position in the hierarchy:

| Document                   | Zettldex formula      | Example        |
|----------------------------|-----------------------|----------------|
| scope                      | `{scopeId}.S`         | `1001.S`       |
| focus (child of scope)     | `{parentZettldex}.F`  | `1001.S.F`     |
| project (child of focus)   | `{parentZettldex}.P`  | `1001.S.F.P`   |
| note (child of project)    | `{parentZettldex}.N`  | `1001.S.F.P.N` |
| content (child of project) | `{parentZettldex}.C`  | `1001.S.F.P.C` |

**Rule**: Always derive from `parentZettldex` found in the parent file's front-matter, then append `.{prefix}` (the type's `prefix` value from `documentTypes` in config).

**ScopeId in zettldex**: The numeric prefix is always 4 digits, zero-padded. `"0001.S"` not `"1.S"`.

---

## 5. Tag Rules

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

**ScopeId in tags**: The rootId tag is always 4-digit zero-padded (e.g., `"0001"` not `"1"`).

**System tags** (auto-managed, do NOT include in editable custom tags):
- `zettldex` value, `rootId` value, `docType`, `subType`

**Inherited tags**: When creating a child document, the parent's custom tags (minus system tags) are suggested as starting custom tags.

---

## 6. Vault Placement Rules

### Scope Folder Structure

Scopes create their own folder:
```
{topLevel}/{subCategory}/{scopeId}_{ScopeTitle}/
```

Example: `20_Professional/21_CareerTech/1001_ProjectAlpha/`

### Child Document Placement

After determining the scope folder, child docs are placed based on their type.
The placement table is defined in `vault-defaults.md`, Section 4.

General rules:
- Container types (scope, focus, project) create subfolders
- Leaf types (note, research) go in the parent's folder
- Meeting notes go flat in a `4_Meetings/` subfolder

---

## 7. Status Values

| Value      | Meaning                         | Typical docTypes |
|------------|---------------------------------|-----------------|
| `intake`   | Just captured, unsorted         | note, objective |
| `ideation` | Being explored                  | objective, ideation |
| `backlog`  | Queued, not started             | objective, project |
| `active`   | Actively being worked on        | content, research, engagement |
| `steady`   | Ongoing, maintained             | scope, focus, project, recurring meetings |
| `hold`     | Paused temporarily              | any |
| `cleanup`  | Needs revision                  | any |
| `complete` | Finished                        | objective, content |
| `archive`  | Archived, no longer active      | any |
| `silent`   | Hidden                          | any |
| `na`       | Not applicable (field omitted)  | note, meeting (one-time), ideation |

**Rule**: When `status = "na"`, the field is **completely omitted** from front-matter.

---

## 8. Categorization Decision Tree

Use this flow when categorizing an unknown file:

```
1. Does the file have front-matter?
   NO → treat as unstructured note (intake, no zettldex)
   YES → read docType and subType from front-matter

2. Does the filename match {PREFIX}{number}_{Title} pattern?
   YES → confirm docType from prefix table (vault-defaults.md)
   NO → infer from folder location (see placement table)

3. Does the file have a zettldex value?
   NO → it's either a scope or an unstructured file
   YES → parse depth: "XXXX.S" = scope, "XXXX.S.F" = focus, etc.

4. Verify parent lineage:
   - scope: has scope= pointing to self
   - all others: has parentFile= pointing to a valid file

5. Check status field:
   - absent → status is "na"
   - present → use value as-is
```

---

## 9. Validation Rules

When placing or categorizing a file, validate:

1. **Parent type is valid** — use the "Valid parents" list per docType (vault-defaults.md)
2. **Zettldex extends parent's** — must be `{parentZettldex}.{prefix}`
3. **rootId matches scope** — the `root` field must match the scope's `scopeId`
4. **Tags include system tags** — zettldex, rootId, docType must be in tags
5. **Status is valid** — must be one of the enum values in Section 7, or absent
6. **Filename follows convention** — must match naming pattern from vault-defaults.md
7. **Folder matches docType** — file must be in the correct subfolder for its type

---

## 10. Quick Reference: Complete Front-Matter Template

```yaml
---
aliases:
  - {Human Readable Title}
description: "{optional short description}"
creationDate: {dddd Do MMMM YYYY}
timestamp: {YYYYMMDDHHmmss}
root: "{scopeId}"
zettldex: "{parentZettldex}.{prefix}"
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
---
```

For **scope** documents, lineage fields are replaced by:
```yaml
scope: "{scopeId}"          # points to self
scopeFile: "{ownFileName}"  # points to self
# no parentFile, focusFile, or projectFile
```
