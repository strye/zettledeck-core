# Nexus Connect — Bridge Two Domains

Discover non-obvious relationships between two domains using vault graph structure and thematic overlap. Surface hidden bridges, classify them by depth, and recommend where cross-pollination would matter.

**Mode:** `connect`

**Scope:** Vault-wide. Reads across the entire Obsidian vault.

**Genesis:** Pages created by this mode are tagged `genesis: emergent`.

## Overview

Connect is the targeted sibling of `discover`. Where discover looks broadly for whatever patterns surface, connect is given two specific domains and asked: how do these relate? It's most powerful for cross-pollination between different life or work domains, finding unexpected common ground, identifying transferable insights, and understanding whether two domains are converging or diverging over time.

**Invocation:**

```
nexus connect {domain A} {domain B}
```

**Domain types accepted:**
- Formal scopes (e.g., `S03_Cloud_Architecture`)
- Informal topics or themes (e.g., "productivity", "writing")
- Project names
- Any conceptual area present in the vault

## Workflow

### Phase 1: Map Each Domain

Build a picture of each domain's neighborhood — the notes, backlinks, tags, and themes within 2-3 hops of each domain's center.

**Hop depth rules:**
- **Balanced domains** (similar size): 2-3 hops each
- **Sparse domain** (much smaller than partner): 3-4 hops. A sparse domain's connections are more valuable per link.
- **Dense domain** (much larger than partner): 1-2 hops

**For each domain, gather:**
- Core notes (direct matches or notes in the scope folder)
- Linked notes (outgoing and incoming wikilinks)
- Common tags or frontmatter properties
- People, projects, or themes mentioned
- Temporal patterns — when was this domain actively being worked on?

**Method:** Search the vault's markdown files for the domain keyword and related terms. For formal scopes, walk the scope directory and read the index or MOC if present. For informal topics, search text content across the full vault. For each matching note, use the `vault` skill — `vault link-graph {vault-root}` — to extract wikilinks (returns TSV: `source`, `target`, `weight`). For each domain, pull its wikilinks (both directions) and follow them to the configured hop depth.

**Output for Phase 1:**

```
Domain A Neighborhood:
- Core notes: {count} ({list key ones})
- Extended network (2-3 hops): {count}
- Key tags: {list}
- Active periods: {when was this worked on?}

Domain B Neighborhood:
- Core notes: {count} ({list key ones})
- Extended network (2-3 hops): {count}
- Key tags: {list}
- Active periods: {when was this worked on?}
```

### Phase 2: Find Overlaps

Identify the intersection between the two neighborhoods. Overlaps take several forms:

1. **Direct links** — notes that explicitly reference both domains
2. **Shared references** — both domains mention the same person, book, or concept
3. **Common tags** — same tags or properties applied across both neighborhoods
4. **Thematic overlap** — similar language, problems, or approaches even without explicit links
5. **Temporal overlap** — both domains active during the same time periods

Even without direct links, look for:
- Similar problem-solving approaches
- Shared vocabulary
- Parallel structures
- Analogous challenges

**Output for Phase 2:**

```
Overlaps Found:
- Direct links: {count} notes
- Shared references: {list}
- Common tags: {list}
- Thematic overlaps: {description}
- Temporal overlaps: {periods when both active}
```

### Phase 3: Trace Bridges

For each overlap found in Phase 2, determine whether it's a surface-level coincidence or a structural bridge.

**Surface-level bridges:**
- Same word used in different contexts
- Coincidental overlap
- No deeper relationship

**Structural bridges:**
- Same principle applied in both domains
- Transferable insight
- Common underlying pattern
- Productive tension or complementarity

**Key questions for each candidate bridge:**
1. Does insight from Domain A inform Domain B (or vice versa)?
2. Is there a shared mental model or framework?
3. Does solving a problem in Domain A help with Domain B?
4. Are there transfer effects?

**Intermediary notes:** Look for notes that sit at the intersection of both domains. These often contain the deepest insights and make the best evidence for a structural bridge.

**Temporal analysis:** Compare recent vault activity (past month) against older activity (6+ months ago). Are the domains:
- **Converging** — increasing overlap over time
- **Diverging** — decreasing overlap, growing apart
- **Stable** — consistent level of connection

**Output for Phase 3:**

```
Bridges Identified: {total count}

Structural Bridges:
1. {Bridge name}
   - Appears in Domain A as: {description}
   - Appears in Domain B as: {description}
   - Underlying link: {what connects them}
   - Depth: Structural | Surface
   - Evidence: [[specific note]], [[specific note]]

2. {Next bridge...}

Intermediary Notes:
- [[Notes that sit at the intersection]]

Convergence Trend:
- {Converging | Diverging | Stable}
- Evidence: {temporal analysis summary}
```

### Phase 4: Synthesize

Document the findings and generate actionable insight.

**Synthesis components:**

**Connection Map:**
- Total bridges: {count}
- Structural bridges: {count}
- Surface bridges: {count}
- Strength of connection: Weak | Moderate | Strong

