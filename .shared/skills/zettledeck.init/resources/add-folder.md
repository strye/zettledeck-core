---
mode: add-folder
description: Interactive wizard to add a new folder entry to the document repository config
---

# Add Folder

All changes write to `.zettledeck/core/config.json`. Skill files are never modified.

---

## Steps

### Step 1 — Pre-flight

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."
3. Note the current `scopeMethod` — it determines which questions to ask

### Step 2 — Gather folder details

Ask the following questions in order. Use recommend-first: propose a value, wait for approval.

**Question 1 — Theme**
"What is the theme or purpose of this folder? (e.g., 'Community involvement', 'Side projects')"

**Question 2 — Folder path**
"What is the folder path? This can be a top-level folder or a subfolder of an existing one."

- Top-level example: `30_Community/`
- Subfolder example: `20_Professional/21_Career`
- Suggest using the numeric prefix pattern (`30_`, `21_`, etc.) for consistency, but do not require it

**Question 3 — Range (assignedRanges only)**

Skip this question if `scopeMethod` is `incremental`.

"What scope ID range should this folder own?"

- Derive a suggestion from the numeric prefix if the folder follows the pattern (e.g., `30_` → 3000–3999, `21_` → 2100–2199)
- Show the suggestion: "Based on your prefix, I'd suggest range **3000–3999**. Does that work, or would you like a custom range?"
- Validate: the proposed range must not overlap with any existing `rangeStart`/`rangeEnd` in `topLevelFolders`
- If overlap detected, show which folder owns that range and ask the user to choose a different range
- Set `nextId` to `rangeStart`

### Step 3 — Confirm

Show a summary before writing:

```
New Folder Entry
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Theme:       {theme}
Folder:      {folder}
Range:       {rangeStart}–{rangeEnd}   (assignedRanges only)
Next ID:     {nextId}                  (assignedRanges only)
```

Ask: "Shall I add this to your config?"

### Step 4 — Write

Append the new entry to `topLevelFolders` in `.zettledeck/core/config.json`.

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

Write the full updated config.json — do not mutate only the array; rewrite the complete file to avoid JSON corruption.

### Step 5 — Confirm and suggest next steps

> "Folder added. Run `/zettledeck.init folders` to see your updated structure."
>
> **Note:** This adds the entry to your config. Create the actual folder in your vault manually, or ask me to create it.
