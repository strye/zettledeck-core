# Nexus Map — Vault Topology

Analyze the intellectual structure of the vault. Reveal where ideas concentrate, where gaps exist, and how clusters connect. This is about the *shape* of the thinking, not the content of individual notes.

**Mode:** `map`

**Scope:** Vault-wide. Reads across the entire Obsidian vault.

**Genesis:** Pages created by this mode are tagged `genesis: synthesis`.

## Overview

Map provides a comprehensive view of the vault's topology. It answers:

- Where do ideas concentrate?
- What are the major thinking clusters?
- Which areas are well-connected vs. isolated?
- What connections should exist but don't?
- Where are the dead zones relative to stated priorities?

Map is the structural counterpart to `lint` (health) and `discover` (content). Map shows the shape. Discover tells you what the shape means. Lint fixes what's broken.

**Invocation:**

```
nexus map
```

## Workflow

### Phase 1: Structural Inventory

Scan the vault's connectivity landscape without deeply reading content. The goal is counts, distributions, and structural facts.

**What to measure:**

- **Total notes** — count of all markdown files in the vault
- **Tag distribution** — count of notes per tag, most-used tags, long-tail tags
- **Notes per scope/folder** — density across the vault's top-level organization
- **Wikilink counts** — incoming and outgoing per note
- **Orphans** — notes with no incoming or outgoing wikilinks
- **Dead ends** — notes with outgoing links but no incoming links
- **Unresolved links** — wikilinks pointing to notes that don't exist
- **Hub candidates** — notes with 10+ incoming wikilinks

**Method:** Walk the vault directory tree. For each markdown file, read the content and frontmatter. Extract wikilinks (`[[...]]`), tags (both frontmatter and inline), and folder location. Build a link graph using the `vault` skill — `vault link-graph {vault-root}` — (returns TSV: `source`, `target`, `weight`). From this graph, record who links to it and who it links to. From this data, derive orphans, dead ends, hubs, and unresolved links.

**Output for Phase 1:**

Use the `vault` skill — `vault stats {vault-root}` — to gather structural statistics (returns TSV: `metric`, `value`).

```
Structural Statistics:
- Total notes: {count}
- Orphaned notes: {count} ({percentage}%)
- Dead ends: {count}
- Unresolved links: {count} unique references
- Top 10 tags: {list with counts}
- Notes by scope: {breakdown}
- Average links per note: {calculated}
- Hub notes (10+ inbound): {count}
```

### Phase 2: Identify Major Thinking Clusters

Trace backlink chains from highly-connected hub notes to map intellectual neighborhoods.

**Find hub notes:**
- Notes with 10+ backlinks are gravitational centers
- Often MOCs (Maps of Content) or core concepts
- These are the anchors of clusters

**For each hub:**
1. Read the hub note
2. Trace backlinks 2-3 hops deep
3. Identify the conceptual theme of the neighborhood
4. Note cluster size (number of connected notes)
5. Describe cluster characteristics

**Cluster relationship analysis:**

- **Which clusters should connect but don't?** Thematically related but no links. Could inform each other. Missed cross-pollination.
- **Which are bridged by critical junction notes?** Notes that sit at intersections of two clusters. These are conceptual bridges — often the most valuable notes in the vault.
- **Where do larger meta-themes emerge?** Patterns across multiple clusters. Overarching frameworks. Implicit organizing principles.

**Output for Phase 2:**

```
Major Clusters Identified: {count}

Cluster 1: {Theme Name}
- Hub note: [[Note Name]]
- Size: {X} notes
- Characteristics: {description}
- Key topics: {list}

Cluster 2: {Theme Name}
{same structure}

Cluster Relationships:
- Should connect: {Cluster A} ↔ {Cluster B} because {reason}
- Critical junctions: [[Note X]] bridges {Cluster A} and {Cluster C}
- Meta-themes: {pattern visible across clusters}
```

### Phase 3: Find Gaps

