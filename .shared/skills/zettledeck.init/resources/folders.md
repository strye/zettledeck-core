---
mode: folders
description: Displays the current workspace and repository folder structure from config
---

# Folders — Current Configuration

## Steps

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` to set up your vault first."
3. Display both folder tables (see format below)
4. Note the active `scopeMethod` so the user understands whether ranges are relevant

---

## Display Format

Display workspace folders first, then repository folders.

```
Workspace Folders
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 #  Folder        Role           Enabled  Description
 1  Nexus/        nexus          yes      Vault intelligence — knowledge graph analysis, idea surfacing, and reflection  [required]
 2  Reliquary/    documentRepo   yes      Permanent document repository  [required]

Repository Folders  (inside {documentRepo folder})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Scope Method: assignedRanges

 #  Folder                       Range        Next ID  Theme
 1  00_Resources/                0000–0999    0000     Templates, admin, vault docs
 2  10_Personal/                 1000–1999    1000     Personal focuses and projects
 3  20_Professional/             2000–2999    2000     Professional focuses and projects
```

For `incremental` scopeMethod, omit Range/Next ID columns from the Repository Folders table and show `Next ID: {nextId}` as a header line instead.

Mark entries with `required: true` with `[required]`. Mark entries with `enabled: false` with `[disabled]`.

---

## After Display

Suggest next actions:

> "To add a workspace folder: `/zettledeck.init add-folder --workspace`"
> "To add a repository folder: `/zettledeck.init add-folder --repo`"
> "To remove a folder: `/zettledeck.init remove-folder`"
