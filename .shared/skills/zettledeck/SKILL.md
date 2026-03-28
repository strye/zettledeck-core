---
name: zettledeck
description: ZettleDeck methodology reference and operations. Handles vault structure questions, concept help, and promoting content from workspaces (Atelier, Chrysalis, etc.) to the Reliquary. Also called by other skills needing vault structure context.
---

# ZettleDeck

Core methodology skill. Provides vault structure reference, conversational help, and content promotion to the Reliquary. Other skills should draw on `resources/vault-steering.md` and `resources/vault-defaults.md` when they need to understand vault structure, document types, or placement rules.

## Invocation

```
/zettledeck help [question]     — Answer a question about ZettleDeck
/zettledeck promote [file]      — Promote content to the Reliquary
```

Auto-triggered when the user:
- Asks about ZettleDeck concepts, document types, or workflow
- Asks about a workspace folder by name (Atelier, Chrysalis, Praxis, Foundry, Nexus, Reliquary, Scriptorium, Tesseract)
- Wants to move or graduate content to permanent storage
- Seems confused about vault structure, naming, or placement

---

## Knowledge Sources

When answering questions or determining placement, draw from:

| Topic | Source |
|-------|--------|
| System philosophy and workspace flow | `zettledeck/resources/the-way.md` |
| Document types, prefixes, subTypes | `zettledeck/resources/vault-defaults.md` |
| Hierarchical addressing (zettldex) | `zettledeck/resources/vault-steering.md` Section 4 |
| Front-matter specification | `zettledeck/resources/vault-steering.md` Section 3 |
| Tag rules | `zettledeck/resources/vault-steering.md` Section 5 |
| Status values and lifecycle | `zettledeck/resources/vault-steering.md` Section 7 |
| Placement and folder rules | `zettledeck/resources/vault-steering.md` Section 6 |
| Validation rules | `zettledeck/resources/vault-steering.md` Section 9 |
| File naming conventions | `zettledeck/resources/vault-defaults.md` Section 5 |
| Markdown and task format | `markdown/rules.md`, `markdown/task-format.md` |
| Project setup and init | `zettledeck.init/SKILL.md` and `zettledeck.init/resources/core.md` |
| Vault configuration | `.zettledeck/core/config.json` |

---

## Help Mode

Answer questions conversationally. Explain concepts plainly first, then follow with specifics, examples, or rules if relevant. Reference the source file so the user can dig deeper.

### Core Concepts

**1. The Hierarchy**
```
Scope → Focus → Project → Documents (content, notes, meetings, objectives, etc.)
```
Every document knows its place through front-matter metadata. Scopes are the domain anchors — all documents in a domain share a `scopeId` regardless of where they physically live in the vault.

**2. Document Types**
- **scope** — domain anchor, root of the knowledge graph. One per domain.
- **focus** — thematic area within a scope
- **project** — defined effort with deliverables
- **objective** — trackable goal or milestone
- **content** — produced document or creative output
- **meeting** — meeting notes (one-time or recurring)
- **note** — miscellaneous notes; `subType: jot` for quick capture
- **ideation** — brainstorming and idea capture
- **research** — research and analysis

Optional: **engagement** (interaction tracking, if enabled in config)

**3. ScopeId and Zettldex**
Every document has a `scopeId` that binds it to a domain. The `zettldex` encodes its position in the hierarchy:
- Scope: `1001.S`
- Focus under scope: `1001.S.F`
- Project under focus: `1001.S.F.P`
- Note under project: `1001.S.F.P.N`

**4. File Naming**
`{Prefix}{ScopeId}_{PascalCaseTitle}.md` — e.g., `P1001_WebsiteRedesign.md`

**5. Front-Matter**
YAML front-matter encodes type, position, lineage, status, and tags — making the hierarchy machine-readable.

### Common Questions

- "What's the difference between a focus and a project?"
  → A focus is a domain or theme (ongoing). A project is a specific effort with an end state.
- "Do I need a scope?"
  → Yes — scopes are core to ZettleDeck. They're the domain anchor that links all related documents via `scopeId`. See `the-way.md` for the full philosophy.
