# Nexus Trace — Idea Evolution

Track how an idea evolved across the vault over time through vocabulary shifts, temporal patterns, confidence markers, and conceptual connections. Tell the story of the idea's development — not just list mentions.

**Mode:** `trace`

**Scope:** Vault-wide. Reads across the entire Obsidian vault.

**Genesis:** Pages created by this mode are tagged `genesis: synthesis`.

## Overview

Trace shows ideological evolution by finding all references to an idea (including synonyms and implicit evidence), building a chronological timeline, identifying what triggered thinking shifts, mapping confidence evolution, and surfacing unresolved tensions.

**Key insight:** Ideas often evolve under different vocabulary. What you called one thing early on may be called something else later. A trace that only searches for the exact phrase will miss most of the story.

**Invocation:**

```
nexus trace {idea or topic}
```

## Workflow

### Phase 1: Synonym Discovery

Before searching, identify alternative phrasings and related terminology for the target idea. Ideas drift through vocabulary over time — the trace must follow them.

**Variant types to generate:**

- **Jargon variants** — technical term vs. casual phrase, industry language vs. personal shorthand
- **Shorthand** — acronyms, abbreviated references, nicknames for concepts
- **Metaphorical language** — how the idea is described metaphorically, analogies used
- **Evolution patterns** — early exploratory language ("thinking about..."), middle development ("I believe..."), late crystallization (confident assertions)

Search the vault for the primary term and each variant. Record how many times each appears.

**Output for Phase 1:**

```
Vocabulary Map:
- Primary term: "{term}" — {X} mentions
- Synonym 1: "{term}" — {Y} mentions
- Synonym 2: "{term}" — {Z} mentions
- Related concepts: {list}
- Metaphors used: {list}
```

### Phase 1.5: Implicit Pattern Detection

When explicit mentions are sparse, look for implicit evidence. This phase is what distinguishes a trace from a simple search.

**Search methods:**

- **Broader contextual searches** — topics that imply the idea without naming it, projects that embody the concept, decisions that reflect the belief
- **Emotional reactions** — frustration with the opposite approach, excitement about related discoveries, concern about implications
- **Decisions reflecting unstated thinking** — choices that reveal a belief, prioritization that shows values, avoidance that indicates concerns

**Example:**
- Idea: "Async communication"
- Explicit: "async communication" mentioned 5 times across the vault
- Implicit: 20 diary entries about "avoiding unnecessary meetings", "writing instead of calling", frustration with interruptions

**Output for Phase 1.5:**

```
Implicit Evidence:
- Behavioral patterns: {description with note references}
- Emotional reactions: {description with diary entries}
- Decision patterns: {description with examples}
- Thematic adjacency: {related topics that imply this idea}
```

### Phase 2: Follow the Graph

Examine backlinks and forward links 2-3 hops from significant mentions. The goal is to understand context and influences — what led to the idea, and what it led to.

**For each significant mention:**
1. Check backlinks — what influenced this note?
2. Check forward links — what did this note influence?
3. Go 2-3 hops deep to find:
   - Source influences (books, conversations, experiences)
   - Parallel concept evolution (related ideas developing alongside)
   - Downstream applications (where the idea was applied)

**Method:** For each vault page matching the idea or its synonyms, read the page, collect all wikilinks (outgoing), and walk the reverse wikilink index (incoming). Repeat to the configured hop depth. Record the context around each wikilink — a wikilink without surrounding context isn't evidence.

**Output for Phase 2:**

```
Graph Context:

Source Influences:
- [[Book/Article]] — introduced concept {date}
- [[Conversation with Person]] — challenged assumption {date}
- [[Experience/Project]] — validated through practice {date}

Parallel Evolution:
- [[Related Idea A]] — developed alongside, {relationship}
- [[Related Idea B]] — evolved in parallel, {relationship}

Downstream Applications:
- Applied in [[Project X]] — {how}
- Informed [[Decision Y]] — {how}
- Led to [[New Idea Z]] — {how}
```

### Phase 3: Build the Timeline

Organize all references chronologically with context. Every entry needs a date, a source, and the thinking captured at that moment.

**Timeline entry format:**

