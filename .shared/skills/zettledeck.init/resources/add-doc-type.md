---
mode: add-doc-type
description: Interactive wizard to add a new document type to config
---

# Add Document Type

All changes write to `.zettledeck/core/config.json`. Skill files are never modified.

---

## Steps

### Step 1 — Pre-flight

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."
3. Show the existing types (prefix, docType) so the user can avoid collisions

### Step 2 — Gather type details

Ask the following questions in order. Use recommend-first: propose a value, wait for approval.

**Question 1 — docType name**
"What is the name for this document type? (e.g., `log`, `template`, `decision`)"
- Must be lowercase, no spaces
- Must not already exist in `documentTypes`

**Question 2 — Prefix**
"What single uppercase letter should be used as the filename prefix for this type?"
- Must be a single uppercase letter (A–Z)
- Must not already be used by another type
- Suggest a letter based on the docType name if one is available

**Question 3 — Description**
"One-line description of what this document type is for."

**Question 4 — Valid parents**
"Which document types can be parents of a `{docType}`?"

Show the current type list as options. Allow multiple. Allow "none" for root-level types.

**Question 5 — Default status**
"What is the default status for this type?"

Options: `steady`, `active`, `intake`, `na` (field omitted), or none required (user must choose).
Explain: if `na`, the status field is omitted from frontmatter entirely.

**Question 6 — SubTypes**
"What subTypes should this document type support? (comma-separated list, or press enter to skip)"

**Question 7 — Placement**
"Where should documents of this type be placed relative to their parent?"

| Option | Description | Example |
|--------|-------------|---------|
| `same-folder` | Same folder as parent, no subfolder | note, research |
| `creates-subfolder` | Creates a numbered subfolder | focus (1_Foci), project (3_Projects) |
| `flat-in-subfolder` | All files flat in a named subfolder | meeting (4_Meetings) |
| `named-subfolder` | All files in a named subfolder | ideation (Ideation/) |

If `creates-subfolder`, `flat-in-subfolder`, or `named-subfolder`: ask for the folder name.
Suggest using the numbered prefix pattern (`6_TypeName`) for `creates-subfolder` to maintain consistent sort order.

**Question 8 — Extra frontmatter fields (optional)**
"Does this type require any extra frontmatter fields beyond the standard set? (comma-separated, or enter to skip)"

Example: meeting uses `freqType, freq, start, end, time`

### Step 3 — Confirm

Show a summary before writing:

```
New Document Type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
docType:         {docType}
Prefix:          {prefix}
Description:     {description}
Valid parents:   {validParents}
Default status:  {defaultStatus}
SubTypes:        {subTypes}
Placement:       {type} {folder?}
Extra fields:    {extraFrontmatter}
core:            false
```

Ask: "Shall I add this to your config?"

### Step 4 — Write

Append the new entry to `documentTypes` in `.zettledeck/core/config.json`.

Set `"source": "custom"` on all user-created types.

For `defaultStatus: null` — store as JSON `null` (means user must choose at creation time).
For `defaultStatus: "na"` — status field is omitted from frontmatter.

Only include `extraFrontmatter` key if the user provided values. Only include `placement.folder` if the placement type requires it.

Rewrite the complete config.json file — do not attempt a partial edit.

### Step 5 — Confirm

> "Document type added. Run `/zettledeck.init doc-types` to see your updated type list."
>
> **Note:** The type is now registered in config. The `zettledeck` skill will recognize it when creating or categorizing documents.
