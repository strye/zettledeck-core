---
mode: remove-folder
description: Remove a folder entry from workspace or repository config
---

# Remove Folder

All changes write to `.zettledeck/core/config.json`. Skill files are never modified.

Two folder types exist — determine which the user intends:

- `--workspace` — remove from `workspaceFolders`
- `--repo` — remove from `repositoryFolders`

If no flag is provided, ask:
> "Are you removing a workspace folder or a repository folder?"

---

## remove-folder --workspace

### Step 1 — Pre-flight

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."
3. If `workspaceFolders` has only one entry, tell the user: "You need at least one workspace folder. Cannot remove the last entry."

### Step 2 — Show current workspace folders

```
Current Workspace Folders
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 #  Folder        Role           Enabled  Description
 1  Atelier/      jots           yes      A place for quick notes and capturing ideas
 2  Chrysalis/    ideation       yes      A place to expand and incubate ideas
 3  Reliquary/    documentRepo   yes      Permanent document repository  [required]
```

Ask: "Which workspace folder would you like to remove? Enter the number."

### Step 3 — Required entry guard

If the selected entry has `"required": true`, refuse:

> "The **{folder}** folder (role: `{role}`) is required and cannot be removed. It is the document repository destination used by the promote workflow.
>
> You can rename it by editing `folder` directly in `.zettledeck/core/config.json`, or via `/zettledeck.init core`."

Do not proceed. Exit without changes.

### Step 4 — Confirm

> "You're about to remove **{folder}** (role: `{role}`) from your workspace folders."
>
> **This only removes the config entry.** The actual folder and its files are not affected.
>
> "Are you sure? (yes/no)"

If no, cancel without changes.

### Step 5 — Write

Remove the selected entry from `workspaceFolders` and rewrite the complete config.json.

### Step 6 — Confirm

> "Workspace folder removed. Run `/zettledeck.init folders` to see your updated structure."

---

## remove-folder --repo

### Step 1 — Pre-flight

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."
3. If `repositoryFolders` has only one entry, tell the user: "You need at least one repository folder. Cannot remove the last entry."

### Step 2 — Show current repository folders

```
Current Repository Folders
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1  00_Resources/        0000–0999    Templates, admin, vault docs
 2  10_Personal/         1000–1999    Personal focuses and projects
 3  20_Professional/     2000–2999    Professional focuses and projects
```

(Omit range columns if `scopeMethod` is `incremental`.)

Ask: "Which repository folder would you like to remove? Enter the number."

### Step 3 — Confirm

> "You're about to remove **{folder}** ({theme}) from your repository folders."
>
> **This only removes the config entry.** The actual folder and its files are not affected. Any documents with scope IDs in the {rangeStart}–{rangeEnd} range will no longer have a registered home folder in ZettleDeck.
>
> "Are you sure? (yes/no)"

If no, cancel without changes.

### Step 4 — Write

Remove the selected entry from `repositoryFolders` and rewrite the complete config.json.

### Step 5 — Confirm

> "Repository folder removed. Run `/zettledeck.init folders` to see your updated structure."
