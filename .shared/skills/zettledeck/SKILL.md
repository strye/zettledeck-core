---
name: zettledeck
description: ZettleDeck methodology reference and operations. Handles vault structure questions, concept help, and promoting content from workspaces to the document repository. Also called by other skills needing vault structure context.
---

# ZettleDeck

Core methodology skill. Routes to the relevant resource — don't load all resources at once.

## Invocation

```
/zettledeck help [question]     — Answer a question about ZettleDeck
/zettledeck promote [file]      — Promote content to the document repository
```

Auto-triggered when the user:
- Asks about ZettleDeck concepts, document types, or workflow
- Asks about a workspace folder by name (Atelier, Chrysalis, Praxis, Foundry, Nexus, Scriptorium, Tesseract, or the document repo)
- Wants to move or graduate content to permanent storage
- Seems confused about vault structure, naming, or placement

## Resource Files

| Resource | When to load |
|----------|-------------|
| `resources/help.md` | User asks a question about ZettleDeck concepts, workflow, or workspaces |
| `resources/promote.md` | User wants to promote a file to the document repository |
| `resources/the-way.md` | Deep philosophy questions, workspace flow, system design rationale |
| `resources/vault-steering.md` | Structural rules — addressing, frontmatter spec, tag rules, placement, validation |
| `resources/vault-defaults.md` | Document types, prefixes, subTypes, folder structure, naming patterns |

Other skills needing vault structure context should load `resources/vault-steering.md` and `resources/vault-defaults.md` directly.

---

## Config

Read at the start of any operation:

**File:** `.zettledeck/core/config.json`

Key values used by this skill:

| Key | Purpose |
|-----|---------|
| `workspaceFolders` | Active working areas at the vault root; role-keyed; note skill reads enabled entries; entry with `role: "documentRepo"` provides the repository folder name |
| `scopeMethod` | `assignedRanges` or `incremental` |
| `repositoryFolders` | Internal folder structure of the document repository (scope ID ranges) |
| `prefixesEnabled` | Whether filenames use single-letter type prefixes |

---

## Boundaries

**Always:**
- Resolve the repository folder at runtime: find the `workspaceFolders` entry where `role == "documentRepo"` and read its `folder` field. If not found, stop and tell the user.
- Follow recommend-first — propose before executing
- Preserve existing frontmatter when modifying documents

**Ask first:**
- Before moving any file
- Before creating a new scope document
- When docType or scope assignment is ambiguous

**Never:**
- Move a file without user confirmation
- Hardcode any folder name — always resolve via `workspaceFolders` roles
