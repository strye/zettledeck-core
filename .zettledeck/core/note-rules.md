---
module: core
---

# Note Rules — Nexus

Rules for the note skill when operating within Nexus workspace folders.

---

## Workspace Folders

| Role | Folder | Accept new notes? |
|------|--------|-------------------|
| `nexus` | `Nexus/` | Yes — notes and artifacts that result from vault intelligence work |

---

## Placement Rules

When a docType is identified, suggest the following folder by default:

| docType | Default role | Notes |
|---------|-------------|-------|
| `note` | `nexus` | Observations, captured insights, and synthesis notes |
| `ideation` | `nexus` | Ideas surfaced or generated from vault analysis |
| `research` | `nexus` | Analytical outputs from insight or reflection sessions |

---

## Delegation Rules

Nexus skills (`insight`, `reflection`) are analysis tools — they produce output rather than accepting input for note creation. The note skill does not delegate to them. Notes placed in Nexus are typically the result of already having run a Nexus skill session; the user is capturing or saving the output.

No delegation rules apply.

---

## Exclusions

No Nexus folders are excluded from note creation. `nexus` is a valid destination for any note type.
