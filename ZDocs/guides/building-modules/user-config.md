---
title: Init & Note Rules
description: The user-facing surfaces of a module — the setup wizard (init-steps.md) and the rules that govern note creation (note-rules.md).
---

# Init & Note Rules

The two files a user actually encounters when they install and use your module. `init-steps.md` runs once during `/zettledeck.init {module}`; `note-rules.md` governs how the note skill handles their workspace folders every day.

## `init-steps.md`

Provides initialization wizard steps for `/zettledeck.init {module-name}`. If your module has any user-facing configuration, it goes here.

**Installed to:** `.zettledeck/{module-name}/init-steps.md`

**Install behavior:** Skipped if already exists.

**Update behavior:** Always overwritten — module-owned content.

### Format

```markdown
---
module: {module-name}
order: 20
description: One-line description of what this configures
---

# {Module} Initialization

## Configuration Convention

All {module} configuration is stored in `.zettledeck/{module-name}/config.json`.

### Config file format

{JSON template with all keys and defaults}

---

## Section Title

**What:** What's being configured and why it matters
**Config key:** `keyName`
**Default:** sensible default

### Questions

1. "Question text?"
   - Option A (default)
   - Option B

### How to apply

Instructions for what to write and where.
```

### The `order` field

Controls sequence when running all modules. Core is `10`; use `20+` for add-on modules. When `/zettledeck.init` runs everything, it sorts by `order` ascending.

Pick an order that reflects when your module's config is *useful* to configure. A module that depends on core's vault config being set first should use a higher order. A module that's fully independent can use any value 20+.

### Where init writes

**Important:** init-steps writes *only* to `.zettledeck/` config files, provider files, `CLAUDE.md`, and `init-state.yml`. Skill files under `.claude/skills/` contain `{placeholder}` tokens that are resolved at runtime by reading the corresponding config. This separation ensures skills can be updated from source without overwriting project-specific configuration.

Do not write to skill files from init-steps. If a user-configurable value needs to reach a skill, put it in the module's `config.json` and have the skill read it at runtime.

### Interaction model

Each configuration section should follow the same pattern:

1. **Explain** what's being configured and why it matters.
2. **Show** the current value or the default.
3. **Ask** the user for their preference — offer a sensible default.
4. **Apply** the change to the appropriate file.
5. **Confirm** what was written.

Follow the recommend-first principle throughout: propose values, wait for approval.

## `note-rules.md`

Declares how the note skill should behave when creating notes in this module's workspace folders. Used by the note-creation flow to decide where a new note goes, when to delegate to a specialist skill, and which folders should never receive bare notes.

**Installed to:** `.zettledeck/{module-name}/note-rules.md`

**Install behavior:** Skipped if the file already exists (user may have customized it).

**Update behavior:** Always overwritten — module-owned content.

### Format

```markdown
---
module: {module-name}
---

# Note Rules — {Module Display Name}

## Workspace Folders

| Role | Folder | Accept new notes? |
|------|--------|-------------------|
| `role` | `Folder/` | Yes/No — and why |

## Placement Rules

| docType | Default role | Notes |
|---------|-------------|-------|
| `note`  | `role`      | ... |

## Delegation Rules

Describe when to offer a specialist skill instead of bare file creation.

### {Trigger description}

- **Skill:** `/skill-name mode`
- **Offer:** "The `skill` skill has a guided workflow — use it instead of a bare file?"
- **When:** Conditions that trigger the offer.

## Exclusions

| Role | Reason |
|------|--------|
| `role` | Why the note skill must never create files here |
```

### Rules for delegation entries

- Delegation is always an offer, never automatic. The user decides.
- If the user explicitly wants a bare file, proceed without delegation.
- Only delegate when a specialist skill produces meaningfully richer output than a bare file.

### Rules for exclusions

- Excluded folders are never valid note destinations.
- Include a redirect message explaining where to go instead.
- The `documentRepo` role is implicitly excluded from note creation in all modules — the note skill enforces this itself, but declaring it explicitly in your `note-rules.md` makes the rule discoverable.

---

**Next reading:**

- [[module-config|`module-config.json`]] — the schema that declares the workspace folders your `note-rules.md` references
- [[conventions|Conventions & Composition]] — the placeholder-marker system used in `init-steps.md`
- [[reference|Reference & Checklists]] — the new-module and update checklists that cover both files
