---
title: module-config.json
description: The config merge system — how a module registers document types, workspace folders, and other core configuration; the source ownership model; and per-field preservation across updates.
---

# `module-config.json`

Declares configuration sections to merge into `.zettledeck/core/config.json` at install/update time. This is how a module registers new document types, new workspace folders, or entries in any other config section.

This is the hardest file in a module to get right, and the most important one. A module with nothing else — no skills, no agents, no scripts — but a well-formed `module-config.json` is already useful.

## Install and update behavior

**Installed to:** Merged into `.zettledeck/core/config.json` — not copied verbatim.

**Install behavior:** Additive only. Entries already registered (by any `source`) are skipped so modules never trample each other or user customizations on first install.

**Update behavior:** Replaces entries whose `source` equals the current module name. Preserves the values of any fields listed in `preserveUserFields`. Never touches entries sourced as `custom` or owned by another module.

## Format

```json
{
  "{configSectionKey}": {
    "mergeKey": "{fieldThatUniquelyIdentifiesAnEntry}",
    "preserveUserFields": ["fieldA", "fieldB"],
    "entries": [
      {
        "{mergeKey}": "value",
        "source": "{module-name}",
        "...": "..."
      }
    ]
  }
}
```


| Field                | Required | Description                                                                                                 |
| -------------------- | -------- | ----------------------------------------------------------------------------------------------------------- |
| `mergeKey`           | yes      | Field used to identify existing entries (e.g., `"docType"` for documentTypes, `"role"` for workspaceFolders) |
| `preserveUserFields` | no       | Fields `zd update` never overwrites — user-owned after first install                                       |
| `entries`            | yes      | Array of objects to merge into the named config section                                                     |

Every entry must include a `"source": "{module-name}"` field. This field governs ownership and is covered in detail in [[#Source ownership model]] below.

## Supported config sections

### `documentTypes`

Register a new document type that participates in vault structure. `mergeKey: "docType"`.

```json
{
  "documentTypes": {
    "mergeKey": "docType",
    "entries": [
      {
        "docType": "meeting",
        "prefix": "M",
        "description": "Meeting notes, one-time or recurring",
        "validParents": ["scope", "focus", "project"],
        "defaultStatus": "na",
        "subTypes": ["customer", "team", "workshop", "training"],
        "placement": { "type": "flat-in-subfolder", "folder": "4_Meetings" },
        "extraFrontmatter": ["freqType", "freq", "start", "end", "time"],
        "source": "zettledeck-praxis"
      }
    ]
  }
}
```

Every field above is required except `extraFrontmatter`. See [[vault-structure]] for the meaning of each field and [[modules/core/configuration|Configuration]] for the full schema.

### `workspaceFolders`

Register a workspace root folder. `mergeKey: "role"`. `preserveUserFields: ["enabled", "folder"]`.

```json
{
  "workspaceFolders": {
    "mergeKey": "role",
    "preserveUserFields": ["enabled", "folder"],
    "entries": [
      {
        "folder": "Praxis/",
        "role": "praxis",
        "description": "Operational workspace — daily planning, tasks, and priorities",
        "source": "zettledeck-praxis",
        "required": true,
        "enabled": true
      }
    ]
  }
}
```

`enabled` and `folder` belong in `preserveUserFields` for workspace folders — users can rename folders and disable entries freely, and `zd update` must not reset those choices.

`required: true` means the entry cannot be removed or disabled by the user via `/zettledeck.init`. Skills that depend on the folder enforce this at runtime.

### Adding new config sections

Any top-level key in `module-config.json` is treated as a config section. If the key doesn't yet exist in `core/config.json`, `zd` creates it as an empty array and appends the entries. No change to `zd` is needed when introducing a new section type — the merge logic is generic.

If your module needs a new kind of registry, just declare it. Pick a clear `mergeKey`, decide which fields are user-owned (if any), and commit.

## Source ownership model

Every entry in `module-config.json` must include `"source": "{module-name}"`. This field governs all update behavior and is how ZettleDeck supports modules without modules clobbering each other (or your customizations).


| Source value       | Update behavior                                               |
| ------------------ | ------------------------------------------------------------- |
| `"{module-name}"`  | Replaced by the module on `zd update`                         |
| `"core"`           | Managed by `zettledeck-core`; other modules must skip it      |
| `"custom"`         | User-owned; `zd` never touches it                             |
| Other module name  | Skipped — that module owns it                                 |

The rules in plain English:

- Your module can update what your module previously wrote.
- Your module cannot touch what `core` wrote, what another module wrote, or what the user has customized.
- The user can edit anything they want and have those edits survive updates. They do this either by setting `source: "custom"` or by relying on `preserveUserFields` to protect specific fields on module-owned entries.

## `preserveUserFields` — per-field protection

For module-owned entries where the user might reasonably want to override specific fields (like `enabled` or the user's preferred folder name), declare those fields in `preserveUserFields`. `zd update` will re-apply the module's canonical entry but keep the user's value for each protected field.

This is the pattern for letting users rename workspace folders freely while still getting schema updates from the module. Example sequence:

1. Module first install: writes `folder: "Praxis/"`.
2. User renames the folder to `Operations/` by editing config directly or running `/zettledeck.init add-folder`.
3. Module update: tries to rewrite the entry with `folder: "Praxis/"` — but because `folder` is in `preserveUserFields`, the update keeps `Operations/` and applies only the other field changes (description, subType list, etc.).

Pick `preserveUserFields` carefully. Fields that define the *contract* (role, prefix, mergeKey value) should never be preserved — the module owns the contract. Fields that represent *preference* (enabled, folder, display name) usually should be.

---

**Next reading:**

- [[skills-and-agents|Skills & Agents]] — the behavioral assets your module ships
- [[conventions|Conventions & Composition]] — naming rules, placeholder markers, optional dependency detection
- [[reference|Reference & Checklists]] — the install/update behavior matrix and author checklists
