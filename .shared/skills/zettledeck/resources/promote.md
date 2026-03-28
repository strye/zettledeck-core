# ZettleDeck — Promote Mode

Promotes content from workspaces (Atelier, Chrysalis, Foundry, etc.) into the document repository with full ZettleDeck structure. This is the moment scope is assigned, zettldex address determined, frontmatter completed, and placement within the repo decided.

Before starting, read `documentRepo` from `.zettledeck/core/config.json`. This is the destination folder for all promoted content (default: `Reliquary`). Use this value — not the hardcoded name — everywhere below.

---

## Phase 1 — Read and Infer

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
4. **Existing scope** — read `scopeMethod` from `.zettledeck/core/config.json`, then check the document repo for an existing scope document that fits
5. **ScopeId assignment**:
   - If `scopeMethod: assignedRanges` — determine which top-level folder it belongs to, use that folder's `nextId`
   - If `scopeMethod: incremental` — use the top-level `nextId`
   - Always zero-pad to 4 digits: `"0001"` not `"1"`
6. **Parent hierarchy** — does an existing focus or project in the document repo fit as the parent?

---

## Phase 2 — Propose and Confirm

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
Destination:  {documentRepo}/{placement path}
Filename:     {PrefixId_Title.md}
```

Ask: "Does this look right? I'll apply these settings and move the file."

For anything uncertain, ask before proceeding:
- "I couldn't find a matching scope — would you like to create '{proposed name}' as a new scope, or assign this to an existing one?"
- "This could be a `content` or a `research` document — which fits better?"
- "Should this be standalone under the scope, or does it belong under an existing focus?"

---

## Phase 3 — Apply

After confirmation:

1. Read `vault-steering.md` to generate correct front-matter
2. Write updated frontmatter to the document
3. Move the file to its destination path inside `{documentRepo}`
4. If a new scope was created: create the scope document first, then place this document under it
5. If `scopeMethod: assignedRanges`: increment `nextId` for the appropriate folder in `.zettledeck/core/config.json`
6. If `scopeMethod: incremental`: increment top-level `nextId` in `.zettledeck/core/config.json`
7. Confirm what was done:

```
Promoted successfully.
━━━━━━━━━━━━━━━━━━━━━━
File:     {new path in documentRepo}
Scope:    {scope name} ({scopeId})
Zettldex: {address}
```
