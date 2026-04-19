---
title: The Way
description: The framing document for ZettleDeck — how ideas flow through the system, the distinction between workspaces and vault, and the two lineages (Zettelkasten and LLM Wiki) that shape it.
---

# The Way

ZettleDeck is a way of working with ideas — from the first half-formed thought to the polished artifact that earns permanent keeping. This document is the framing: what the system believes, how ideas move through it, and why it is shaped the way it is.

Read this first. Everything else in [[README|ZDocs]] assumes you have this picture.

## Two lineages

ZettleDeck stands on two earlier patterns. Understanding both clarifies what we keep and what we extend.

### The Zettelkasten

Niklas Luhmann's Zettelkasten wasn't a filing cabinet — it was a thinking partner. Tens of thousands of atomic notes, connected by explicit links where the *reason for the link* was itself the knowledge being created. Structure emerged from use. Ideas recombined in ways Luhmann hadn't anticipated. He credited the system as a genuine collaborator in his prolific output.

Four principles carry forward unchanged:

- **Atomicity** — one idea per note, so ideas can recombine like molecules.
- **Connection, not collection** — the value lives in the links, and the *explicit why* of each link is knowledge being created.
- **Emergent structure** — organization grows organically from the material, not imposed top-down.
- **Thinking partner, not storage** — the system surfaces patterns and tensions you didn't yet see.

But a working Zettelkasten is brutal to maintain. Updating cross-references, keeping summaries current, flagging contradictions, pruning stale claims, noticing what's missing — the bookkeeping grows faster than the value. Humans abandon wikis because the maintenance is what makes them worth having.

### The LLM Wiki

Karpathy's [LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) points out what's newly possible: LLMs don't get bored. An LLM can ingest a new source, touch fifteen pages to update summaries and cross-references, flag contradictions with what it read last month, and file the result — in one pass, on every source. The wiki stays alive because the manual cost of maintenance drops to near zero.

You curate. You ask good questions. You think about what it all means. The LLM handles everything else: summarizing, cross-referencing, filing, linting, noticing what's missing.

### The synthesis

ZettleDeck takes the Zettelkasten's principles (atomicity, explicit connections, emergent structure, thinking partner) and the LLM Wiki's implementation (the LLM owns maintenance) and wraps them in a practical work-management framework that acknowledges one thing the older patterns didn't say plainly: **ideas don't arrive ready to file.** They need to be captured messily, incubated, researched, shaped, and *then* graduated into permanent structure.

So ZettleDeck gives ideas room to mature before they earn their place in the Zettelkasten.

## System vs vault — two separate concerns

ZettleDeck has two distinct organizing structures, and they are not the same. Confusing them leads to a lot of wasted effort.

