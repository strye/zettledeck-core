# Markdown & File Conventions — Rules

Conventions for working with Obsidian markdown files and vault structure.

## Obsidian Compatibility

- Use wikilinks: `[[filename]]` for internal links
- Include YAML frontmatter at the top of all files
- Standard markdown formatting (CommonMark)
- Preserve existing frontmatter fields - never overwrite fields not part of current task

## Frontmatter Management

All markdown files may contain YAML frontmatter:

```yaml
---
aliases:
  - "Display Name"
creationDate: "{DayName} {Dth} {Month} {YYYY}"
docType: content | note | meeting | diary | scope | project
status: draft | active | archived
subType: varies by docType
tags: []
timestamp: "{YYYYMMDDHHmmss}"
title: "Document Title"
---
```

**Rules:**
- Parse frontmatter from block between `---` delimiters
- Never overwrite fields not part of current task
- Preserve all existing fields
- Add new fields in alphabetical order (unless order established)

## File Structure for Vault

**See:** `obsidian.vault/resources/vault-steering.md` and `obsidian.vault/resources/vault-defaults.md` for complete Obsidian vault organization rules.

**Key Points:**
- Vault organized hierarchically: Scope → Focus → Project → (content/objective/meeting/etc.)
- All documents have prefixed filenames: `S` (scope), `F` (focus), `P` (project), etc.
- Documents carry inherited scope ID in frontmatter
- Zettldex system for hierarchical addressing

## Editing Practices

- Preserve author's voice and terminology unless asked to change
- Do not reformat markdown structure unless that's the task
- Read full document before making changes
- For substantive edits, consider versioning (if applicable to document type)

## Status Values

**Content lifecycle:** draft → in-review → revised → published → archived

**General:** active, steady, hold, archived, na

**Domain-specific:** Document types may define their own (e.g., ruthless-priorities uses "On track", "At risk", "Stalled")
