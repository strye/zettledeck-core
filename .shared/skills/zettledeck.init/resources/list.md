---
mode: list
description: Lists all available zettledeck.init modes with descriptions
---

# Available Modes — zettledeck.init

Display the following table to the user. Then scan `.zettledeck/*/init-steps.md` for any installed module init files and append them to the module init section.

---

## Init Modes

These modes walk through configuration wizards and write to `.zettledeck/` config files.

| Mode | Description |
|------|-------------|
| `/zettledeck.init` | Run all available init steps — core plus any installed modules |
| `/zettledeck.init core` | Core setup only: folder structure, scope ID method, document naming |
| `/zettledeck.init <module>` | Run init steps for a specific installed module (e.g., `praxis`, `nexus`) |
| `/zettledeck.init status` | Show what has been configured and what still needs setup |

**Installed modules** (discovered from `.zettledeck/*/init-steps.md`):

> List each discovered module here by name with its `description` field from the frontmatter.
> If no modules are found beyond core, say: "No additional modules installed."

---

## Folder Management Modes

These modes read and write `.zettledeck/core/config.json`. They are safe to run at any time and do not affect skill files.

| Mode | Description |
|------|-------------|
| `/zettledeck.init folders` | Show the current top-level folder structure |
| `/zettledeck.init add-folder` | Add a new folder entry to the document repository |
| `/zettledeck.init remove-folder` | Remove a folder entry from the document repository |
| `/zettledeck.init sync-ids` | Scan the vault and correct all nextId values in config |

---

## Document Type Management Modes

These modes read and write `.zettledeck/core/config.json`. They are safe to run at any time and do not affect skill files.

| Mode | Description |
|------|-------------|
| `/zettledeck.init doc-types` | Show all registered document types |
| `/zettledeck.init add-doc-type` | Add a new document type to the vault |
| `/zettledeck.init remove-doc-type` | Remove a document type from the vault |

---

## Utility Modes

| Mode | Description |
|------|-------------|
| `/zettledeck.init list` | Show this help listing |
