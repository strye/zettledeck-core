---
module: core
order: 10
description: Core vault structure, task management paths, and vault steering customization
---

# Core Initialization

Walk the user through configuring the foundational ZettleDeck settings. This covers vault identity, document organization, task management paths, and the vault steering template.

---

## 1. Vault Identity

**What:** Establish the vault's name and root path so other skills know where to operate.

**File:** Project CLAUDE.md (create or update)

**Questions:**

1. "What is the name of your Obsidian vault?"
   - Default: the project directory name

2. "Is the vault root the same as the project root, or is it at a different path?"
   - Default: project root (workspace directory)
   - If different: ask for the path

**How to apply:**

Add or update the vault configuration section in the project's CLAUDE.md:

```markdown
## Vault Configuration

- **Vault name:** {user's answer}
- **Vault path:** {project root or custom path}
```

Also update `obsidian.vault` skill's vault path reference if a custom path was given.

---

## 2. Top-Level Folder Structure

**What:** Define the vault's top-level organizational folders. These determine where scopes are placed.

**File:** `vault-steering.md` — Section 8 (Vault Placement Rules)

**Show the user** the current template defaults:

| Content theme | Top-level folder |
|--------------|-----------------|
| Admin, resources, templates | `00_Resources/` |
| Personal life, general interests | `10_General/` |
| Academic or domain research | `20_Research/` |
| Daily journaling, reflection | `30_Journal/` |
| Career, professional development | `40_Professional/` |
| Creative writing, art, music | `80_Creator/` |
| Hobbies, games | `90_Hobbies/` |
| Quick capture, scratch notes | `Void/` |

**Questions:**

1. "Here's the default folder structure. Does this work for you, or would you like to modify it?"
   - If yes: keep as-is, move on
   - If no: walk through each entry, asking what to add/remove/rename

2. "Do you have any additional top-level folders beyond these?"

**How to apply:**

Replace the table in Section 8 of `vault-steering.md` with the user's choices. Also update the subType table in Section 5 to match the folder names.

---

## 3. Scope SubTypes

**What:** Define what kinds of scopes live in each top-level folder. These drive document categorization.

**File:** `vault-steering.md` — Section 5 (scope subTypes table)

**Questions:**

For each top-level folder the user kept or added:

1. "What kinds of topics go in `{folder}`? For example, the Professional folder might have: career, growth, networking, goal"
   - Suggest reasonable defaults based on the folder name
   - Always include `goal` as an option

**How to apply:**

Update the scope subTypes table in Section 5 of `vault-steering.md`.

---

## 4. Task Management Paths

**What:** Configure where tasks without date context go (inbox) and where completed tasks are archived.

**File:** Project CLAUDE.md and/or `task.management` rules reference

**Questions:**

1. "Where should tasks without a date context be collected? This is your task inbox."
   - Default: `filo-fax/actions/actions.md` under `## Inbox`
   - Alternative: any path the user prefers

2. "Where should completed tasks be archived after 14 days?"
   - Default: `filo-fax/actions/actions-archive.md`
   - Alternative: any path the user prefers

3. "Is 14 days the right archival threshold, or would you prefer a different window?"
   - Default: 14 days

**How to apply:**

Add task configuration to the project's CLAUDE.md:

```markdown
## Task Configuration

- **Task inbox:** {path} under `## Inbox`
- **Task archive:** {path}
- **Archive threshold:** {N} days after completion/cancellation
```

---

## 5. Document Naming Convention

**What:** Confirm the Zettldex naming pattern and scope ID format.

**File:** `vault-steering.md` — Sections 4 and 9

**Questions:**

1. "ZettleDeck uses numeric scope IDs (e.g., 1001, 2050) as the root of hierarchical addresses. Are you starting fresh, or do you have existing scope IDs to preserve?"
   - Fresh: suggest starting range (e.g., 1000+)
   - Existing: note that the system will work with any numeric IDs

2. "The default filename pattern is `{Prefix}{ScopeId}_{PascalCaseTitle}` (e.g., `F1001_StrategyDomain`). Does this work for you?"
   - If yes: confirm and move on
   - If no: discuss alternatives (this is a significant structural decision)

**How to apply:**

If the user chooses defaults, no changes needed — the template is already configured. If they want a different pattern, update Sections 4 and 9 of `vault-steering.md`.

---

## 6. Additional Document Types

**What:** Check if the user needs document types beyond the defaults, or wants to remove types they won't use.

**File:** `vault-steering.md` — Sections 2 and 5

**Questions:**

1. "Here are the available document types: scope, focus, project, objective, content, engagement, meeting, note, ideation, research, lexicon, tune, way. Do you need all of these, or are some irrelevant to your vault?"
   - Common removals: lexicon (creative writing only), tune (music only), engagement (customer tracking)
   - Suggest keeping the core set: scope, focus, project, content, meeting, note, research

2. "Do you have any document types you'd like to add?"
   - Custom types are possible but require updating the prefix table, zettldex codes, and placement rules

**How to apply:**

If types are removed, comment them out (don't delete — easier to re-enable). If types are added, extend the relevant tables.

---

## 7. Review and Confirm

**What:** Show a summary of all configuration choices before finalizing.

**Present:**

```
Vault Configuration Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━
Vault name:        {name}
Vault path:        {path}
Top-level folders: {list}
Task inbox:        {path}
Task archive:      {path}
Archive threshold: {N} days
Scope ID range:    {range}
Document types:    {list of active types}
```

**Questions:**

1. "Does this look right? I'll apply these settings now."
   - Yes: apply all changes
   - No: go back to the specific section to adjust

**How to apply:**

Write all changes to the relevant files. Update `.zettledeck/init-state.yml` to record that core has been initialized:

```yaml
initialized:
  core:
    date: {today}
    vault_name: {name}
    vault_path: {path}
```

---

## Post-Init Message

After completing core initialization:

> Core setup complete. Your vault structure, task paths, and document conventions are configured.
>
> **Next steps:**
> - If you have other ZettleDeck modules installed, run `/zettledeck.init {module}` to configure them
> - Run `/zettledeck.init status` to see what's configured
> - Start using `/obsidian.vault` to interact with your vault
