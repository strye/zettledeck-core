# ZettleDeck — The Way

## Philosophy

Ideas enter the system through the **Atelier** — raw, unstructured, no expectations. A passing thought, a half-formed question, a sketch of something that might matter. Nothing in the Atelier needs to justify its existence.

When something shows enough life to revisit, it moves to the **Chrysalis**. This is the incubation layer — fragments get connected, revisited, and either develop into something with shape or get quietly discarded. The Chrysalis is where patience does the work.

From the Chrysalis, ideas graduate based on what they're becoming:

- Content that needs to be crafted and refined moves to the **Foundry**, where it picks up structure, metadata, and intent before eventually publishing to the **Reliquary** for long-term storage.
- Work that needs external research routes through the **Tesseract**, where findings are gathered, processed, and then fed into wherever they're needed — Foundry, Nexus, or directly to the Reliquary.
- Shorter-form responses like emails and messages get handled in the **Scriptorium**.

Running alongside all of this is the **Nexus**, which looks inward rather than outward. It analyzes what's already accumulated across the vault — surfacing patterns, contradictions, implicit ideas, and cross-domain connections. Nexus doesn't create new content so much as it reveals what's already there but hasn't been articulated yet. Its outputs often feed back into the Chrysalis or Foundry as new threads to develop.

**Praxis** sits underneath everything as the operational backbone — diary entries, task management, ruthless priorities, and correspondence that keep the whole system moving with intention rather than just momentum.

The **Reliquary** is the final destination for anything worth keeping permanently.

---

## System vs Vault

ZettleDeck workspaces and the knowledge vault are two separate concerns.

**Workspaces** are the operational spaces described below — top-level folders where specific kinds of work happen (capture, incubation, research, content crafting, etc.). They are scaffolded by ZettleDeck modules.

**The vault** is the knowledge organization system — document types, Zettldex naming, front-matter taxonomy, scope hierarchies, and placement rules. It is configured via `.zettledeck/core/config.json` and governed by `vault-steering.md`.

The **Reliquary** is the bridge between the two: it is a workspace whose internal structure *is* the vault. Content graduates from other workspaces into the Reliquary, where it takes on vault structure (doc types, Zettldex addresses, full front-matter) and lives permanently.

When thinking about *where work happens* → workspaces. When thinking about *how knowledge is organized* → the vault.

---

## Workspace Structure

### Atelier
Raw capture space for unstructured notes, quick ideas, and spontaneous thinking. No format requirements, no metadata expectations — just get it down. Think of it as the artist's workbench where sketches, fragments, and "what if" notes land before they have any shape. Items here are ephemeral by default and graduate to Chrysalis or other spaces when they start to coalesce.

### Chrysalis
Incubation space where captured ideas from Atelier (or anywhere) sit while they develop. Notes here have shown enough promise to revisit but aren't yet structured enough for Foundry, Tesseract, or Nexus. Periodically review Chrysalis to promote items that have matured, merge related fragments, or discard ideas that have gone cold.

### Praxis
Daily practice and operational management — the backbone that keeps the system running with intention.
- Diary (daily, weekly, monthly files)
- Actions (task management)
- Ruthless priorities (top-level goals and priority management)
- Correspondence (via the Scriptorium workspace)

### Foundry
Content workshop where ideas get shaped into finished artifacts. Files here pick up full metadata, proper naming, and front-matter structure. Finished work publishes to the Reliquary.

### Nexus
Knowledge intelligence space — where vault analysis, idea surfacing, and reflective thinking produce artifacts. This is the convergence point for cross-domain connections, contradiction detection, trend analysis, and skill identification. Content here is the output of looking across the vault and finding what's hidden in the patterns: implicit ideas, evolving beliefs, and opportunities for synthesis.

### Document Repository
Core content management storage. The long-term home for finished, structured knowledge. This is the permanent collection — everything that lives here has full ZettleDeck structure (scope, zettldex, frontmatter, placement). The folder name defaults to `Reliquary` but is configurable via `documentRepo` in `.zettledeck/core/config.json`.

### Scriptorium
Space for analyzing and crafting smaller responses — emails, Slack messages, and other correspondence that needs thought but not the full Foundry treatment. Provided by the Praxis module alongside the Praxis workspace.

### Tesseract
Research space where external investigation happens. Items here are expected to either publish to the Reliquary for long-term storage, merge with other work (Foundry content, Nexus projects), or be discarded as one-time reference.

---

## The Flow

```
Atelier (raw capture)
    ↓
Chrysalis (incubation)
    ↓
    ├── Foundry (content crafting) → Reliquary (permanent storage)
    ├── Tesseract (research) → Reliquary / Foundry / Nexus
    └── Nexus (vault intelligence) → Chrysalis / Foundry
                                        ↑
Praxis (daily practice) ──────────── runs underneath everything
    └── Scriptorium (correspondence)
```
