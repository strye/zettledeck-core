---
mode: folders
description: Displays the current top-level folder structure from config
---

# Folders — Current Configuration

## Steps

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` to set up your vault first."
3. Display the folder structure in a readable table (see format below)
4. Note the active `scopeMethod` so the user understands whether ranges are relevant

---

## Display Format

### assignedRanges

```
Document Repository: {documentRepo}
Scope Method:        assignedRanges

Top-Level Folders
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 #  Folder                       Range        Next ID  Theme
 1  00_Resources/                0000–0999    0000     Templates, admin, vault docs
 2  10_Personal/                 1000–1999    1000     Personal focuses and projects
 3  20_Professional/             2000–2999    2000     Professional focuses and projects
```

### incremental

```
Document Repository: {documentRepo}
Scope Method:        incremental
Next ID:             {nextId}

Top-Level Folders
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 #  Folder                  Theme
 1  00_Resources/           Templates, admin, vault docs
 2  10_Personal/            Personal focuses and projects
 3  20_Professional/        Professional focuses and projects
```

---

## After Display

Suggest next actions:

> "To add a folder: `/zettledeck.init add-folder`"
> "To remove a folder: `/zettledeck.init remove-folder`"
