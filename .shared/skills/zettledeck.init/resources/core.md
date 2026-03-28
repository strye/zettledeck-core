---
module: core
order: 10
description: Core vault structure, task management paths, and vault steering customization
---

# Core Initialization

Walk the user through configuring the foundational ZettleDeck settings. This covers vault identity, document organization, task management paths, and the vault steering template.

## Configuration Convention

All ZettleDeck core configuration lives in `.zettledeck/core/config.json`. This file is the single source of truth for vault structure, task paths, and document conventions. Skills read their config at runtime from this file.

**Config file location:** `.zettledeck/core/config.json`

### Config file format — assignedRanges

```json
{
  "vaultName": "my-vault",
  "vaultPath": "Reliquary",
  "prefixesEnabled": true,
  "useEngagements": false,
  "scopeMethod": "assignedRanges",
  "topLevelFolders": [
    { "theme": "Templates, admin, vault docs", "folder": "00_Resources/", "rangeStart": 0, "rangeEnd": 999, "nextId": 0 },
    { "theme": "Personal focuses and projects", "folder": "10_Personal/", "rangeStart": 1000, "rangeEnd": 1999, "nextId": 1000 },
    { "theme": "Professional focuses and projects", "folder": "20_Professional/", "rangeStart": 2000, "rangeEnd": 2999, "nextId": 2000 }
  ],
  "scopeSubTypes": {
    "Resources": ["template", "reference", "admin"],
    "Personal": ["general", "health", "finance", "goal"],
    "Professional": ["career", "growth", "networking", "goal"]
  },
  "taskInbox": "Praxis/actions/actions.md",
  "taskArchive": "Praxis/actions/actions-archive.md",
  "taskArchiveThreshold": 14
}
```

### Config file format — incremental

```json
{
  "vaultName": "my-vault",
  "vaultPath": "Reliquary",
  "prefixesEnabled": true,
  "useEngagements": false,
  "scopeMethod": "incremental",
  "nextId": 1000,
  "topLevelFolders": [
    { "theme": "Templates, admin, vault docs", "folder": "00_Resources/" },
    { "theme": "Personal focuses and projects", "folder": "10_Personal/" },
    { "theme": "Professional focuses and projects", "folder": "20_Professional/" }
  ],
  "scopeSubTypes": {
    "Resources": ["template", "reference", "admin"],
    "Personal": ["general", "health", "finance", "goal"],
    "Professional": ["career", "growth", "networking", "goal"]
  },
  "taskInbox": "Praxis/actions/actions.md",
  "taskArchive": "Praxis/actions/actions-archive.md",
  "taskArchiveThreshold": 14
}
```

---

## Execution Steps

### Step 0 — Pre-flight

Before starting initialization:

1. Check that `.zettledeck/` exists
2. Check if `.zettledeck/core/config.json` already exists
3. If it exists, read it and proceed to **Phase 1: Review**
4. If it doesn't exist, proceed to **Phase 0: Wizard**

---

## Phase 0 — Initial Setup Wizard

If no config.json exists, walk the user through each configuration section in order. After all questions are answered, proceed to **Phase 1: Review**.

### 1. Vault Identity

**What:** Establish the vault's name and root path so other skills know where to operate.

**Config keys:** `vaultName`, `vaultPath`

**Questions:**

1. "What is the name of your Obsidian vault?"
   - Default: the project directory name

2. "Is the vault root the same as the project root, or is it at a subfolder?"
   - Default: `Reliquary` (standard ZettleDeck layout)
   - If different: ask for the path

### 2. Top-Level Folder Structure

**What:** Define the vault's top-level organizational folders.

**Config key:** `topLevelFolders`

**Show the user** the default starter structure:

| Content theme | Top-level folder |
|--------------|-----------------|
| Templates, admin, vault docs | `00_Resources/` |
| Personal focuses and projects | `10_Personal/` |
| Professional focuses and projects | `20_Professional/` |

**Questions:**

1. "Here's the default folder structure. Does this work for you, or would you like to modify it?"
   - If yes: keep as-is
   - If no: walk through each entry, asking what to add/remove/rename

2. "Do you have any additional top-level folders beyond these?"

**Note:** If adding folders, suggest using the numeric prefix pattern (00_, 10_, 20_, etc.) so assigned ranges can be derived from the prefix if that method is chosen.

### 3. Scope ID Method

**What:** Choose how scope IDs are assigned across the vault. Scope IDs are the numeric root of every document's hierarchical address.

**Config keys:** `scopeMethod`, and either `nextId` (incremental) or `rangeStart`/`rangeEnd`/`nextId` per folder (assignedRanges)

**Explain the two options:**

> **Assigned Ranges** — Each top-level folder gets its own numeric range, derived from the folder prefix. `00_Resources/` owns IDs 0–999, `10_Personal/` owns 1000–1999, etc. IDs immediately signal which folder a document belongs to. Best for vaults where folder identity matters.
>
> **Incremental** — A single global counter increments for every new document regardless of folder. Simpler, no range boundaries to manage. Best for smaller vaults or users who prefer not to think about ID structure.

