---
name: nexus
description: "Build and maintain a persistent, compounding LLM-managed knowledge base from raw sources, and analyze the wider vault for patterns, connections, and structural health. Ingest sources, query the knowledge base, lint for health, discover emergent ideas, connect domains, trace idea evolution, map vault topology, and recommend strategic links. Use when the user says 'nexus ingest', 'nexus query', 'nexus lint', 'nexus discover', 'nexus connect', 'nexus trace', 'nexus map', 'nexus link', 'nexus init', or 'nexus help'."
author: Will Strye
---

# Nexus — Knowledge Intelligence

```
Influenced by Andrej Karpathy's LLM Wiki pattern. Extended by Will Strye for the ZettelDeck.
Andrej Karpathy's original gist: "https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f"
```

## Overview

The Nexus is the knowledge intelligence layer of the ZettleDeck system. It builds and maintains a persistent, compounding knowledge base from raw sources. Instead of re-deriving knowledge on every question (RAG-style), the LLM incrementally integrates sources into a web of interlinked pages — summaries, entities, concepts, and synthesis. Knowledge compounds over time. Cross-references are built once and kept current. Contradictions are flagged as they appear.

Beyond ingestion and retrieval, the Nexus looks inward at what's accumulated and surfaces what's hidden in the patterns: implicit ideas, evolving beliefs, cross-domain connections, and opportunities for synthesis. It reveals what's already there but hasn't been articulated yet.

**Three layers:**
1. **Raw sources** (immutable, human-curated): articles, papers, notes, transcripts, data files
2. **The knowledge base** (LLM-owned, continuously updated): summaries, entity pages, concept pages, synthesis, emergent discoveries
3. **The schema** (`NEXUS.md`): tells the LLM how the knowledge base is structured, what conventions to follow

**The human's job:** curate sources, direct analysis, ask good questions, think about meaning.
**The LLM's job:** summarizing, cross-referencing, filing, bookkeeping, maintenance, and surfacing what's implicit.

## How to Use

**Invocation patterns:**
- `nexus ingest {source}` — process a source into the knowledge base
- `nexus query {question}` — ask a question against the knowledge base
- `nexus lint` — health-check the knowledge base
- `nexus discover` — surface emergent ideas from accumulated knowledge
- `nexus connect {domain A} {domain B}` — find hidden bridges between two domains
- `nexus trace {idea}` — track how an idea evolved over time
- `nexus map` — analyze the shape and structure of the vault
- `nexus link` — score and recommend strategic connections
- `nexus init` — interactive setup/customization walkthrough
- `nexus help` or `nexus ?` — show quick reference

## Scope

Nexus operates on two scopes:

- **Knowledge base scope** (`ingest`, `query`, `lint`, `discover`): reads and writes pages inside the Nexus root (default `Nexus/`). These modes manage the LLM-owned knowledge base.
- **Vault-wide scope** (`connect`, `trace`, `map`, `link`): reads across the entire Obsidian vault. These modes analyze accumulated vault content for patterns, connections, and structural health.

Vault-wide modes may recommend metadata changes (wikilinks, frontmatter, cross-references) to files outside the Nexus root. Content changes outside the Nexus root are never made. See "What the LLM Never Does" below.

## Modes

| Mode | Scope | Description | Invocation |
|------|-------|-------------|------------|
| `ingest` | Nexus | Process a source: summarize, cross-reference, update index/log | `nexus ingest {source}` |
| `query` | Nexus | Search, synthesize answer, optionally file as new page | `nexus query {question}` |
| `lint` | Nexus | Health-check: resolve-class contradictions, orphans, stale claims, missing links | `nexus lint` |
| `discover` | Nexus | Surface emergent ideas from accumulated knowledge | `nexus discover` |
| `connect` | Vault | Find hidden bridges between two named domains | `nexus connect {A} {B}` |
| `trace` | Vault | Track how an idea evolved over time | `nexus trace {idea}` |
| `map` | Vault | Analyze the shape and structure of the vault | `nexus map` |
| `link` | Vault | Score and recommend strategic connections | `nexus link` |
| `init` | Nexus | Interactive setup: customize structure, page types, conventions | `nexus init` |
| `help` | — | Display quick reference | `nexus help` or `nexus ?` |

When invoked without a mode, display this table and ask which mode the user wants.

## Help

If the user's input is `help` or `?` (case-insensitive), respond with:

