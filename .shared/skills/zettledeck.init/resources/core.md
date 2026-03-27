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

Also update `obsidian` skill's vault path reference if a custom path was given.

---

## 2. Top-Level Folder Structure

**What:** Define the vault's top-level organizational folders. These determine where scopes are placed.

**File:** `obsidian/resources/vault-defaults.md` — Section 2 (Top-Level Folder Structure)

**Show the user** the current template defaults:

| Content theme | Top-level folder |
|--------------|-----------------|
| Admin, resources, templates | `00_Resources/` |
| Personal life, general interests | `10_General/` |
| Academic or domain research | `20_Research/` |
| Daily journaling, reflection | `30_Journal/` |
| Career, professional development | `40_Professional/` |
| Quick capture, scratch notes | `Void/` |

**Questions:**

1. "Here's the default folder structure. Does this work for you, or would you like to modify it?"
   - If yes: keep as-is, move on
   - If no: walk through each entry, asking what to add/remove/rename

2. "Do you have any additional top-level folders beyond these?"

**How to apply:**

Replace the table in Section 2 of `vault-defaults.md` with the user's choices. Also update the subType table in Section 3 (under scope) to match the folder names.

---

## 3. Scope SubTypes

**What:** Define what kinds of scopes live in each top-level folder. These drive document categorization.

**File:** `obsidian/resources/vault-defaults.md` — Section 3 (scope subTypes table)

**Questions:**

For each top-level folder the user kept or added:

1. "What kinds of topics go in `{folder}`? For example, the Professional folder might have: career, growth, networking, goal"
   - Suggest reasonable defaults based on the folder name
   - Always include `goal` as an option

**How to apply:**

Update the scope subTypes table in Section 3 of `vault-defaults.md`.

---

## 4. Task Management Paths

**What:** Configure where tasks without date context go (inbox) and where completed tasks are archived.

**File:** Project CLAUDE.md and/or `plan/references/task-operations.md`

**Questions:**

1. "Where should tasks without a date context be collected? This is your task inbox."
   - Default: `Praxis/actions/actions.md` under `## Inbox`
   - Alternative: any path the user prefers

2. "Where should completed tasks be archived after 14 days?"
   - Default: `Praxis/actions/actions-archive.md`
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

**File:** `obsidian/resources/vault-defaults.md` — Sections 1 and 5

**Questions:**

1. "ZettleDeck uses numeric scope IDs (e.g., 1001, 2050) as the root of hierarchical addresses. Are you starting fresh, or do you have existing scope IDs to preserve?"
   - Fresh: suggest starting range (e.g., 1000+)
   - Existing: note that the system will work with any numeric IDs

2. "The default filename pattern is `{Prefix}{ScopeId}_{PascalCaseTitle}` (e.g., `F1001_StrategyDomain`). Does this work for you?"
   - If yes: confirm and move on
   - If no: discuss alternatives (this is a significant structural decision)

**How to apply:**

If the user chooses defaults, no changes needed — the template is already configured. If they want a different pattern, update Sections 1 and 5 of `vault-defaults.md`.

---

## 6. Additional Document Types

**What:** Check if the user needs document types beyond the defaults, or wants to remove types they won't use.

**File:** `obsidian/resources/vault-defaults.md` — Sections 1 and 3

**Questions:**

1. "The core document types are: focus, project, objective, content, meeting, note, ideation, research. There are also two optional types: scope (top-level container for grouping related work) and engagement (interaction tracking). Would you like to enable either of these?"
   - Scope: explain that it's a powerful organizational layer but has a learning curve. Good for people managing distinct life/work domains. Can be enabled later.
   - Engagement: useful for tracking customer, partner, or team interactions.

2. "Do you have any document types you'd like to add?"
   - Custom types are possible but require updating the prefix table, zettldex codes, and placement rules

**How to apply:**

If optional types are enabled, uncomment them in Section 1 of `vault-defaults.md`. If custom types are added, extend the relevant tables.

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
> - Start using `/obsidian` to interact with your vault
