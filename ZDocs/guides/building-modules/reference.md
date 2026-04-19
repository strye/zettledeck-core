---
title: Reference & Checklists
description: The full install and update behavior matrix, checklists for new modules and updates, and notes on publishing and versioning.
---

# Reference & Checklists

Lookup material. Use this page when you have a specific question about what happens on install vs update, what belongs in a module, or how to publish it.

## Install / update behavior summary


| File / Directory     | Install                                            | Update                                                       |
| -------------------- | -------------------------------------------------- | ------------------------------------------------------------ |
| `skills/`            | Copy dir, skip if exists                           | Replace entire dir                                           |
| `agents/`            | Copy file, skip if exists                          | Overwrite file                                               |
| `steering/`          | Copy file, skip if exists                          | Overwrite file                                               |
| `templates/`         | Copy file, skip if exists                          | Overwrite file                                               |
| `scripts/`           | Copy + chmod, skip if exists                       | Overwrite + re-chmod                                         |
| `scaffolding/`       | Create if absent (non-destructive)                 | Create if absent (non-destructive)                           |
| `providers/`         | Copy, skip if exists                               | Copy, skip if exists (source-aware)                          |
| `mcp.json`           | Merge by server name; skip duplicates with warning | Merge by server name; skip duplicates with warning           |
| `init-steps.md`      | Copy to `.zettledeck/{module}/`, skip if exists    | Overwrite                                                    |
| `note-rules.md`      | Copy to `.zettledeck/{module}/`, skip if exists    | Overwrite                                                    |
| `module-config.json` | Merge entries (additive, skip existing)            | Merge entries (replace module-owned, preserve user fields)   |
| `doc-types.json`     | **Deprecated** — warn and skip                     | **Deprecated** — warn and skip (migrate to `module-config.json`) |

## New module checklist

- [ ] `module-config.json` — declare `workspaceFolders` and any new `documentTypes`
- [ ] `note-rules.md` — declare workspace folders, placement, delegation, exclusions
- [ ] `init-steps.md` — if the module needs user configuration
- [ ] `skills/` — one directory per skill with `SKILL.md` and `resources/`
- [ ] `scaffolding/` — workspace directory structure the module needs at the project root
- [ ] `mcp.json` — if the module depends on an MCP server
- [ ] `providers/` — if the module introduces a capability provider
- [ ] `agents/` — if the module introduces a new agent persona
- [ ] `scripts/` — if the module ships shell utilities
- [ ] `README.md` at the module root — for GitHub browsers, module consumers, and your future self

## Updating an existing module checklist

- [ ] `source` field on all `module-config.json` entries matches the current module name
- [ ] `doc-types.json` migrated to `module-config.json` if it still exists
- [ ] `note-rules.md` exists and covers all workspace folders declared in `module-config.json`
- [ ] New workspace folders have `role` values that are unique across all modules
- [ ] `required: true` set on workspace folders that other skills depend on
- [ ] Any renamed fields handled for backward compatibility where possible
- [ ] Changelog updated if your repo keeps one

## Publishing and versioning

ZettleDeck doesn't define a formal versioning scheme for modules. Projects declare a git `ref` (branch, tag, or commit) in `zettledeck.yml`, and `zd install` / `zd update` clones that ref:

```yaml
modules:
  - name: zettledeck-praxis
    repo: github.com/strye/zettledeck-praxis
    ref: main
```

### Stable publishing

For stable releases, tag your module repo and direct users at tagged refs:

```yaml
modules:
  - name: zettledeck-praxis
    repo: github.com/strye/zettledeck-praxis
    ref: v1.2.0
```

Users who want the latest stable update one value and re-run `zd update`.

### Rapid iteration

For early development or where users accept breakage, point at `main` (or a development branch) and accept that updates track the tip:

```yaml
modules:
  - name: zettledeck-praxis
    repo: github.com/strye/zettledeck-praxis
    ref: main
```

### Private modules

Private modules work the same way — use a full git URL in the `repo` field instead of a GitHub short form. `zd` passes the URL to `git clone` verbatim when it can't short-circuit it.

```yaml
modules:
  - name: internal-tools
    repo: git@github.com:example-org/internal-tools.git
    ref: main

  - name: corp-integration
    repo: https://internal.example.com/repos/corp-integration.git
    ref: main
```

Authentication uses whatever the user's git client is already configured for — SSH keys, credential helpers, HTTP tokens. `zd` inherits that credential context; you don't configure it in ZettleDeck.

---

**Next reading:**

- [[README|Building Modules — index]] — back to the top
- [[conventions|Conventions & Composition]] — the rules that make modules play well together
- [[modules/core/zd-script|The `zd` Script]] — the composer that executes everything described here