**Strongest Connection:**
The single most reframing or surprising bridge, with why it matters, what it enables, and how it challenges assumptions.

**Missing Links That Should Exist:**
Based on the analysis, what connections should be made but aren't? Specific notes that should reference each other. Concepts that bridge domains but aren't captured anywhere.

**New Question This Connection Reveals:**
What does the bridge between these domains make the user wonder about? A question they couldn't ask before seeing the connection. A hypothesis worth testing. An experiment to try.

**Recommended Actions:**
1. Create specific wikilink between notes
2. Explore specific intersection further
3. Start conversation or investigation based on insight

### Phase 5: Present Findings

Present to the user in the following structured format:

```
🔮 Nexus Connect — {Domain A} × {Domain B}

Domain A: {Name}
- Size: {X notes core, Y extended}
- Key themes: {list}
- Active periods: {when}

Domain B: {Name}
- Size: {X notes core, Y extended}
- Key themes: {list}
- Active periods: {when}

Bridges Discovered: {count} total
Convergence trend: {Converging | Diverging | Stable}

Structural Bridges:
1. {Bridge with evidence}
2. {...}

Strongest Connection:
{Description of most important finding}

Most Reframing Insight:
{What does this connection reveal that you didn't see before?}

Missing Links:
{Specific recommendations for connections to create}

New Question:
{What does seeing this connection make you wonder about?}

Recommended Actions:
1. Create Link: [[Note A]] → [[Note B]] — {why}
2. Explore Intersection: {topic} — {how to investigate}
3. Apply Insight: {transfer learning} — {context}
```

### Phase 6: File (User-Directed)

Ask the user: "Want me to file this connection as an emergent page in the Nexus?"

If yes, create a page in `Nexus/pages/emergent/` with this frontmatter:

```yaml
---
type: emergent
genesis: emergent
discovery-type: cross-domain
created: {ISO date}
updated: {ISO date}
sources: [{list of vault pages this connection draws from}]
domains: [{Domain A}, {Domain B}]
confidence: {high/medium/low}
tags: [{relevant tags}]
---

# {Domain A} × {Domain B} — {Bridge Title}

## Observation
{The bridge, stated clearly}

## Evidence
- [[Vault Page]] — {what it contributes}
- [[Vault Page]] — {what it contributes}

## Implications
- {What this connection enables}
- {Questions it raises}
- {Actions it suggests}

## Convergence
{Converging / Diverging / Stable — with evidence}

## Confidence
{Why high/medium/low. What would strengthen or weaken it.}
```

If the user also wants to apply the **Missing Links** recommendations (adding wikilinks inside existing vault pages), treat each one as a metadata-only edit. Present each proposed edit individually, wait for approval, then apply. This is permitted under the metadata-enhancement rule. Never modify content outside the Nexus root.

Update `Nexus/index.md` under the `## Emergent` section if a page was filed.

### Phase 7: Log

Append to `Nexus/log.md`:

```markdown
## [{ISO date}] connect | {Domain A} × {Domain B}

Mapped: {N} notes in A, {N} notes in B.
Overlaps: {N} direct, {N} thematic, {N} temporal.
Bridges: {N} structural, {N} surface.
Trend: {Converging/Diverging/Stable}
Filed: {N} emergent pages. Applied links: {N}.
```

## Constraints

- Minimum 2-hop exploration per domain
- Adjust hop depth based on domain size disparity
- Focus on structural bridges over surface-level overlaps
- Every bridge must cite specific vault evidence
- Temporal analysis should cover at least 3-6 months if possible
- Cap at 10 bridges maximum — quality over quantity
- If the bridge is obvious, skip it. It's probably already linked. Look for the subtle, surprising, or emergent relationships.

## Path Configuration

Vault root is passed at invocation time. Uses `{rp-path}` from shared praxis config when priority context is relevant to bridge classification.

## Error Handling

| Scenario | Behavior |
|----------|----------|
| A domain keyword returns zero matches | Report: "Domain '{name}' has no vault presence. Check spelling or try a related term." Stop. |
| Both domains are very sparse (<5 notes each) | Warn the user: "Both domains are thin. Results may be anecdotal rather than structural." Ask whether to proceed. |
| One domain is vastly larger than the other | Adjust hop depth per the sparse/dense rule and note it in Phase 1 output. |
| No bridges found | Report honestly: "No meaningful bridges detected. These domains appear independent in the current vault. This may be a gap worth filling." |
| User-requested missing-link edits would touch files outside Nexus root | Per-file approval required. Present the exact edit, wait for user confirmation, then apply. |

## Relationship to Other Modes

- **vs. discover**: Discover looks broadly for patterns; connect looks at the relationship between two specific domains. Connect may be merged into discover in the future — flagged for revisit.
- **vs. map**: Map shows the shape of the whole vault; connect zooms into the relationship between two neighborhoods inside it.
- **vs. link**: Link recommends missing connections across the whole vault with scoring. Connect finds bridges specifically between the two given domains and may recommend links as one type of action.