- **Date:** YYYY-MM-DD
- **Source:** [[Note Name]] (type: diary/project/essay/note)
- **Thinking at that moment:** quote or summary
- **Confidence marker:** `[solid]` | `[evolving]` | `[hypothesis]` | `[questioning]`
- **Trigger (if identifiable):** what prompted this thinking?

**Temporal weighting:**
- Recent mentions (past 3 months) — active evolution
- Medium history (3-12 months) — maturation phase
- Ancient history (12+ months) — foundational development

**Gap analysis:** Identify dormancy periods (long stretches with no explicit mentions). These often indicate "underground development" — thinking happening implicitly through decisions and behavior rather than writing. Gap analysis is mandatory for dormancy periods longer than 2 months.

**Method:** Use the `vault` skill — `vault temporal-inventory {vault-path} [--since <date>] [--until <date>]` — to build a chronological mention timeline (returns TSV: `date`, `file`, `doctype`, `status`, `word_count`). Filter results for entries matching the term and synonyms, sort chronologically, then read the context around each mention to capture the thinking at that moment. Gap detection: flag dormancy periods longer than 2 months between matched entries.

**Output for Phase 3:**

```
Evolution Timeline:

2024-03-15 | [[Daily Note]] | [evolving]
"Starting to think that {idea} might be key to {problem}..."
Trigger: Conversation with {person} about {topic}

2024-04-02 | [[Project Note]] | [hypothesis]
"Testing whether {idea} applies to {context}"
Trigger: Frustration with {alternative approach}

[Gap: 2 months — no explicit mentions, but implicit evidence in decision patterns]

2024-06-10 | [[Essay Draft]] | [solid]
"I'm convinced that {idea} is essential because {evidence}"
Trigger: Successful application in {project}

[Continue chronologically...]
```

### Phase 4: Identify the Arc

Synthesize the timeline into a narrative pattern. Arcs are the shape of the evolution — not just what happened, but what kind of story it is.

**Arc types:**

- **Linear Deepening** — idea gets progressively more developed; confidence increases; applications expand
- **Pivot** — significant change in direction; "I used to think X, now I think Y"; clear before/after states
- **Convergence** — multiple threads coming together; different domains pointing to the same conclusion; integration of separate ideas
- **Divergence** — one idea splitting into multiple branches; specialization or differentiation; exploration of variations
- **Circular** — returning to earlier thinking; "I was right the first time"; cycle of exploration and return

**What triggered shifts?** Books/articles read, conversations, direct experiences, failed experiments, successes. Every major shift should have a trigger attributed if the evidence supports it.

**Output for Phase 4:**

```
Evolution Arc: {Type}

Narrative Summary:
{2-3 paragraphs describing the evolution story}

The idea first appeared in {date/context} as {initial form}. Early thinking was
characterized by {pattern}, with confidence markers showing {level}.

The major shift occurred around {date} triggered by {event/influence}. Thinking
pivoted from {old view} to {new view}, visible in {evidence}.

Currently, the idea has {matured/stalled/split/etc.}, with recent mentions showing
{pattern}. The trajectory suggests {where it's heading}.

Key Triggers:
1. {Date} — {Event} — Shifted thinking from {X} to {Y}
2. {Continue for major shifts...}
```

### Phase 5: Confidence Evolution & Unresolved Tensions

Track how certainty changed and where tensions remain.

**Confidence tracking:**

Map confidence markers over time:
- `[questioning]` → `[hypothesis]` → `[evolving]` → `[solid]` (typical progression)

What earned increases in confidence? What earned decreases? Look for:
- Successful application
- External validation
- Accumulating evidence
- Time and stability

**Unresolved tensions:**

- Contradictions that persist (but may be productive — see `insight contradictions`)
- Questions that remain open
- Competing interpretations
- Areas of uncertainty

**Temporal analysis of tensions:**
- Which tensions are recent? May require attention.
- Which are longstanding? May be productive — worth sitting with rather than resolving.
- Any tensions that resolved over time?

**Output for Phase 5:**