Identify missing connections, orphaned value, and dead zones.

**Gap types:**

**1. Missing connections between thematically-related notes**
Notes about similar topics that aren't linked. Search for theme keywords across the vault and find notes that should reference each other but don't.

**2. Orphaned value**
Relevant but unlinked insights. High-quality notes that are isolated. Good content with poor connectivity — the most recoverable kind of gap.

**3. Unresolved references**
Which unresolved wikilinks are cited most? What do notes keep trying to link to that doesn't exist? These are ideas wanting to be created — the vault telling you where the next note should go.

**4. Dead zones**
Areas with low note density relative to stated priorities. Read the user's ruthless priorities file and compare against actual note distribution. Where should there be more content?

**5. Tag-to-priority alignment**
Do the most-used tags align with stated priorities? Mismatch indicates drift — either the priorities have evolved or the tagging hasn't kept up.

**Method:** Read `{rp-path}/ruthless-priorities.md` (or equivalent configured path) to get the user's stated priorities. Compare to the note distribution and tag distribution gathered in Phase 1. Identify specific mismatches.

**Output for Phase 3:**

```
Gaps Identified:

Missing Connections: {count}
- [[Note A]] and [[Note B]] both discuss {topic} but aren't linked
- {more examples}

Orphaned Value: {count}
- [[High-quality orphan note]] — {why it's valuable but isolated}

Unresolved References (Top 5):
1. [[Missing Note Name]] — cited {X} times in {locations}
2. {continue...}

Dead Zones:
- Ruthless Priority: {RP Name}
  - Expected density: High
  - Actual note count: {low number}
  - Gap: {explanation}

Tag-to-Priority Misalignment:
- Priority: {RP Name}
- Expected top tags: {what should relate}
- Actual top tags: {what is used}
- Mismatch: {explanation}
```

### Phase 4: Synthesize the Shape Narrative

Create a comprehensive vault overview with actionable recommendations. This phase is what makes map worth running — a list of statistics isn't useful until it's reframed as a narrative description of the vault's intellectual topology.

**Synthesis components:**

- **Hub identification** — top 10 most-connected notes, what makes each a hub, which are healthy vs. overloaded
- **Cluster mapping** — textual description of the cluster landscape, how clusters relate, strength of inter-cluster connections
- **Narrative description of attention patterns** — where is attention concentrated? What gets linked vs. what stays isolated? How does structure reflect stated vs. revealed priorities?
- **Strongest cross-domain connections** — which scopes/domains are well-bridged? Which cross-pollinate effectively? Where are unexpected connections?

**Actionable recommendations:**

- **Create notes** — top 3-5 unresolved references worth creating, why each matters
- **Make connections** — top 5-10 wikilinks to add, between which notes, why the connection matters
- **Develop areas** — which clusters need expansion? Which dead zones to address? Prioritized by alignment with ruthless priorities
- **Rescue orphaned value** — which orphans to rescue first, how to integrate them, what hubs to connect them to

### Phase 5: Present Findings

```
🔮 Nexus Map — Vault Topology

Scale:
- Total notes: {X}
- Total links: {Y}
- Average links per note: {Z}
- Link density: {Sparse | Moderate | Dense}

Connectivity:
- Orphaned notes: {X} ({percentage}%)
- Dead ends: {X}
- Well-connected notes (5+ links): {X}
- Hub notes (10+ links): {X}

Major Clusters:
{For each cluster: hub, size, theme, characteristics}

Cluster Relationships:
- Missing bridges: {list}
- Critical junctions: {list}
- Meta-themes: {description}

Shape Narrative:
{2-3 paragraphs describing the vault's intellectual topology}

This vault shows {concentration pattern}. The strongest clusters form around
{themes}, with {X} acting as gravitational centers.

Attention patterns reveal {insight about focus}. Cross-domain connections are
{strong/weak/uneven}, with {observation about inter-cluster bridges}.

The gap between stated priorities and actual note distribution suggests
{insight about drift or evolution}.

Tag Analysis:
- Top 10 tags: {list with counts}
- Tag patterns: {observation about tagging behavior}
- Alignment or misalignment with priorities: {description}

Gaps & Opportunities:
- Missing connections: {count} — {top examples}
- Orphaned value: {count} — {top examples}
- Unresolved references: {count} — {top 5}
- Dead zones: {list priority areas with low density}

Recommendations:

Priority 1 — Create These Notes:
1. [[Note Name]] — {why} — Serves {RP/cluster}
2. {continue for top 3-5}

Priority 2 — Make These Connections:
1. Link [[Note A]] to [[Note B]] — {why}
2. {continue for top 5-10}

Priority 3 — Develop These Areas:
1. {Cluster/scope} — {current state} → {target state}
2. {continue for top 3}

Priority 4 — Rescue This Orphaned Value:
1. [[Orphan]] — Connect to [[Hub]] because {reason}
2. {continue for top 3-5}
```

