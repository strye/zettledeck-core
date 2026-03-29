---
mode: remove-doc-type
description: Remove a document type from config
---

# Remove Document Type

All changes write to `.zettledeck/core/config.json`. Skill files are never modified.

---

## Steps

### Step 1 — Pre-flight

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."

### Step 2 — Show current types

Display the numbered list of current document types:

```
Current Document Types
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 #   Prefix  docType     Source   Description
 1   S       scope       core     Domain anchor; root of the knowledge graph
 2   F       focus       core     A thematic area or domain within a scope
 3   P       project     core     A defined project with deliverables
 4   O       objective   core     A trackable goal, milestone, or task unit
 5   C       content     core     A produced piece of writing or document
 6   M       meeting     core     Meeting notes, one-time or recurring
 7   N       note        core     Miscellaneous notes
 8   I       ideation    core     Brainstorming and idea capture
 9   R       research    core     Research and analysis notes
```

Ask: "Which document type would you like to remove? Enter the number."

### Step 3 — Core type warning

If the selected type has `"source"` set to anything other than `"custom"`, warn the user before proceeding:

> "**Warning:** `{docType}` is owned by the `{source}` module. Removing it may break vault structure, document creation, or validation in the `zettledeck` skill. Module updates may also restore it. This is not recommended unless you are replacing it with a custom equivalent."
>
> "Are you sure you want to remove this type? (yes/no)"

If `"source": "custom"`, skip directly to the standard confirmation.

### Step 4 — Standard confirmation

> "You're about to remove the `{docType}` document type (`{prefix}` prefix) from your config."
>
> **This only removes the config entry.** Existing documents with `docType: {docType}` in their frontmatter are not affected. The `zettledeck` skill will no longer recognize this type for new document creation or validation.
>
> "Are you sure? (yes/no)"

If the user says no, cancel and exit without changes.

### Step 5 — Write

Remove the selected entry from `documentTypes` and write the full updated config.json. Rewrite the complete file.

### Step 6 — Confirm

> "Document type removed. Run `/zettledeck.init doc-types` to see your updated type list."
