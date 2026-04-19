# zettledeck-core

The template repo and foundation for **ZettleDeck** — a personal knowledge and work-management framework that marries the [Zettelkasten](https://zettelkasten.de/introduction/) tradition with [Andrej Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), compatible with markdown tools (Obsidian) and agentic AI tools (Claude Code, Kiro).

## Why ZettleDeck

### The Zettelkasten problem — and why people abandon it

Niklas Luhmann's Zettelkasten wasn't a filing cabinet. It was a thinking partner — tens of thousands of atomic notes connected by explicit links, where the *reason for the link* was itself the knowledge being created. Structure emerged from use, not from predetermined categories. Ideas recombined in ways their author hadn't anticipated. Luhmann credited the system as a genuine collaborator in his prolific output.

The principles are as true today as they were in 1952:

- **Atomicity** — one idea per note, so ideas can recombine like molecules.
- **Connection, not collection** — the value lives in the links, and the *explicit why* of each link is knowledge being created.
- **Emergent structure** — organization grows organically from the material, not imposed top-down.
- **Thinking partner, not storage** — the system surfaces patterns and tensions you didn't yet see.

But a working Zettelkasten is *brutal* to maintain. Updating cross-references, keeping summaries current, flagging contradictions when new material lands, pruning stale claims, noticing what's missing — the bookkeeping grows faster than the value. That's why most personal wikis die. Humans get bored of maintenance; the maintenance is what makes the wiki worth having.

### What changed: the LLM does the bookkeeping

Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) points out what's newly possible: **LLMs don't get bored.** An LLM can ingest a new source, touch fifteen pages to update summaries and cross-references, flag contradictions with what it read last month, and file the result — in one pass, on every source. The wiki stays alive because the manual cost of maintenance drops to near zero. You curate sources, ask good questions, and think about what it all means. The LLM handles everything else: summarizing, cross-referencing, filing, linting, noticing what's missing.

Three layers: **raw sources** (immutable), **the wiki** (LLM-written, interlinked), **the schema** (how *this* wiki works). Three core operations: **ingest**, **query**, **lint**. You read the wiki; the LLM writes it. The LLM is the programmer; the wiki is the codebase; any markdown viewer (Obsidian, VS Code, your editor of choice) is the IDE.

### ZettleDeck = Zettelkasten spirit + LLM Wiki mechanics + work-management scaffolding

ZettleDeck takes the Zettelkasten philosophy (atomicity, explicit connections, emergent structure, thinking partner) and the LLM Wiki implementation (the LLM owns maintenance) and wraps them in a practical work-management framework that acknowledges: ideas don't arrive ready to file. They need to be captured messily, incubated, researched, shaped, and *then* graduated into permanent structure.

So ZettleDeck gives ideas room to mature before they earn their place in the Zettelkasten.

#### Ideas move through workspaces, at their own pace

Every piece of work lives in one of eight **workspaces** — each a top-level folder with a specific purpose. Nothing has to be filed correctly on arrival:

- **Atelier** — raw capture. A passing thought, a half-formed question. No format, no expectations.
- **Chrysalis** — incubation. When something shows enough life to revisit, it moves here. Fragments connect, patience does the work, dead ends get discarded.
- **Tesseract** — research. External investigation, gathered and processed.
- **Foundry** — content crafting. Ideas with shape get refined into finished artifacts.
- **Nexus** — the thinking partner. Looks inward across everything you've accumulated to surface patterns, contradictions, and implicit ideas — the Karpathy pattern, extended. This is the Zettelkasten's emergent intelligence made operational.
- **Scriptorium** — correspondence. Emails and messages that need thought but not the full Foundry treatment.
- **Praxis** — daily practice. Diary, tasks, ruthless priorities — the operational backbone.
- **Reliquary** — the permanent collection, and the Zettelkasten proper. Anything worth keeping graduates here with full structure — scope, addressing, frontmatter, explicit links.

```
Atelier → Chrysalis → ┬── Foundry ───→ Reliquary
                ↑     ├── Tesseract → Reliquary / Foundry / Nexus / Chrysalis
                │     └── Nexus ─────→ Chrysalis / Foundry
                │                        ↑
                └────────── research loop back for further refinement
Praxis ─────────────────────── runs underneath everything
  └── Scriptorium
```

*See [The Way](ZDocs/guides/theWay.md) for the full flow narrative and how ideas graduate between workspaces.*

#### Inside the Reliquary: the Zettelkasten itself

Vault-structured documents carry their relationships in metadata, echoing Luhmann's branching index but letting folder placement stay flexible:

- Every document has a **scopeId** — a 4-digit identifier binding it to a knowledge domain. All documents sharing a scopeId belong to the same scope, regardless of folder. Reorganize freely; the connections hold.
- Every document has a **docType** (scope, focus, project, objective, content, note) with rules for placement, subTypes, and valid parents — so atomicity is preserved at the right granularity for each kind of thought.
- **Wikilinks carry the explicit "why"** — in the Zettelkasten tradition, a link without a reason is a missed thought.
- **Folders are a hint, not a source of truth.** Metadata and links are canonical.

*See [Vault Structure](ZDocs/guides/vault-structure.md) for the complete model — document types, zettldex addressing, frontmatter, placement rules.*

#### The Nexus: where it all becomes a thinking partner

