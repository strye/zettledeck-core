---
mode: add-folder
description: Interactive wizard to add a folder to workspace or repository config
---

# Add Folder

All changes write to `.zettledeck/core/config.json`. Skill files are never modified.

Two folder types exist — determine which the user intends:

- `--workspace` — a root-level working area (goes into `workspaceFolders`)
- `--repo` — an internal partition inside the document repository (goes into `repositoryFolders`)

If no flag is provided, ask:
> "Are you adding a workspace folder (a root-level working area like Foundry or Tesseract) or a repository folder (an internal partition inside your document repository)?"

---

## add-folder --workspace

### Step 1 — Pre-flight

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."

### Step 2 — Gather folder details

**Question 1 — Folder name**
"What is the name of this workspace folder? (e.g., `Foundry/`, `Nexus/`)"

**Question 2 — Role**
"What role should this folder have? The role is a stable identifier used by skills — lowercase, no spaces, no slashes. (e.g., `foundry`, `nexus`)"

- Suggest a slugified default from the folder name (strip trailing `/`, lowercase, replace spaces with `-`)
- Validate: role must be unique across existing `workspaceFolders` entries

**Question 3 — Description**
"Brief description of what this folder is for?"

### Step 3 — Confirm

```
New Workspace Folder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Folder:       {folder}
Role:         {role}
Description:  {description}
Source:       custom
Enabled:      true
```

Ask: "Shall I add this to your config?"

### Step 4 — Write

Append to `workspaceFolders` in `.zettledeck/core/config.json`:

```json
{
  "folder": "{folder}",
  "role": "{role}",
  "description": "{description}",
  "source": "custom",
  "enabled": true
}
```

Rewrite the complete file — do not attempt a partial edit.

### Step 5 — Confirm

> "Workspace folder added. Run `/zettledeck.init folders` to see your updated structure."
>
> **Note:** This adds the entry to your config. Create the actual folder in your vault manually, or ask me to create it.

---

## add-folder --repo

### Step 1 — Pre-flight

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."
3. Note the current `scopeMethod` — it determines whether to ask range questions

### Step 2 — Gather folder details

**Question 1 — Theme**
"What is the theme or purpose of this folder? (e.g., 'Community involvement', 'Side projects')"

**Question 2 — Folder path**
"What is the folder path inside the repository? (e.g., `30_Community/`, `20_Professional/21_Career`)"

- Suggest using the numeric prefix pattern (`30_`, `21_`, etc.) for consistency, but do not require it

**Question 3 — Range (assignedRanges only)**

Skip this question if `scopeMethod` is `incremental`.

"What scope ID range should this folder own?"

- Derive a suggestion from the numeric prefix if the folder follows the pattern (e.g., `30_` → 3000–3999)
- Show the suggestion: "Based on your prefix, I'd suggest range **3000–3999**. Does that work, or would you like a custom range?"
- Validate: the proposed range must not overlap with any existing `rangeStart`/`rangeEnd` in `repositoryFolders`
- If overlap detected, show which folder owns that range and ask for a different range
- Set `nextId` to `rangeStart`

### Step 3 — Confirm

```
New Repository Folder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Theme:       {theme}
Folder:      {folder}
Range:       {rangeStart}–{rangeEnd}   (assignedRanges only)
Next ID:     {nextId}                  (assignedRanges only)
```

Ask: "Shall I add this to your config?"

### Step 4 — Write

Append to `repositoryFolders` in `.zettledeck/core/config.json`.

**assignedRanges entry:**
```json
{
  "theme": "{theme}",
  "folder": "{folder}",
  "rangeStart": {rangeStart},
  "rangeEnd": {rangeEnd},
  "nextId": {rangeStart}
}
```

**incremental entry:**
```json
{
  "theme": "{theme}",
  "folder": "{folder}"
}
```

Rewrite the complete file — do not attempt a partial edit.

### Step 5 — Confirm

> "Repository folder added. Run `/zettledeck.init folders` to see your updated structure."
>
> **Note:** This adds the entry to your config. Create the actual folder inside your document repository manually, or ask me to create it.