```
🔮 Nexus — Quick Reference

Knowledge intelligence layer. Builds and maintains a persistent,
compounding knowledge base from raw sources. Analyzes the wider vault
for patterns, connections, and structural health. Surfaces what's
hidden in the patterns.

Usage:
  Knowledge base:
  • nexus ingest {source}       → process a source into the knowledge base
  • nexus query {question}      → ask a question against the knowledge base
  • nexus lint                  → health-check the knowledge base
  • nexus discover              → surface emergent ideas from accumulated knowledge

  Vault analysis:
  • nexus connect {A} {B}       → find hidden bridges between two domains
  • nexus trace {idea}          → track how an idea evolved over time
  • nexus map                   → analyze the shape of the vault
  • nexus link                  → score and recommend strategic connections

  Setup:
  • nexus init                  → interactive setup walkthrough
  • nexus help                  → this message

Modes:
  ingest   — Read a source, extract key info, write/update pages,
             update index and log. A single source may touch 10-15 pages.
  query    — Search the index, read relevant pages, synthesize an
             answer with citations. Good answers get filed back as pages.
  lint     — Check for contradictions (resolve-class), stale claims,
             orphan pages, missing cross-references, coverage gaps.
  discover — Look across accumulated knowledge for implicit ideas,
             cross-domain connections, and unarticulated patterns.
  connect  — Find non-obvious bridges between two named domains using
             vault graph structure and thematic overlap.
  trace    — Track how an idea evolved over time through vocabulary
             shifts, temporal patterns, and confidence evolution.
  map      — Analyze vault topology: clusters, hubs, orphans, gaps,
             and attention alignment with priorities.
  link     — Identify missing connections and recommend strategic
             links scored by conceptual, structural, and priority fit.
  init     — Walk through customization: directory structure, page
             types, naming conventions, domain-specific schema.

Structure (defaults, customizable via init):
  Nexus/
  ├── NEXUS.md        — schema (conventions, page types, workflows)
  ├── index.md        — content catalog (updated on every ingest)
  ├── log.md          — chronological activity record
  ├── raw/            — immutable source documents
  └── pages/          — LLM-generated pages (all types, organized by subdirectory)

Genesis (front-matter: genesis):
  source   — direct extraction from a raw source (ingest)
  derived  — entity/concept page created during ingestion
  synthesis — filed answer to a user query
  emergent — surfaced by discover mode (pattern analysis)
  manual   — created or edited directly by the user

Notes:
  • Works without running 'nexus init' — sensible defaults apply
  • The LLM never modifies files in raw/ — that's your source of truth
  • Pages use wikilinks for cross-references
  • index.md is the primary navigation tool for the LLM
```

Then stop. Do not proceed to any mode logic.

## Schema Detection

Before executing any mode (except `help`), locate the knowledge base schema:

1. Look for `NEXUS.md` in the Nexus workspace directory (default: `Nexus/`).
2. If found, read it. It defines the knowledge base's structure, conventions, and page types.
3. If not found, use the defaults defined below. The knowledge base is still fully functional without a custom schema.

### Defaults (No NEXUS.md Present)

When no `NEXUS.md` exists, use these conventions:

| Setting | Default |
|---------|---------|
| Nexus root | `Nexus/` |
| Raw sources | `Nexus/raw/` |
| Pages | `Nexus/pages/` |
| Source summaries | `Nexus/pages/sources/` |
| Entity pages | `Nexus/pages/entities/` |
| Concept pages | `Nexus/pages/concepts/` |
| Synthesis pages | `Nexus/pages/synthesis/` |
| Index file | `Nexus/index.md` |
| Log file | `Nexus/log.md` |
| Page format | Markdown with YAML frontmatter |
| Cross-references | Wikilinks `[[Page Name]]` |

These defaults work for any domain. The `init` mode lets users customize them.

## Routing

On invocation, identify the requested mode and load the corresponding mode file:

| Mode | Resource |
|------|----------|
| `ingest` | `modes/ingest.md` |
| `query` | `modes/query.md` |
| `lint` | `modes/lint.md` |
| `discover` | `modes/discover.md` |
| `connect` | `modes/connect.md` |
| `trace` | `modes/trace.md` |
| `map` | `modes/map.md` |
| `link` | `modes/link.md` |
| `init` | `modes/init.md` |

Routing steps:

1. Parse the mode from the user's request.
2. If the mode is `help` or `?`, display the help text above and stop.
3. If the mode is not in the routing table, tell the user the mode wasn't found and show the help text.
4. If matched, run Schema Detection (above), then read the mode file and execute its workflow. Pass through any arguments the user provided (source paths, questions, idea names, domain pairs, etc.).

## Genesis — Frontmatter Property

All Nexus-generated pages include a `genesis` property in their YAML frontmatter. This tracks what internal process created the page, distinct from `source` (which tracks external origin like a URL).

| `genesis` value | Set by | Meaning |
|---|---|---|
| `source` | `ingest` | Direct extraction/summary from a raw source document |
| `derived` | `ingest` | Entity/concept page created or updated during ingestion |
| `synthesis` | `query` | Filed answer to a user query |
| `emergent` | `discover` | Surfaced by pattern analysis across existing pages |
| `manual` | user | Created or edited directly by the user |

**Distinction from `source` property:**
- `source:` = where the original content came from externally (URL, file path)
- `genesis:` = what process inside the Nexus produced this page

