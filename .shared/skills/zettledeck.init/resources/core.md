---
module: core
order: 10
description: Core vault structure — folder layout, scope ID method, document naming conventions
---

# Core Initialization

Walk the user through configuring the foundational ZettleDeck settings. This covers folder structure, scope ID method, scope subtypes, and document naming conventions.

**Out of scope for core init:**
- Vault name and path — configured during `zettledeck-obsidian` init
- Task inbox and archive paths — configured during `zettledeck-praxis` init

## Configuration Convention

All ZettleDeck core configuration lives in `.zettledeck/core/config.json`. This file is the single source of truth for vault structure and document conventions. Skills read their config at runtime from this file.

**Config file location:** `.zettledeck/core/config.json`

> **Two types of folders — don't confuse them:**
>
> `workspaceFolders` — Active working areas at the vault root. Role-keyed so physical names can be renamed without breaking skills. The entry with `role: "documentRepo"` locates the permanent repository. This is what the note skill reads. Modules register additional entries at install time; users manage entries via `add-folder --workspace`.
>
> `repositoryFolders` — The internal organizational partitions *inside* the document repository. Contain scope ID ranges. Managed via `add-folder --repo`. Unrelated to workspace root folders.

### Config file format — assignedRanges

```json
{
  "prefixesEnabled": true,
  "scopeMethod": "assignedRanges",
  "repositoryFolders": [
    { "theme": "Templates, admin, vault docs", "folder": "00_Resources/", "rangeStart": 0, "rangeEnd": 999, "nextId": 0 },
    { "theme": "Personal focuses and projects", "folder": "10_Personal/", "rangeStart": 1000, "rangeEnd": 1999, "nextId": 1000 },
    { "theme": "Professional focuses and projects", "folder": "20_Professional/", "rangeStart": 2000, "rangeEnd": 2999, "nextId": 2000 }
  ],
  "workspaceFolders": [
    { "folder": "Nexus/",     "role": "nexus",        "description": "Vault intelligence — knowledge graph analysis, idea surfacing, and reflection", "source": "core", "required": true, "enabled": true },
    { "folder": "Reliquary/", "role": "documentRepo", "description": "Permanent document repository",              "source": "core", "required": true, "enabled": true }
  ],
  "scopeSubTypes": {
    "Resources": ["template", "reference", "admin"],
    "Personal": ["general", "health", "finance", "goal"],
    "Professional": ["career", "growth", "networking", "goal"]
  }
}
```

### Config file format — incremental

