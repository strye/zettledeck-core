---
title: Core Configuration
description: Key-by-key reference for .zettledeck/core/config.json — the file that holds vault structure, scope ID method, document types, and folder layout.
---

# Core Configuration

Every ZettleDeck project has a `.zettledeck/core/config.json` file that holds the core vault configuration. This is the authoritative reference for every key — what it controls, what values it accepts, and how it interacts with the source ownership model.

For the *why* behind these fields, read [[vault-structure|Vault Structure]] first. This page is the *what*: the schema, field by field.

## File location and edit rules

**Path:** `.zettledeck/core/config.json`

**When to edit by hand:** any time. The file is user-editable JSON.

**When to use `/zettledeck.init`:** for guided workflows that validate your input and prevent common mistakes. Use the wizard modes when you can:

- `/zettledeck.init core` — full guided setup
- `/zettledeck.init folders` / `add-folder` / `remove-folder` — manage folder entries
- `/zettledeck.init doc-types` / `add-doc-type` / `remove-doc-type` — manage document types
- `/zettledeck.init sync-ids` — reconcile `nextId` values against what's actually in the vault

**What never to touch:** the `source` field on module-owned entries. Set it to `"custom"` if you genuinely want to take ownership of an entry (which makes it immune to module updates), but otherwise leave it alone. See [[#Source ownership]] below.

## Top-level keys

```json
{
  "prefixesEnabled": true,
  "scopeMethod": "assignedRanges",
  "repositoryFolders": [ ... ],
  "workspaceFolders": [ ... ],
  "scopeSubTypes": { ... },
  "documentTypes": [ ... ]
}
```


| Key                 | Type    | Purpose                                                           |
| ------------------- | ------- | ----------------------------------------------------------------- |
| `prefixesEnabled`   | boolean | Whether filenames use single-letter type prefixes (`P1001_…`)    |
| `scopeMethod`       | string  | `"assignedRanges"` or `"incremental"` — how new scope IDs are assigned |
| `repositoryFolders` | array   | Internal partitions inside the document repository                |
| `workspaceFolders`  | array   | Root-level working areas (Nexus, Reliquary, and any registered by modules)   |
| `scopeSubTypes`     | object  | Per-repository-folder list of valid scope subTypes                |
| `documentTypes`     | array   | Registered document types with prefix, subTypes, placement, parents |

## `prefixesEnabled`

Whether filenames should use a single-letter type prefix.

- `true` → `P1001_ProjectName.md` (prefix `P`, scopeId `1001`, title)
- `false` → `1001_ProjectName.md` (no prefix)

When prefixes are enabled, the prefix is the first letter in the filename *and* the segment added to the zettldex. Disabling prefixes is a common choice for users who want cleaner filenames at the cost of some at-a-glance information.

**Note:** changing this setting after you have a populated vault is disruptive. Existing files don't rename themselves. Decide this at project setup time and keep it.

## `scopeMethod`

How new scope IDs are assigned when you promote new content or create a new scope.


| Value              | How it works                                                                                                     |
| ------------------ | ---------------------------------------------------------------------------------------------------------------- |
| `"assignedRanges"` | Each top-level repository folder owns a numeric range. `10_Personal/` owns 1000–1999, etc. IDs signal domain.   |
| `"incremental"`    | A single global counter increments for every new scope. IDs carry no domain signal.                             |

With `assignedRanges`, each `repositoryFolders` entry declares its own `rangeStart`, `rangeEnd`, and `nextId`. With `incremental`, only the top-level counter applies.

Both methods zero-pad IDs to 4 digits — a counter of `7` becomes scopeId `"0007"`.

## `repositoryFolders`

The internal folder partitions *inside* the document repository (the Reliquary). These are distinct from `workspaceFolders` — repositoryFolders live inside the Reliquary, workspaceFolders live at the project root.

### Entry format

```json
{
  "theme": "Personal focuses and projects",
  "folder": "10_Personal/",
  "rangeStart": 1000,
  "rangeEnd": 1999,
  "nextId": 1047
}
```


| Field        | Required            | Description                                                                                          |
| ------------ | ------------------- | ---------------------------------------------------------------------------------------------------- |
| `theme`      | yes                 | Short human-readable label for the partition                                                         |
| `folder`     | yes                 | Physical folder path inside the document repository                                                  |
| `rangeStart` | if `assignedRanges` | Lower bound of the scope ID range this folder owns                                                    |
| `rangeEnd`   | if `assignedRanges` | Upper bound of the range                                                                             |
| `nextId`     | yes                 | Next scopeId to assign. Auto-incremented by `/zettledeck promote`; reconcilable via `sync-ids`.      |

### Default layout

```json
"repositoryFolders": [
  { "theme": "Templates, admin, vault docs",        "folder": "00_Resources/",   "rangeStart": 0,    "rangeEnd": 999,  "nextId": 0 },
  { "theme": "Personal focuses and projects",       "folder": "10_Personal/",    "rangeStart": 1000, "rangeEnd": 1999, "nextId": 1000 },
  { "theme": "Professional focuses and projects",   "folder": "20_Professional/", "rangeStart": 2000, "rangeEnd": 2999, "nextId": 2000 }
]
```

### Adding a folder

Use `/zettledeck.init add-folder --repo` for the guided path. For hand-editing: append a new entry to the array with a unique, non-overlapping range.

### Keeping `nextId` honest

`nextId` drifts when scopes are created outside `/zettledeck promote` (manually, via other tools, or during migrations). Run `/zettledeck.init sync-ids` to scan the vault, find the highest scopeId actually in use per folder, and reset each `nextId` to the next available value.

## `workspaceFolders`

The root-level working areas of the project. Each entry is role-keyed — skills resolve physical folder names via `role`, so the user can rename a folder freely without breaking anything.

### Entry format

```json
{
  "folder": "Nexus/",
  "role": "nexus",
  "description": "Vault intelligence — knowledge graph analysis, idea surfacing, and reflection",
  "source": "core",
  "required": true,
  "enabled": true
}
```


| Field         | Required                    | Description                                                                                   |
| ------------- | --------------------------- | --------------------------------------------------------------------------------------------- |
| `role`        | yes                         | Stable identifier used by skills. Unique across all modules. Never rename.                   |
| `folder`      | yes                         | Physical folder name. The user may rename freely; `preserveUserFields` keeps their choice.   |
| `description` | recommended                 | Short label describing what this workspace is for                                             |
| `source`      | yes                         | `"core"`, a module name, or `"custom"` — governs update ownership                             |
| `enabled`     | recommended                 | Whether the workspace is active. Disable to exclude from note-creation flows.                 |
| `required`    | no                          | If `true`, the entry cannot be removed or disabled via `/zettledeck.init`.                    |

### The `documentRepo` role

Exactly one `workspaceFolders` entry must have `role: "documentRepo"`. This is the permanent-storage folder — the Reliquary. The `/zettledeck promote` skill resolves the destination folder by looking up this entry at runtime. The default is `Reliquary/`.

The `documentRepo` entry is always `required: true`. It cannot be removed or disabled.

### Role resolution

Skills never hardcode folder names. They look up the role in `workspaceFolders` and read the `folder` field. This is how a user can rename `Reliquary/` to `Vault/` or `Archive/` without breaking anything — the role stays the same, the folder name changes, and skills follow along.

See [[building-modules/module-config|`module-config.json`]] for how modules register their own workspace folders.

## `scopeSubTypes`

Per-repository-folder list of valid scope subTypes. Used when creating a new scope document to limit the subType options to what makes sense for the folder.

### Format

```json
"scopeSubTypes": {
  "Resources": ["template", "reference", "admin"],
  "Personal": ["general", "health", "finance", "goal"],
  "Professional": ["career", "growth", "networking", "goal"]
}
```

The keys are the partition names (derived from the `repositoryFolders` entries); the values are the valid subTypes for scopes in that partition.

## `documentTypes`

The registered document types. Core ships with six foundational types; modules register more.

### Entry format

```json
{
  "docType": "project",
  "prefix": "P",
  "description": "A defined project with deliverables",
  "validParents": ["scope", "focus"],
  "defaultStatus": "steady",
  "subTypes": ["content", "strategy", "forecast", "research", "development", "campaign"],
  "placement": { "type": "creates-subfolder", "folder": "3_Projects" },
  "source": "core"
}
```


| Field              | Required  | Description                                                                                       |
| ------------------ | --------- | ------------------------------------------------------------------------------------------------- |
| `docType`          | yes       | Primary type keyword (lowercase, used in frontmatter)                                             |
| `prefix`           | yes       | Single uppercase letter for filenames and zettldex segments                                       |
| `description`      | yes       | Short description of the type's purpose                                                           |
| `validParents`     | yes       | List of docTypes that may be the parent. Empty array means top-level (scope docs).               |
| `defaultStatus`    | yes       | Default status applied to new documents of this type. May be `null` (user must choose).           |
| `subTypes`         | yes       | List of valid subType values — or `"scopeSubTypes"` to use the per-folder subtype list           |
| `placement`        | yes       | Placement rule object: `{ "type": "...", "folder": "..." }` (see [[#Placement types]])           |
| `extraFrontmatter` | no        | Extra required frontmatter fields for this type (e.g., `["freqType", "freq", "start", "end"]`)   |
| `source`           | yes       | `"core"`, a module name, or `"custom"` — governs update ownership                                 |

### Placement types

The `placement.type` controls where new documents of this type are placed relative to their parent:


| Type                 | What it means                                                                           |
| -------------------- | --------------------------------------------------------------------------------------- |
| `scope-folder`       | The document IS the folder — used only for scope docs. Creates `{scopeId}_{Title}/`.  |
| `creates-subfolder`  | Creates a numbered subfolder inside the parent. Used for focus, project, objective, content. |
| `flat-in-subfolder`  | Places the file flat in a shared subfolder. Used for meetings.                          |
| `same-folder`        | Places the file in the parent's folder directly. Used for notes, research.              |

See [[vault-structure#Placement rules]] for what each type produces on disk.

### Core document types

Core registers six:


| Prefix | docType     | Valid parents                                    | defaultStatus  |
| ------ | ----------- | ------------------------------------------------ | -------------- |
| `S`    | `scope`     | — (top-level)                                    | `steady`       |
| `F`    | `focus`     | `scope`                                          | `steady`       |
| `P`    | `project`   | `scope`, `focus`                                 | `steady`       |
| `O`    | `objective` | `scope`, `focus`, `project`, `content`           | `null`         |
| `C`    | `content`   | `scope`, `focus`, `project`, `content`           | `active`       |
| `N`    | `note`      | `scope`, `focus`, `project`, `objective`, `content`, `meeting` | `"na"` |

Modules can register additional types via `module-config.json` — `meeting` (M), `ideation` (I), `research` (R), etc. See [[building-modules/module-config|`module-config.json`]] for the authoring details.

### Adding a document type

Use `/zettledeck.init add-doc-type` for the guided path. It prompts for every field and validates your input.

Hand-editing: append to the `documentTypes` array with all required fields and `"source": "custom"`. A `"custom"` source will never be touched by `zd update`.

## Source ownership

Every entry in `workspaceFolders`, `repositoryFolders`, and `documentTypes` carries a `source` field:


| Source value       | Update behavior                                               |
| ------------------ | ------------------------------------------------------------- |
| `"core"`           | Managed by `zettledeck-core`. Only core updates touch it.    |
| `"{module-name}"`  | Replaced by the module on `zd update`                         |
| `"custom"`         | User-owned. `zd` never modifies it.                          |

Two practical implications:

1. **If you want to "fork" an entry** (e.g., customize a core-registered workspace folder), change its `source` to `"custom"`. It's yours now; core updates won't reset it.
2. **If you want a module update to refresh an entry**, leave the `source` alone. The `preserveUserFields` list on the module's own `module-config.json` specifies which individual fields of yours survive the refresh (typically `enabled` and `folder` for workspace entries).

See [[building-modules/module-config#Source ownership model]] for the full model.

## `preserveUserFields` — what modules protect

Some fields are always protected from module updates, even on module-owned entries:

- **`workspaceFolders`** — `enabled` and `folder` are protected. Users can rename workspace folders and disable entries, and module updates will preserve both.
- **Other sections** — modules can declare their own `preserveUserFields` on a per-section basis.

## Common edits

### Rename a workspace folder

Edit the `folder` field of the relevant `workspaceFolders` entry. Role stays the same. Skills pick up the new folder name immediately.

### Disable a workspace

Set `enabled: false` on the entry (except `documentRepo`, which cannot be disabled). The note skill and other note-creation flows will skip the folder.

### Add a custom document type

Easiest: `/zettledeck.init add-doc-type`. Hand edit: append to `documentTypes` with `"source": "custom"`.

### Change scope method

Edit `scopeMethod`. If switching from `incremental` to `assignedRanges`, you'll need to add `rangeStart`/`rangeEnd`/`nextId` to each `repositoryFolders` entry. Then run `/zettledeck.init sync-ids` to reconcile `nextId` values against what's actually in the vault.

---

**Next reading:**

- [[README|zettledeck-core Reference]] — back to the core reference index
- [[vault-structure|Vault Structure]] — the *why* behind every field on this page
- [[zd-script|The `zd` script]] — how module updates interact with config entries
- [[building-modules/module-config|`module-config.json`]] — for module authors writing entries that get merged in
