---
title: Templates, Scaffolding & Scripts
description: The module assets that land on disk verbatim — templates, workspace scaffolding, and shell scripts.
---

# Templates, Scaffolding & Scripts

The three asset types that land on disk as-is. None of these change behavior directly — they provide files and folders that behavior (skills, agents, scripts the user runs) can operate against.

## `templates/`

Template files made available to users (and to skills) as scaffolding for new documents.

**Installed to:** `.shared/templates/`

**Install behavior:** Each file copied. Skipped if already exists (preserves user customizations).

**Update behavior:** Each file overwritten.

Use templates for the starter content a skill will copy when creating a new document. A weekly-review template, a meeting-notes template, a project brief template. Skills reference templates by name from `.shared/templates/` at runtime.

The skip-if-exists rule on install means a user can edit a template and have their edits survive until they explicitly want the upstream version back. An update overwrites — this is by design, because templates are module-owned content and the user should pick up improvements.

## `scaffolding/`

Directory and file structure to create at the project root on install. Non-destructive — never overwrites existing files or directories.

**Installed to:** Project root (recursively, per the tree under `scaffolding/`).

**Install behavior:** Directories created if absent; files copied if absent. Existing content is never touched.

**Update behavior:** Same as install — non-destructive. `scaffolding/` is for *bootstrap* scenarios where the module needs a folder or starter file to exist; once it's there, the user owns it.

### Format

```
scaffolding/
├── Praxis/
│   ├── diary/
│   └── actions/
└── Scriptorium/
```

Use scaffolding for the workspace folder structure a module depends on. If your module provides the Praxis workspace, scaffold `Praxis/diary/`, `Praxis/actions/`, and `Praxis/ruthless-priorities/` so skills have a place to write from the moment the module is installed.

### Scaffolding vs templates

The two can look similar. The distinction:

- **Scaffolding** lands at the project root, once, and the user takes ownership. It's for directory structure and starter files that a workspace needs.
- **Templates** live in `.shared/templates/` and are module-owned. Skills copy *from* them when creating new documents.

A file lives in `scaffolding/` if it should only exist once at the project root. It lives in `templates/` if it's a source that skills stamp out copies from.

## `scripts/`

Shell scripts installed to `.zettledeck/scripts/` and made executable.

**Installed to:** `.zettledeck/scripts/`

**Install behavior:** Each file copied and `chmod +x` applied. Skipped if already exists.

**Update behavior:** Each file overwritten and re-chmod'd.

Scripts are for non-skill automation — cron-style tasks, pre-commit hooks, vault maintenance utilities, small CLIs a user might want to run manually. If the capability is conversational — something the user asks the assistant to do — put it in a skill instead. Scripts are for things that run without a conversation around them.

Core itself ships two scripts as a reference: `bootstrap` (installs `jq` and `yq` across platforms) and `zd` (the module composer itself). Both are examples of the scripts pattern done at scale.

---

**Next reading:**

- [[skills-and-agents|Skills & Agents]] — the behavioral assets that often use these project assets at runtime
- [[integrations|MCP Servers & Providers]] — the external-service plumbing that pairs with scripts
- [[conventions|Conventions & Composition]] — naming rules, placeholder markers, optional dependency detection