**Questions:**

1. "Which scope ID method would you like to use?"
   - **Assigned ranges** (default) — ties IDs to folder prefixes
   - **Incremental** — global counter starting at a number you choose

2. If **assignedRanges**: derive ranges automatically from folder prefixes. Show the user the derived ranges for confirmation:
   ```
   00_Resources/    → 0000–0999
   10_Personal/     → 1000–1999
   20_Professional/ → 2000–2999
   ```
   Ask: "Does this look right? The ranges are derived from your folder prefixes."

3. If **incremental**: "What number should IDs start at?"
   - Default: 1000

### 4. Scope SubTypes

**What:** Define what kinds of scopes live in each top-level folder. These drive document categorization.

**Config key:** `scopeSubTypes`

**Questions:**

For each top-level folder the user kept or added:

1. "What kinds of topics go in `{folder}`?"
   - Suggest reasonable defaults based on the folder name
   - Always include `goal` as an option

### 5. Task Management Paths

**What:** Configure where tasks without date context go (inbox) and where completed tasks are archived.

**Config keys:** `taskInbox`, `taskArchive`, `taskArchiveThreshold`

**Questions:**

1. "Where should tasks without a date context be collected? This is your task inbox."
   - Default: `Praxis/actions/actions.md`
   - Alternative: any path the user prefers

2. "Where should completed tasks be archived?"
   - Default: `Praxis/actions/actions-archive.md`
   - Alternative: any path the user prefers

3. "How many days after completion should tasks be archived?"
   - Default: 14 days

### 6. Document Naming and Optional Types

**What:** Confirm prefix usage and enable optional document types.

**Config keys:** `prefixesEnabled`, `useEngagements`

**Questions:**

1. "File prefixes (single uppercase letters prepended to filenames, e.g., P1001_ProjectName) help identify document types at a glance. Would you like to enable them?"
   - Default: yes

2. "Engagements are an optional document type for tracking customer, partner, or team interactions. Would you like to enable them?"
   - Default: no — enable later if needed

---

## Phase 1 — Review and Confirm

**What:** Show a summary of all configuration choices before finalizing.

If the user came from **Phase 0** (wizard), this is the first time they see the summary. If they came from reading an existing config.json, show current values and ask if they want to modify any section.

### For first-time setup:

Present the wizard summary:

```
Vault Configuration Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━
Vault name:         {name}
Vault path:         {path}
Top-level folders:  {list of folders}
Scope ID method:    {assignedRanges | incremental}
  Ranges:           {folder → range, or "global nextId: N"}
Task inbox:         {path}
Task archive:       {path}
Archive threshold:  {N} days
File prefixes:      {enabled/disabled}
Engagements:        {enabled/disabled}
```

**Question:**

1. "Does this look right? I'll write this to `.zettledeck/core/config.json` and complete setup."
   - Yes: proceed to **Phase 2: Write Configuration**
   - No: ask which section to modify, go back to that step

### For existing config.json:

Present current values and ask:

1. "Your vault is currently configured as:" — (show current config summary)

2. "Would you like to make any changes?"
   - No changes: proceed to **Phase 2: Write Configuration**
   - Change {section}: walk through those steps only, return to Phase 1

---

## Phase 2 — Write Configuration

After the user confirms their configuration, apply the changes:

### Step 1 — Write config.json

Write `.zettledeck/core/config.json` with all finalized values. This is the single source of truth for vault structure, folders, and task paths. The obsidian skill reads this file at runtime.

For `assignedRanges`: include `rangeStart`, `rangeEnd`, and `nextId` on each folder entry.

For `incremental`: include a top-level `nextId` field. Folder entries have only `theme` and `folder`.

### Step 2 — Update CLAUDE.md

Add or update a **Vault Configuration** section in the project's CLAUDE.md:

```markdown
## Vault Configuration

- **Config location:** `.zettledeck/core/config.json`
- Vault name, path, folder structure, and task paths are configured here.
- Edit that file directly, or run `/zettledeck.init core` again to reconfigure.
```

### Step 3 — Update init state

Write `.zettledeck/init-state.yml`:

```yaml
initialized:
  core:
    date: {today}
    vaultName: {name}
    vaultPath: {path}
pending: []
```

---

## Post-Init Message

After completing core initialization:

> Core setup complete. Your vault structure, task paths, and document conventions are configured in `.zettledeck/core/config.json`.
>
> **Next steps:**
> - You can manually edit `.zettledeck/core/config.json` at any time. Changes take effect immediately.
> - Or run `/zettledeck.init core` again to reconfigure via the wizard.
> - If you have other ZettleDeck modules installed, run `/zettledeck.init {module}` to configure them
> - Run `/zettledeck.init status` to see what's configured
> - Start using `/obsidian` to interact with your vault
