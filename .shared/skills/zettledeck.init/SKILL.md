---
name: zettledeck.init
description: Initialize and configure a ZettleDeck project. Walks users through customization of vault structure, task paths, and module-specific settings. Use with optional module name to configure a specific module.
---

# ZettleDeck Project Initialization

Interactive setup skill that walks users through customizing their ZettleDeck project. Handles all placeholder configuration so users don't need to manually find and edit `<!-- CUSTOMIZE -->` markers or "configured by consuming project" references.

## Invocation

```
/zettledeck.init              → Run all available init steps (core + any installed modules)
/zettledeck.init core         → Core setup only (vault structure, task paths)
/zettledeck.init <module>     → Module-specific setup (e.g., praxis, nexus, foundry)
/zettledeck.init status       → Show what's been configured and what still needs setup
```

## How It Works

### Discovery

The skill discovers available init modules by scanning for resource files in two locations:

1. **This skill's resources/** — ships with core, always available
2. **`.zettledeck/*/init-steps.md`** — contributed by installed add-on modules (each module gets its own directory under `.zettledeck/`)

Each resource file defines the init steps for one module. When a module is installed via `zd install`, its root-level `init-steps.md` is copied into `.zettledeck/{module-name}/init-steps.md`.

### Interaction Model

For each configuration step:

1. **Explain** what's being configured and why it matters
2. **Show** the current value or placeholder
3. **Ask** the user for their preference (offer sensible defaults)
4. **Apply** the change to the appropriate file
5. **Confirm** what was written

Follow the recommend-first principle throughout — propose values, wait for approval.

### State Tracking

After initialization, write a `.zettledeck/init-state.yml` file to track what's been configured:

```yaml
initialized:
  core: 2026-03-22
  praxis: 2026-03-22
pending:
  - nexus
```

This allows `/zettledeck.init status` to report what's done and what still needs setup.

---

## Execution Steps

### Step 0 — Pre-flight

Before starting any module init:

1. Check that `.zettledeck/zettledeck.yml` exists
2. Read `.zettledeck/init-state.yml` if it exists to know what's already configured
3. If no module argument given, discover all available modules and present them:
   - "I found init steps for: **core**, **praxis**, **nexus**. Run all, or pick one?"

### Step 1 — Determine which module(s) to configure

| Argument | Behavior |
|----------|----------|
| (none) | Discover all, ask user to confirm running all or select |
| `core` | Run core resource only |
| `<module>` | Find and run that module's resource file |
| `status` | Report init state and exit |

### Step 2 — Load and execute resource file(s)

For each module being initialized:

1. Read the corresponding resource file (e.g., `resources/core.md`)
2. Walk through each configuration section in order
3. Apply changes as the user approves them
4. Mark the module as initialized in `.zettledeck/init-state.yml`

### Step 3 — Post-init summary

After all steps complete, provide a summary:
- What was configured
- Any steps that were skipped
- Suggested next actions (e.g., "Run `/zettledeck.init praxis` to set up your diary paths")

---

## Extending This Skill (For Module Authors)

To add init steps for your module, include an `init-steps.md` file in your module repository's root directory. The `zd install` command will copy it to `.zettledeck/{module-name}/init-steps.md`.

### Module Configuration Convention

Each module that needs runtime configuration should write a `config.json` file in its `.zettledeck/{module-name}/` directory. Init-steps should:

1. Document the config file format with all keys and defaults
2. Walk the user through each config key
3. Write the final `config.json` after all questions are answered
4. Update skill files that reference the config path

Skills read their config at runtime from `.zettledeck/{module-name}/config.json`. This keeps configuration co-located with the module that owns it.

### Init-steps file structure

The file should follow this structure:

```markdown
---
module: your-module-name
order: 20
description: One-line description of what this configures
---

## Configuration Convention

All {module} configuration is stored in `.zettledeck/{module-name}/config.json`.

### Config file format

**File:** `.zettledeck/{module-name}/config.json`

(show JSON template with all keys and defaults)

---

## Section Title

**What:** Explanation of what's being configured
**Config key:** `keyName`
**File:** path/to/file/being/modified (relative to project root)
**Marker:** The placeholder text or CUSTOMIZE marker to find
**Default:** A sensible default value

### Questions to ask the user

1. Question text here
   - Option A (default)
   - Option B

### How to apply

Instructions for what to write and where.
```

**Order field:** Controls the sequence when running all modules. Core is `10`, use `20+` for add-on modules.

**Discovery:** When a module is installed via `zd install`, its root-level `init-steps.md` is copied into `.zettledeck/{module-name}/init-steps.md`. The init skill discovers it automatically by scanning `.zettledeck/*/init-steps.md`.

---

## Resource Files

Available init resources are in the `resources/` subdirectory:

- [core.md](resources/core.md) — Vault structure, task paths, vault steering template