```
Confidence Evolution:

{Date} — [questioning] — "Not sure if this makes sense..."
{Date} — [hypothesis] — "Worth testing whether..."
{Date} — [evolving] — "Seeing evidence that..."
{Date} — [solid] — "I'm convinced because..."

Confidence Shifts Earned By:
1. {Event/evidence} — moved from {marker} to {marker} on {date}
2. {Continue...}

Unresolved Tensions:

Recent Tensions (past 3 months):
- {Description} — cited in [[Note]], [[Note]]
- {Requires attention / Productive ambiguity}

Longstanding Tensions (6+ months):
- {Description} — first appeared {date}, still present
- {Productive / Stuck / Worth resolving}

Resolved Tensions:
- {Description} — resolved on {date} via {resolution}
```

### Phase 6: Present Findings

Present to the user in the following structured format:

```
🔮 Nexus Trace — {Idea}

First Appearance: {YYYY-MM-DD} in [[Note]]
Timespan: {X months/years}
Total Mentions: {X} (explicit: {Y}, implicit: {Z})
Velocity: {Accelerating | Steady | Decelerating | Dormant}

Vocabulary Evolution:
{From Phase 1}

Timeline:
{Chronological entries from Phase 3}

Narrative Arc: {Type}
{Summary from Phase 4}

Confidence Evolution:
{From Phase 5}

Unresolved Tensions:
{From Phase 5}

Projected Trajectory:
Based on recent velocity and patterns, this idea appears to be:
- {Maturing toward application}
- {Splitting into sub-variations}
- {Converging with other ideas}
- {Entering dormancy}
- {Other pattern}

Recommendation: {What to do with this idea next}
```

### Phase 7: File (User-Directed)

Ask the user: "Want me to file this trace as a synthesis page in the Nexus?"

If yes, create a page in `Nexus/pages/synthesis/` with this frontmatter:

```yaml
---
type: synthesis
genesis: synthesis
synthesis-type: trace
created: {ISO date}
updated: {ISO date}
idea: {idea name}
timespan: {first appearance → last mention}
arc-type: {linear-deepening | pivot | convergence | divergence | circular}
velocity: {accelerating | steady | decelerating | dormant}
sources: [{all vault pages cited in the timeline}]
tags: [{relevant tags}]
---

# Trace: {Idea}

## Vocabulary Evolution
{From Phase 1}

## Timeline
{From Phase 3}

## Narrative Arc
{From Phase 4}

## Confidence Evolution
{From Phase 5}

## Unresolved Tensions
{From Phase 5}

## Projected Trajectory
{Summary}
```

Update `Nexus/index.md` under `## Synthesis`.

### Phase 8: Log

Append to `Nexus/log.md`:

```markdown
## [{ISO date}] trace | {Idea}

Mentions: {X} explicit, {Y} implicit across {Z} months.
Arc: {type}
Velocity: {accelerating/steady/decelerating/dormant}
Unresolved tensions: {N}
Filed: {yes/no}
```

## Constraints

- Search comprehensively for synonyms and implicit evidence
- Include implicit mentions when explicit ones are sparse
- All timeline entries must cite specific notes with dates
- Confidence markers must reflect actual language in notes, not inferred
- Gap analysis is mandatory for dormancy periods longer than 2 months
- Projected trajectory must be grounded in recent patterns, not speculation
- Tell the story of the idea's development, not just list mentions

## Path Configuration

Vault root is passed at invocation time. Diary entries (`{diary-path}`) are a high-value source for trace — they often contain the earliest and most casual mentions of an idea. This placeholder resolves from shared praxis config at runtime.

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Fewer than 3 explicit mentions and no implicit evidence | Report: "Insufficient vault evidence for a meaningful trace. The idea may be too new, too implicit, or named differently than I searched." Ask the user if they want to supply additional synonyms. |
| All mentions cluster in a single week | Report: "All mentions are within a {N}-day window — not enough temporal spread to show evolution. This is a snapshot, not a trace." |
| No confidence markers visible in the text | Note it: "Confidence markers weren't explicit in the source notes. Arc analysis will rely on vocabulary shifts and trigger events instead." |
| User requests trace of something that matches too broadly | Ask for disambiguation before searching. |

## Relationship to Other Modes

- **vs. discover**: Discover finds patterns across the whole knowledge base; trace follows one idea through time.
- **vs. insight contradictions**: Trace may surface unresolved tensions along the way. Those tensions are raw material for `insight contradictions`, which decides whether they're productive.
- **vs. query**: Query answers a specific question with citations. Trace tells a chronological story of how thinking on a topic has moved.