**Workspaces** are *where work happens*. Each workspace is a top-level folder with a specific operational purpose — the [[#Atelier]] for raw capture, the [[#Chrysalis]] for incubation, and so on. Workspaces are about the *stage* of an idea, not its *subject*. Modules scaffold workspaces; you move work between them by graduating files forward.

**The vault** is *how knowledge is organized* — document types, hierarchical addressing (Zettldex), scope and frontmatter taxonomy, and placement rules. The vault structure governs the files that live permanently in the [[#Reliquary]]. It's configured in `.zettledeck/core/config.json` and explained in detail in [[vault-structure|Vault Structure]].

The [[#Reliquary]] is the bridge between the two: it is a workspace whose *internal structure is the vault*. When content graduates from other workspaces into the Reliquary, it takes on full vault structure — scope, docType, zettldex address, complete frontmatter — and lives permanently.

| When you're thinking about…      | You're in…                            |
| ---------------------------------- | --------------------------------------- |
| Where work happens at which stage | **Workspaces** (this document)        |
| How knowledge is organized        | **The vault** ([[vault-structure]])   |

A common mistake is to read the workspace list and assume it's the vault's folder structure. It isn't. The vault has its own hierarchy inside the Reliquary, independent of the workspaces that feed it.

## The flow

```
Atelier → Chrysalis → ┬── Foundry ───→ Reliquary
                ↑     ├── Tesseract → Reliquary / Foundry / Nexus / Chrysalis
                │     └── Nexus ─────→ Chrysalis / Foundry
                │                        ↑
                └────────── research loop back for further refinement
Praxis ─────────────────────── runs underneath everything
  └── Scriptorium
```

Ideas enter through the [[#Atelier]] — raw, unstructured, no expectations. A passing thought, a half-formed question, a sketch of something that might matter. Nothing in the Atelier needs to justify its existence.

When something shows enough life to revisit, it moves to the [[#Chrysalis]]. This is the incubation layer — fragments get connected, revisited, and either develop into something with shape or get quietly discarded. The Chrysalis is where patience does the work.

From the Chrysalis, ideas graduate based on what they're becoming:

- Content that needs to be crafted and refined moves to the [[#Foundry]], where it picks up structure, metadata, and intent before publishing to the [[#Reliquary]] for long-term storage.
- Work that needs external research routes through the [[#Tesseract]], where findings are gathered, processed, and then fed into wherever they're needed — Foundry, Nexus, directly to the Reliquary, or back into the Chrysalis for further refinement before they're ready to be shaped.
- Shorter-form responses like emails and messages get handled in the [[#Scriptorium]].

Running alongside all of this is the [[#Nexus]], which looks inward rather than outward. It analyzes what's already accumulated across the vault — surfacing patterns, contradictions, implicit ideas, and cross-domain connections. Nexus doesn't create new content so much as it reveals what's already there but hasn't been articulated yet. Its outputs often feed back into the Chrysalis or Foundry as new threads to develop. This is where the Luhmann promise — the system as thinking partner — becomes operational.

[[#Praxis]] sits underneath everything as the operational backbone — diary entries, task management, ruthless priorities, and correspondence that keep the whole system moving with intention rather than just momentum.

The [[#Reliquary]] is the final destination for anything worth keeping permanently.

## Workspaces

Eight workspaces. Each is a top-level folder. Not every project uses every workspace — install the modules that provide the ones you need. Core scaffolds Atelier, Chrysalis, and Reliquary. Add-on modules scaffold the rest.

### Atelier

Raw capture space for unstructured notes, quick ideas, and spontaneous thinking. No format requirements, no metadata expectations — just get it down. Think of it as the artist's workbench where sketches, fragments, and "what if" notes land before they have any shape.

The Atelier serves two roles:

- **The thought without a home** — a half-formed idea that doesn't yet know what it's going to become. These typically graduate to the Chrysalis to incubate.
- **The quick capture in transit** — a note that *does* have a home but there's no time right now to file it properly. Meeting notes headed for the diary, a thought headed for a project in the Foundry or Reliquary, a reference item destined for the Tesseract. The Atelier holds it so it isn't lost, and it gets moved to its real home later.

Items here are ephemeral by default. They graduate to wherever they ultimately belong when the moment is right, or they quietly disappear when they don't earn a destination.

Tooling for routing Atelier items to their destinations is on the roadmap — for now, graduate files by hand or use `/zettledeck promote` when the destination is the Reliquary.

**Scaffolded by:** `zettledeck-core`.

### Chrysalis

Incubation space where captured ideas from Atelier (or anywhere else) sit while they develop. Notes here have shown enough promise to revisit but aren't yet structured enough for Foundry, Tesseract, or Nexus.

Periodically review Chrysalis to:

- Promote items that have matured into their next workspace
- Merge related fragments into a single stronger idea
- Discard ideas that have gone cold

The Chrysalis honors the Zettelkasten's emergent-structure principle: nothing gets forced into a predetermined category. Ideas declare what they're becoming by what they connect to and how they develop.

**Scaffolded by:** `zettledeck-core`.

### Praxis

Daily practice and operational management — the backbone that keeps the system running with intention.

- **Diary** — daily, weekly, monthly files
- **Actions** — task management (emoji signifiers, priority markers, attribution patterns)
- **Ruthless priorities** — top-level goals and strategic focus

Praxis is where you track what you're actually doing, not what you're thinking about. It sits underneath everything else because good knowledge work requires operational discipline.

**Scaffolded by:** `zettledeck-praxis`.

### Foundry

Content workshop where ideas get shaped into finished artifacts. Files here pick up full metadata, proper naming, and front-matter structure. Finished work publishes to the Reliquary.

If the Chrysalis is where ideas incubate, the Foundry is where they get built. Expect work in the Foundry to cycle — drafts, revisions, reviews — before it's ready to publish.

**Scaffolded by:** `zettledeck-foundry`.

### Nexus

Knowledge intelligence space — where vault analysis, idea surfacing, and reflective thinking produce artifacts. This is the convergence point for cross-domain connections, contradiction detection, trend analysis, and skill identification.

Content in the Nexus is the output of looking across the vault and finding what's hidden in the patterns: implicit ideas, evolving beliefs, tensions worth investigating, and opportunities for synthesis. This is the Karpathy pattern (ingest / query / lint) extended with a fourth operation — *discover* — that makes the Nexus a thinking partner rather than just a knowledge store.

The Nexus is what turns an accumulation of notes into something that thinks with you.

**Scaffolded by:** `zettledeck-nexus`.

### Reliquary

Core content management storage — the long-term home for finished, structured knowledge. Everything that lives here has full ZettleDeck structure: scope, zettldex address, docType, complete frontmatter, explicit placement.

The Reliquary is the Zettelkasten proper — the place where Luhmann's principles apply most strictly. [[vault-structure]] is the full reference for what that structure looks like.

The folder name defaults to `Reliquary` but is configurable. Skills resolve it at runtime via the `workspaceFolders` entry with `role: "documentRepo"` in `.zettledeck/core/config.json` — you can rename the folder freely and nothing breaks.

**Scaffolded by:** `zettledeck-core`.

### Scriptorium

Space for analyzing and crafting smaller responses — emails, Slack messages, and other correspondence that needs thought but not the full Foundry treatment. Provided alongside Praxis as part of the daily-practice toolkit.

The Scriptorium prevents two failure modes: correspondence that gets shipped without enough thought, and correspondence that consumes so much thought it crowds out real work.

**Scaffolded by:** `zettledeck-praxis`.

### Tesseract

Research space where external investigation happens. Items here are expected to either:

- Publish to the Reliquary for long-term storage
- Merge with other work (Foundry content, Nexus projects)
- Move back into the Chrysalis for further refinement before heading to the Foundry
- Be discarded as one-time reference

The Tesseract is for work with an *outside-in* direction — gathering, processing, synthesizing external material. The Nexus, by contrast, is *inside-in* — looking across what you already have.

**Scaffolded by:** `zettledeck-foundry`.

## How things graduate

Graduation — moving a file from one workspace to another — is always deliberate. A few heuristics:

- **Atelier → anywhere**: items in the Atelier can graduate to *any* other workspace.
  - → **Chrysalis** for a thought that needs to incubate and find its shape.
  - → **Praxis** for meeting notes or action items that belong in the diary or action list.
  - → **Foundry or Reliquary** for a quick note that attaches to a piece of work already in progress or already kept.
  - → **Tesseract** for a reference item or research lead that was captured on the fly.
  - → **Scriptorium** for a drafted reply or message fragment.
- **Chrysalis → Foundry/Tesseract/Nexus**: the idea has enough shape to work on, and you know what kind of work it needs.
- **Foundry → Reliquary**: the artifact is finished enough to keep. Publish with full structure.
- **Tesseract → anywhere**: the research has done its job. File the result into the Reliquary, merge it into Foundry or Nexus work, hand it back to the Chrysalis for further refinement, or discard it.
- **Anywhere → gone**: ideas that don't earn graduation don't need to be kept. The system is not a landfill.

The `/zettledeck promote` command handles the Reliquary hop specifically — it walks through inferring docType, assigning scope, building frontmatter, and moving the file with its full address applied. Earlier hops are usually just a move; dedicated routing tools for Atelier capture are on the roadmap.

## Why it's shaped this way

ZettleDeck works because it accepts three things the older patterns didn't solve.

1. **Ideas arrive rough.** A pure Zettelkasten assumes every note earns permanence. Real thinking is messier than that. The Atelier and Chrysalis give ideas room to be incomplete.

2. **Maintenance kills wikis.** A living knowledge base needs someone (or something) willing to do the bookkeeping. LLMs are willing. The Nexus implements the LLM Wiki pattern over your entire vault.

3. **Work is more than knowledge.** Praxis, Scriptorium, and the operational layer acknowledge that a knowledge-management system that ignores daily practice gets abandoned. The operational and the reflective support each other.

The result is a system where ideas can be captured without ceremony, incubated without pressure, researched or crafted when ready, connected without manual bookkeeping, and kept permanently with full structure — all while daily work continues underneath.

That's the way.

---

**Next reading:**

- [[vault-structure]] — how the Reliquary is organized internally (scopes, scopeIds, document types, placement)
- [[personal-assistant/README|The Personal Assistant]] — the assistant that knows the workspaces and helps you move ideas through them
- [[building-modules/README|Building Modules]] — for authors extending ZettleDeck with new workspaces or skills
