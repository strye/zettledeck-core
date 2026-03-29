---
mode: remove-folder
description: Remove a folder entry from the document repository config
---

# Remove Folder

All changes write to `.zettledeck/core/config.json`. Skill files are never modified.

---

## Steps

### Step 1 — Pre-flight

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."
3. If `repositoryFolders` is empty or has only one entry, tell the user: "You need at least one folder in your config. Cannot remove the last entry."

### Step 2 — Show current folders

Display the numbered list of current folders:

```
Current Repository Folders
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1  00_Resources/        0000–0999    Templates, admin, vault docs
 2  10_Personal/         1000–1999    Personal focuses and projects
 3  20_Professional/     2000–2999    Professional focuses and projects
```

(Omit range columns if `scopeMethod` is `incremental`.)

Ask: "Which folder would you like to remove? Enter the number."

### Step 3 — Confirm

Show the selected entry and warn the user:

> "You're about to remove **{folder}** ({theme}) from your config."
>
> **This only removes the config entry.** The actual folder and its files in your vault are not affected. Any documents with scope IDs in the {rangeStart}–{rangeEnd} range will no longer have a registered home folder in ZettleDeck.
>
> "Are you sure you want to remove this entry? (yes/no)"

If the user says no, cancel and exit without changes.

### Step 4 — Write

Remove the selected entry from `repositoryFolders` and write the full updated config.json. Rewrite the complete file — do not attempt a partial edit.

### Step 5 — Confirm

> "Folder entry removed. Run `/zettledeck.init folders` to see your updated structure."