The Nexus skill implements Karpathy's ingest / query / lint pattern over your entire vault, plus a fourth operation — **discover** — that proactively surfaces implicit ideas, cross-domain connections, evolving positions, and tension points. This is what turns an accumulation of notes into something that thinks with you. It's the Luhmann promise, finally practical.

#### You get an assistant that knows all of this

ZettleDeck ships with a four-layer personal assistant (profile, accommodations, personality, PA framework) that loads into every session. It knows the workspaces, the vault structure, your identity and preferences, and runs GTD / RITMO-style daily and weekly review. It recommends before it acts — you stay in the driver's seat. You curate; it maintains.

*See [The Personal Assistant](ZDocs/guides/personal-assistant/README.md) for the four-layer architecture and how to customize it into something genuinely personal.*

## What This Repo Provides

`zettledeck-core` is the template you clone to start a new ZettleDeck project. It provides the foundation; add-on modules (praxis, nexus, foundry, etc.) layer on the workspace scaffolding, skills, and agents for each stage of the flow.

- **A project template** — clone it to start a new ZettleDeck vault
- **A module composer** — `zd`, a CLI that installs add-on modules and wires them into Claude Code or Kiro
- **An init system** — `/zettledeck.init`, an interactive skill that walks you through configuration
- **Core skills** — `zettledeck` (methodology + promote), `zettledeck.init` (setup), `markdown` (conventions), `vault` (file analysis)
- **The four-layer assistant** — identity, accommodations, persona, and PA framework, loaded every session

## Quick Start

```bash
# 1. Clone the template
git clone https://github.com/strye/zettledeck-core.git my-vault
cd my-vault

# 1b. OPTIONAL Remove the `.git` folder and revision history
# rm -rf .git

# 2. Install CLI dependencies (jq and yq) — run once, auto-detects your platform
.zettledeck/scripts/bootstrap

# 3. Create the tool directory for your AI tool (one or both)
mkdir .claude    # for Claude Code
mkdir .kiro      # for Kiro

# 4. Declare any add-on modules in .zettledeck/zettledeck.yml
#    (optional — you can start with just core)

# 5. Wire the tool(s) and install declared modules
.zettledeck/scripts/zd setup

# 6. Run core init (in Claude Code or Kiro) — configures vault identity,
#    folder structure, document types, scope ID method
/zettledeck.init core

# 7. Run module init (in Claude Code or Kiro) — discovers and configures
#    any modules installed in step 5
/zettledeck.init
```

## Documentation

Full documentation lives in [`ZDocs/`](ZDocs/README.md) and is split between evergreen guides and per-module reference.

**Guides — methodology and process:**

- [The Way](ZDocs/guides/theWay.md) — philosophy, workspace flow, and the system-vs-vault distinction
- [Vault Structure](ZDocs/guides/vault-structure.md) — scopes, scopeIds, document types, frontmatter, placement rules
- [The Personal Assistant](ZDocs/guides/personal-assistant/README.md) — the four-layer architecture and how to customize it
- [Building Modules](ZDocs/guides/building-modules/README.md) — for authors extending ZettleDeck

**Core reference — what core ships:**

- [Overview & Project Structure](ZDocs/modules/core/README.md)
- [The `zd` Script](ZDocs/modules/core/zd-script.md) — commands, module contribution, requirements
- [Core Skills](ZDocs/modules/core/skills.md) — `zettledeck`, `zettledeck.init`, `markdown`, `vault`
- [Configuration](ZDocs/modules/core/configuration.md) — `.zettledeck/core/config.json` key by key

## Available Modules


| Module                  | Purpose                                                                 | Status      |
| ------------------------- | ------------------------------------------------------------------------- | ------------- |
| **zettledeck-core**     | Foundation — template, composer, core skills                           | (this repo) |
| **zettledeck-praxis**   | Daily practice — diary, email, tasks, comms, weekly reshape            | Available   |
| **zettledeck-nexus**    | Vault intelligence — graph analysis, ideas, reflection, contradictions | Available   |
| **zettledeck-foundry**  | Content creation — deep research, writing, content versioning          | Available   |
| **zettledeck-obsidian** | Optional bridge to an external Obsidian vault via the obsidian-cli      | Available   |
| **rostrum-blackboard**  | Human-conducted blackboard pattern                                      | Available   |

Declare them in `.zettledeck/zettledeck.yml` to install. See [Building Modules](ZDocs/guides/building-modules/README.md) if you want to create your own.

## Tool Compatibility

ZettleDeck is a collection of markdown files plus agent instructions. It deals in plain markdown — any viewer or editor can open the vault.

**Agentic tools** (the assistant side — required for ingest, query, lint, discover): **Claude Code** and **Kiro IDE** are supported. Run `zd setup` to wire whichever tools you have. Full wiring details in [The `zd` Script](ZDocs/modules/core/zd-script.md).

**Markdown viewers** (the human side — optional, pick what suits you): ZettleDeck neither requires nor assumes Obsidian. Use Obsidian, VS Code, iA Writer, a terminal pager — whatever lets you read markdown. The `zettledeck-obsidian` module is an optional add-on for users who want skills that drive an external Obsidian vault via `obsidian-cli`; core does not depend on it. **Better together, complete apart.**

## License

MIT