```json
{
  "prefixesEnabled": true,
  "scopeMethod": "incremental",
  "nextId": 1000,
  "repositoryFolders": [
    { "theme": "Templates, admin, vault docs", "folder": "00_Resources/" },
    { "theme": "Personal focuses and projects", "folder": "10_Personal/" },
    { "theme": "Professional focuses and projects", "folder": "20_Professional/" }
  ],
  "workspaceFolders": [
    { "folder": "Nexus/",     "role": "nexus",        "description": "Vault intelligence — knowledge graph analysis, idea surfacing, and reflection", "source": "core", "required": true, "enabled": true },
    { "folder": "Reliquary/", "role": "documentRepo", "description": "Permanent document repository",              "source": "core", "required": true, "enabled": true }
  ],
  "scopeSubTypes": {
    "Resources": ["template", "reference", "admin"],
    "Personal": ["general", "health", "finance", "goal"],
    "Professional": ["career", "growth", "networking", "goal"]
  }
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

### 1. Repository Folder Structure

**What:** Define the internal organizational folders of the document repository (the Reliquary). These are not the workspace root folders — they are the partitions *inside* the permanent storage vault.

**Config key:** `repositoryFolders`

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

### 2. Scope ID Method

**What:** Choose how scope IDs are assigned across the vault. Scope IDs are the numeric root of every document's hierarchical address.

**Format rule**: Scope IDs are always stored and displayed as 4-digit zero-padded strings — `"0001"` not `"1"`, `"0999"` not `"999"`. This applies in frontmatter, filenames, zettldex values, and tags. The config stores raw integers for range arithmetic; always zero-pad when writing them to documents.

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

### 3. Scope SubTypes

**What:** Define what kinds of scopes live in each top-level folder. These drive document categorization.

**Config key:** `scopeSubTypes`

**Questions:**

For each top-level folder the user kept or added:

1. "What kinds of topics go in `{folder}`?"
   - Suggest reasonable defaults based on the folder name
   - Always include `goal` as an option

### 4. Workspace Folders

**What:** The active working areas at the vault root. These are the folders where in-progress notes live before promotion. Each entry has a stable `role` identifier — physical folder names can be renamed without breaking skill behavior.

**Config key:** `workspaceFolders`

**Default entries (pre-configured by core):**

| Folder | Role | Description |
|--------|------|-------------|
| `Nexus/` | `nexus` | Vault intelligence — knowledge graph analysis, idea surfacing, and reflection |
| `Reliquary/` | `documentRepo` | Permanent document repository |

> **Note:** Additional workspace folders (e.g., Atelier, Chrysalis, Foundry) are registered by optional modules at install time. See `the-way.md` for the full workspace picture.

**Questions:**

1. "Here are the default workspace folders. Would you like to rename any of them to match your style?"
   - If yes: for each renamed folder, update the `folder` field. The `role` stays the same.
   - Both entries are required and cannot be removed. They can be renamed (e.g., `Vault/` for the document repo, `Knowledge/` for nexus).

2. "Would you like to add any additional workspace folders?"
   - If yes: collect folder name, role (slugified suggestion from folder name), and description. Set `source: "custom"`, `enabled: true`.

**Note:** You can manage entries at any time via `/zettledeck.init add-folder --workspace` and `/zettledeck.init remove-folder --workspace`.

### 5. Document Naming

**What:** Confirm whether to use single-letter prefixes on filenames.

**Config key:** `prefixesEnabled`

**Questions:**

1. "File prefixes (single uppercase letters prepended to filenames, e.g., `P1001_ProjectName`) help identify document types at a glance in the file system. Would you like to enable them?"
   - Default: yes

---

## Phase 1 — Review and Confirm

**What:** Show a summary of all configuration choices before finalizing.

If the user came from **Phase 0** (wizard), this is the first time they see the summary. If they came from reading an existing config.json, show current values and ask if they want to modify any section.

### For first-time setup:

Present the wizard summary:

```
Vault Configuration Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━
Repository folder:  {workspaceFolders[role:documentRepo].folder}
Workspace folders:  {role: folder, ...}
Repository folders: {list of repo partition folders}
Scope ID method:    {assignedRanges | incremental}
  Ranges:           {folder → range, or "global nextId: N"}
Scope subtypes:     {folder: [subtypes], ...}
File prefixes:      {enabled/disabled}
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

Write `.zettledeck/core/config.json` with all finalized values.

For `assignedRanges`: include `rangeStart`, `rangeEnd`, and `nextId` on each folder entry.

For `incremental`: include a top-level `nextId` field. Folder entries have only `theme` and `folder`.

### Step 2 — Update CLAUDE.md

Add or update a **Vault Configuration** section in the project's CLAUDE.md:

```markdown
## Vault Configuration

- **Config location:** `.zettledeck/core/config.json`
- Vault folder structure, scope ID method, and document naming conventions are configured here.
- Edit that file directly, or run `/zettledeck.init core` again to reconfigure.
```

### Step 3 — Update init state

Write `.zettledeck/init-state.yml`:

```yaml
initialized:
  core:
    date: {today}
pending: []
```

---

## Post-Init Message

After completing core initialization:

> Core setup complete. Your vault folder structure and document conventions are configured in `.zettledeck/core/config.json`.
>
> **Next steps:**
> - You can manually edit `.zettledeck/core/config.json` at any time. Changes take effect immediately.
> - Or run `/zettledeck.init core` again to reconfigure via the wizard.
> - If you have other ZettleDeck modules installed, run `/zettledeck.init {module}` to configure them.
> - Run `/zettledeck.init status` to see what's configured.