- "Where does this file go?"
  → Reference placement rules in `vault-steering.md` Section 6.
- "What status should I use?"
  → See the status table in `vault-steering.md` Section 7.
- "How do I move/reorganize things?"
  → Movement doesn't break relationships — `scopeId` is the connection, not the folder. Use `/obsidian move` if the obsidian module is installed.
- "How do I set up my vault?"
  → Run `/zettledeck.init core`.

### Workspace Questions

When users ask about workspace folders, reference `resources/the-way.md`. Key points:
- **Atelier** — zero-friction raw capture. No format, no metadata.
- **Chrysalis** — incubation. Things that showed promise but aren't structured yet.
- **Praxis** — operational backbone: diary, tasks, priorities.
- **Foundry** — content workshop. Ideas get shaped into finished artifacts.
- **Nexus** — vault intelligence. Looks inward at patterns and connections.
- **Reliquary** — permanent vault storage. Final destination for structured knowledge.
- **Scriptorium** — correspondence and shorter-form responses.
- **Tesseract** — active research space.

### Tone

- Friendly and patient — this is a learning tool
- Use analogies (zettldex is like a street address for your notes)
- Don't assume prior PKM knowledge
- If the user seems overwhelmed, suggest starting simple

---

## Promote Mode

Promotes content from workspaces (Atelier, Chrysalis, Foundry, etc.) into the Reliquary with full ZettleDeck structure. This is the moment scope is assigned, zettldex address determined, frontmatter completed, and placement within the Reliquary decided.

### Workflow

**Phase 1 — Read and Infer**

Read the source document and infer as much as possible:

1. **Title** — from filename or first heading
2. **docType** — from content character:
   - Notes/capture → `note`
   - Ideas/brainstorming → `ideation`
   - Research → `research`
   - Produced written artifact → `content`
   - Meeting record → `meeting`
   - If clearly a domain overview → `scope` or `focus`
3. **subType** — from content tone and structure
4. **Existing scope** — search `.zettledeck/core/config.json` for `scopeMethod`, then check the Reliquary for an existing scope document that fits
5. **ScopeId assignment**:
   - If `scopeMethod: assignedRanges` — determine which top-level folder it belongs to, use that folder's `nextId`
   - If `scopeMethod: incremental` — use the top-level `nextId`
6. **Parent hierarchy** — does an existing focus or project in the Reliquary fit as the parent?

**Phase 2 — Propose and Confirm**

Present inferences with recommendations. Follow the recommend-first principle throughout.

```
Promotion Proposal
━━━━━━━━━━━━━━━━━━━━━━━━━━━
Source:       {source path}
Title:        {inferred title}
docType:      {inferred type}
subType:      {inferred subType}
Scope:        {existing scope name (ID)} or "New scope — {proposed name}"
ScopeId:      {assigned ID}
Zettldex:     {derived address}
Parent:       {parent file} or "Standalone under scope"
Destination:  {Reliquary path}
Filename:     {PrefixId_Title.md}
```

Ask: "Does this look right? I'll apply these settings and move the file."

For anything uncertain, ask before proceeding:
- "I couldn't find a matching scope — would you like to create '{proposed name}' as a new scope, or assign this to an existing one?"
- "This could be a `content` or a `research` document — which fits better?"
- "Should this be standalone under the scope, or does it belong under an existing focus?"

**Phase 3 — Apply**

After confirmation:

1. Read `vault-steering.md` to generate correct front-matter
2. Write updated frontmatter to the document
3. Move the file to its Reliquary destination path
4. If a new scope was created: create the scope document first, then place this document under it
5. If `scopeMethod: assignedRanges`: increment `nextId` for the appropriate folder in `.zettledeck/core/config.json`
6. If `scopeMethod: incremental`: increment top-level `nextId` in `.zettledeck/core/config.json`
7. Confirm what was done:

```
Promoted successfully.
━━━━━━━━━━━━━━━━━━━━━━
File:    {new path in Reliquary}
Scope:   {scope name} ({scopeId})
Zettldex: {address}
```