A clipped web article has `source: https://...` and no `genesis` (it's a raw source). The Nexus summary page created from that article has `genesis: source` and its `sources:` list references the clipped article.

## Index and Log Conventions

Two special files support navigation and history. Both are created automatically on first ingest if they don't exist.

### index.md

Content-oriented catalog of everything in the knowledge base:

```markdown
---
type: index
updated: {ISO timestamp}
page-count: {N}
source-count: {N}
---

# Nexus Index

## Sources
- [[Source Title]] — one-line summary (ingested: {date})

## Entities
- [[Entity Name]] — one-line description

## Concepts
- [[Concept Name]] — one-line description

## Synthesis
- [[Synthesis Title]] — one-line description

## Emergent
- [[Discovery Title]] — one-line description
```

The LLM reads the index first when answering queries to find relevant pages, then drills into them. Updated on every ingest and discover.

### log.md

Chronological, append-only activity record:

```markdown
## [{ISO date}] {operation} | {title}

{Brief description of what happened. Pages created/updated. Source count.}
```

Operations: `ingest`, `query`, `lint`, `discover`, `init`.

## Cross-Reference Conventions

- Use wikilinks `[[Page Name]]` for all internal references.
- Every page should link to at least one other page.
- Source summary pages link to the entities and concepts they mention.
- Entity and concept pages link back to the sources that reference them.
- The LLM maintains bidirectional links: if A links to B, B should link back to A.
- Emergent pages link to the pages whose patterns they were derived from.

## Standard Frontmatter

All Nexus-generated pages include:

```yaml
---
type: source | entity | concept | synthesis | query-result | emergent
genesis: source | derived | synthesis | emergent | manual
created: {ISO date}
updated: {ISO date}
sources: [list of source page names that inform this page]
tags: [domain-relevant tags]
---
```

## Scripts

Bash scripts in `skills/nexus/scripts/` handle multi-step file operations and return structured data (TSV) to the agent. Use them instead of doing these operations inline — they are faster, consistent, and reduce round-trips.

| Script | Used by | Purpose |
|--------|---------|---------|
| `belief-extractor` | `lint` (Phase 2c), `insight contradictions` | Extract assertive belief statements from vault markdown files |
| `trace-timeline` | `trace` (Phase 3), `scan` (Phase 3) | Build a chronological mention timeline for a term with gap detection |
| `nexus-index-sync` | `lint`, `ingest`, `query`, `discover` | Diff index.md against actual pages on disk; optionally patch |

**Calling convention:** Scripts are invoked via bash. Output is TSV with a header row. Errors go to stderr. Pass `--help` (not implemented — see script header) or read the script header for full usage.

```bash
# Examples
belief-extractor {vault-path} [--scope {folder}]
trace-timeline {vault-path} "{term}" ["synonym1" "synonym2"] [--gap 60] [--scope {folder}]
nexus-index-sync {nexus-root} [--patch]
```

Scripts are installed to `.zettledeck/scripts/` when the module is installed via `zd install`. At runtime, invoke them by name if they are on PATH, or by their full installed path.

## Shared Scripts (vault skill)

The `vault` skill in zettledeck-core provides three shared operations used across multiple nexus and insight modes. Always invoke these through the `vault` skill — never reference script paths directly.

| Operation | Invocation | Used by | Output TSV columns |
|-----------|-----------|---------|-------------------|
| `vault link-graph` | `vault link-graph {vault-root}` | `lint` (Phase 1), `map` (Phase 1), `connect` (Phase 1), `link` (Phase 1), `trace` (Phase 3) | `source`, `target`, `weight` |
| `vault temporal-inventory` | `vault temporal-inventory {vault-root}` | `insight temporal`, `insight scan` (Phase 3), `insight align` (Step 2), `nexus trace` (Phase 3) | `date`, `file`, `doctype`, `status`, `word_count` |
| `vault stats` | `vault stats {vault-root}` | `map` (Phase 1), `insight orient`, `insight scan` (Phase 2) | `metric`, `value` |

See the `vault` skill for full option documentation.

## What the LLM Never Does

- Never modifies files in `raw/`. That directory is immutable source of truth.
- Never deletes pages without explicit user approval.
- Never fabricates citations. If a claim can't be traced to a source, say so.
- Never modifies **content** in files outside the Nexus root. Content is reasoning, prose, claims, conclusions — the substance of a note.
- Metadata enhancements to files outside the Nexus root are permitted with explicit user approval per operation. Metadata means: adding wikilinks in context, fixing YAML frontmatter, adding cross-references, creating empty stub pages. These are vault-health operations, not content changes.
- Never resolves reasoning contradictions in source material. If a source contains a logical conflict or unresolved tension, flag it — do not rewrite it. Contradictions inside the Nexus root (between Nexus-generated pages) may be fixed; contradictions in source material are user territory.