### Phase 6: File (User-Directed)

Ask the user: "Want me to file this topology analysis as a synthesis page in the Nexus?"

If yes, create a page in `Nexus/pages/synthesis/` with this frontmatter:

```yaml
---
type: synthesis
genesis: synthesis
synthesis-type: topology
created: {ISO date}
updated: {ISO date}
vault-snapshot:
  total-notes: {N}
  orphans: {N}
  hubs: {N}
  clusters: {N}
tags: [topology, vault-health]
---

# Vault Topology — {ISO date}

{Full map report from Phase 5}
```

Update `Nexus/index.md` under `## Synthesis`. A topology snapshot is time-bound — note the date clearly so future maps can compare.

### Phase 7: Log

Append to `Nexus/log.md`:

```markdown
## [{ISO date}] map | Vault topology

Scale: {N} notes, {N} links, {N} orphans, {N} hubs, {N} clusters.
Top gap: {most significant gap}
Top recommendation: {most actionable item}
Filed: {yes/no}
```

## Constraints

- Be specific — name actual notes, not generic categories
- Be revealing — change how the user understands their vault
- Be actionable — focus on implementable insights
- Emphasize "connections that should exist but don't"
- Recommendations should align with ruthless priorities when possible
- Cap recommendations at top 10 per category
- The Shape Narrative is not optional. Statistics without narrative is just a report; narrative is what makes map useful.

## Path Configuration

Vault root is passed at invocation time. Reads `{rp-path}/ruthless-priorities.md` for priority alignment analysis (path resolves from shared praxis config at runtime).

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Vault has fewer than 20 notes | Report: "Vault is too small for meaningful topology analysis. Run again after more content accumulates." |
| No hub notes found (nothing with 10+ inbound links) | Report: "No hub notes detected — the vault is flat. Either it's young, or it's not using wikilinks to organize thinking. Consider whether MOCs or index pages would help." |
| Ruthless priorities file doesn't exist | Skip Phase 3's priority-alignment checks, note it in the output, continue with the rest. |
| User wants to act on Priority 2 (Make Connections) recommendations | Treat each as a metadata-only edit. Present per-file, wait for approval, then apply. Permitted under the metadata-enhancement rule. |

## Relationship to Other Modes

- **vs. lint**: Lint reports mechanical issues (orphans, broken links, index drift) and can auto-fix some of them. Map reports the same structural facts but reframes them as intellectual topology — where the thinking lives. Some overlap is expected. Lint says "these are broken"; map says "this is the shape they make." When in doubt about whether a given structural issue belongs to lint or map, ask the user.
- **vs. link**: Map identifies missing connections and dead zones as a broad survey. Link takes that kind of analysis and scores each candidate connection across conceptual strength, structural impact, and priority alignment. Map is diagnostic; link is prescriptive.
- **vs. discover**: Discover looks for content patterns (implicit ideas, cross-domain connections). Map looks for structural patterns (clusters, gaps, density). Discover tells you what the shape means; map tells you what the shape is.
