# Nexus Discover — Surface Emergent Ideas

Look across the accumulated knowledge base for implicit ideas, cross-domain connections, unarticulated patterns, and opportunities for synthesis. This mode doesn't answer a specific question (that's `query`). It proactively surfaces what the knowledge is pointing toward but hasn't been said yet.

**Mode:** `discover`

**Genesis:** Pages created by this mode are tagged `genesis: emergent`.

## Overview

The discover mode is the Nexus doing what the Nexus is for: looking inward at what's accumulated and revealing what's hidden in the patterns. It reads across pages — sources, entities, concepts, synthesis — and identifies:

- **Implicit ideas**: conclusions the evidence points toward but no single source states
- **Cross-domain connections**: entities or concepts from different sources/domains that share unexpected relationships
- **Evolving positions**: how understanding of a topic has shifted across sources over time
- **Convergence signals**: multiple independent sources pointing toward the same unstated conclusion
- **Tension points**: not outright contradictions (lint catches those), but areas where sources pull in different directions without directly conflicting
- **Coverage gaps**: important adjacent topics that the knowledge base doesn't address but probably should

## Workflow

### Phase 1: Survey

1. Read `index.md` to understand the full scope of the knowledge base.
2. Read a representative sample of pages across all types and genesis values.
3. Pay particular attention to:
   - Pages with many inbound links (hub concepts)
   - Pages with few or no inbound links (isolated knowledge)
   - Recently ingested sources (fresh material not yet fully integrated)
   - Concept pages with `## Evolution` sections (topics already showing movement)
   - Existing `emergent` pages (to avoid re-discovering what's already been surfaced)

### Phase 2: Analyze

Look for the patterns listed in the Overview. For each potential discovery:
- Identify the specific pages that support it
- Assess confidence: is this strongly implied by multiple pages, or a speculative connection?
- Check whether it's already been articulated somewhere in the knowledge base
- Check whether a previous `discover` run already surfaced it

### Phase 3: Present Discoveries

Present findings to the user:

```
🔮 Nexus Discover — {date}

Knowledge base: {N} pages across {N} sources

Discoveries ({N} found):

1. **{Discovery Title}**
   {2-3 sentence description of the implicit idea or connection}
   Based on: [[Page A]], [[Page B]], [[Page C]]
   Confidence: {high/medium/low}
   Type: {implicit idea / cross-domain connection / evolving position / convergence / tension / gap}

2. **{Discovery Title}**
   ...

Suggested next steps:
  • {Which discoveries are worth filing as emergent pages}
  • {Which gaps suggest new sources to ingest}
  • {Which tensions deserve deeper investigation}
```

### Phase 4: File (User-Directed)

For each discovery the user wants to keep, create an emergent page:

```markdown
---
type: emergent
genesis: emergent
created: {ISO date}
updated: {ISO date}
sources: [{list of pages this discovery draws from}]
confidence: {high/medium/low}
discovery-type: {implicit-idea/cross-domain/evolving-position/convergence/tension/gap}
tags: [{relevant tags}]
---

# {Discovery Title}

## Observation
{What was discovered — the implicit idea, connection, or pattern}

## Evidence
- [[Page A]] — {what this page contributes to the observation}
- [[Page B]] — {what this page contributes}
- [[Page C]] — {what this page contributes}

## Implications
- {What this means for the broader knowledge base}
- {Questions this raises}
- {Potential actions or investigations it suggests}

## Confidence
{Why this is rated high/medium/low. What additional evidence would strengthen or weaken it.}
```

Update `index.md` under the `## Emergent` section. Append to `log.md`.

### Phase 5: Log

Append to `log.md`:

```markdown
## [{ISO date}] discover | Knowledge base analysis

Surveyed {N} pages. Found {N} potential discoveries.
Filed: {N} ({list of discovery titles})
Deferred: {N}
Types: {count per discovery type}
```

## Discover Scope Options

- `nexus discover` — full knowledge base analysis (default)
- `nexus discover {topic}` — focused discovery around a specific topic or concept
- `nexus discover recent` — focus on recently ingested sources and their connections to existing knowledge

## Relationship to Other Modes

- **vs. query**: Query answers a specific question. Discover asks "what questions should we be asking?"
- **vs. lint**: Lint finds structural problems. Discover finds intellectual opportunities.
- **vs. ingest**: Ingest processes external sources. Discover processes the knowledge base itself.

Discover outputs often feed back into the system:
- Emergent ideas may move to the Chrysalis for incubation
- Identified gaps may trigger new research in the Tesseract
- Cross-domain connections may inform Foundry content
- Convergence signals may strengthen existing synthesis pages

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Knowledge base has fewer than 5 pages | Report: "Not enough content for meaningful discovery. Ingest more sources first." |
| No discoveries found | Report honestly: "No strong emergent patterns detected. The knowledge base may need more diverse sources." |
| Discovery duplicates an existing emergent page | Note it: "This was previously surfaced on {date}. Skip or update the existing page?" |
| User wants to file all discoveries | Process them in sequence, updating index after each |
