# Domain Scan

Survey the vault's knowledge landscape to produce a compound depth map — a portfolio view of where context has genuinely accumulated and where it remains shallow.

## Core Concept

Where `temporal` asks *"does this one question get better answers as context accumulates?"*, `scan` asks *"across all the domains in my vault, where has knowledge actually compounded — and where hasn't?"*

This is domain scanning: a method from strategic forecasting and futurology that surveys the knowledge landscape to identify where signals are strong vs. weak, where depth exists vs. where coverage is thin, and where compounding is actively happening vs. stalled. Applied to a personal vault, it produces a ranked depth map across your domains — actionable intelligence about where your vault is genuinely powerful and where it still has gaps.

**The output is a portfolio, not a single experiment.** Each domain gets a compound depth rating. The final deliverable is the comparative landscape across all domains.

## Invocation

```
/insight scan                                    — full vault scan (all domains)
/insight scan "Domain Name"                      — single domain deep scan
/insight scan "Domain A" "Domain B" "Domain C"   — targeted subset scan
```

**Full scan** (no arguments): surveys all scannable domains and produces the complete depth map portfolio. Use for periodic knowledge health checks and strategic portfolio reviews.

**Single domain** (one argument): runs the full temporal probe on that domain only. Produces a detailed compound depth analysis for that domain — all three period-bounded answers, full scoring, trajectory analysis. Use when you want to go deep on one area before making decisions about it.

**Subset scan** (multiple arguments): probes the listed domains and produces a comparative depth map for that subset. Cross-domain connection analysis in Phase 4 focuses on the relationships *between the specified domains* rather than across the whole vault. Use when doing research that spans a defined set of domains and you want to understand how their depth and connections compare.

## When to use this mode

- You want to understand where your vault has genuine intellectual depth vs. surface-level coverage
- You are doing strategic forecasting, futurology, or scenario planning and need to know which domains have enough accumulated context to support it
- You want to prioritize future investment — which domains to develop further, which to let mature, which to start
- You want a periodic health scan of your knowledge portfolio (quarterly, annually)
- You suspect some domains are better-developed than they feel, or worse than they appear
- You are researching a question that spans several specific domains and want to assess their relative depth and cross-domain connections before committing to the research direction

## Shared Foundation

This mode uses the temporal methodology as its analytical engine. Before proceeding, the executing agent should load `resources/temporal.md` and treat the following as its core toolkit:

- **Vault temporal shape mapping** (temporal Step 1) — used in Phase 2 below to establish the vault's timeline before domain probing
- **Inflection-point period selection** (temporal Step 2) — used per domain to find the three periods worth comparing
- **Context inventory method** (temporal Step 3) — used per domain to count what existed at each period
- **Hard context boundary discipline** (temporal Step 5 constraints) — applied to every per-domain answer generation
- **Anachronism check discipline** (temporal Step 6) — applied to every per-domain answer set
- **Scoring dimensions** (temporal Step 7) — Specificity, Actionability, Personal relevance, Cross-domain connections — applied per domain then aggregated
- **Null results are valid** — if a domain doesn't compound, that finding is as important as one that does

## Six-Phase Process

### Phase 1: Domain Inventory

Determine which domains to scan based on the invocation arguments.

**If no arguments (full scan):**
Identify all scannable domains in the vault. A domain is any coherent knowledge area that has its own cluster of notes — scopes, major projects, recurring themes, or named topic areas.

Sources for discovery:
- **Scopes** (`S{ID}_{Title}/`) — the top-level life/work domains declared in the vault
- **Hub notes** — notes with many backlinks often anchor implicit domains
- **Tag clusters** — groups of notes sharing tags reveal topic areas
- **Recurring themes in diary** — topics that appear repeatedly across months without a formal scope
- **Nexus synthesis pages** (if they exist) — `nexus map` output or previous topology snapshots can shortcut this step

**If one or more domain arguments provided:**
Use the specified domains directly. Skip discovery. For each named domain, locate its notes in the vault (by scope folder, tag, or search). If a named domain cannot be found, report it and ask the user to clarify before proceeding.

**Minimum threshold (applies in all modes):** A domain needs at least 8-10 notes and a span of at least 3 months of activity to be worth scanning. Below this threshold, flag it as "too young to scan."

**For each domain in scope, record:**
- Domain name and description (one sentence)
- Note count
- Date of earliest relevant note
- Date of most recent relevant note
- Active/dormant status (active = notes within the past 60 days)

**Output for Phase 1:**

```
Scan mode: {Full vault | Single domain: "{name}" | Subset: "{A}", "{B}", ...}

Domains to scan: {N}

1. {Domain Name} — {description} — {note count} notes — {date span} — {active/dormant}
2. {continue...}

Too Young to Scan (< 8 notes or < 3 months span):
- {Domain Name} — {note count} notes, {span} — revisit after more accumulation

[If named domain not found:]
- "{name}" — not found in vault. {Did you mean X? / Please clarify.}
```

### Phase 2: Map the Vault's Temporal Shape

Before probing individual domains, establish the vault's overall temporal structure. This is temporal Step 1 applied at the vault level rather than for a single question.

Using file modification dates, creation dates, and diary entry density, establish:

- When the vault was started
- When major accumulation periods occurred
- Any significant gaps or dormancy periods across the whole vault
- The vault's current velocity (accelerating / steady / decelerating)

This shared temporal map is used in Phase 3 when selecting periods for each domain — it ensures periods are chosen relative to real inflection points rather than arbitrary calendar intervals.

**Output for Phase 2:**

```
Vault Temporal Shape:

Started: {date}
Total active span: {X months/years}
Current velocity: {Accelerating | Steady | Decelerating}

Major accumulation periods:
- {date range}: {what drove accumulation}
- {continue...}

Significant gaps: {dates and durations, if any}
```

### Phase 3: Per-Domain Temporal Probe

For each scannable domain, run a condensed version of the temporal methodology to measure compound depth.

**For each domain:**

**3a: Select three periods** (temporal Step 2 method)
Using the vault's temporal shape from Phase 2 as a guide, identify inflection points specific to this domain — moments where relevant context roughly doubled. These are the three periods to compare.

**3b: Inventory context at each period** (temporal Step 3 method)
Use the `vault` skill — `vault temporal-inventory {vault-path} [--since <date>] [--until <date>]` — to inventory files over time (returns TSV: `date`, `file`, `doctype`, `status`, `word_count`). Filter for domain-term matches. Count exactly what existed in this domain at each period: notes, diary mentions, project references, external sources ingested.

**3c: Generate a representative question**
Formulate one question that:
- Depends on this domain's accumulated knowledge to answer well
- Would be answered differently with more vs. less context
- Is representative of why someone would build knowledge in this domain

For strategic/futurology use: the question should be a weak-signal or scenario-type question — something about trajectories, implications, or second-order effects. For general use: something about the core challenge or decision this domain addresses.

**3d: Generate three period-bounded answers** (temporal Step 5 constraints)
Apply hard context boundaries. Each answer uses only what existed at that period — no leakage forward. Equal length within 20%. Source claims tagged [VAULT: note, date].

**3e: Anachronism check** (temporal Step 6 method)
Verify no forward contamination in any of the three answers.

**3f: Score the differential** (temporal Step 7 dimensions)
Score each answer on: Specificity, Actionability, Personal relevance, Cross-domain connections (1-10 each).

Calculate:
- **Early score:** sum across four dimensions
- **Middle score:** sum
- **Present score:** sum
- **Compound gain:** Present score − Early score (max 40)
- **Compounding rate:** High (gain ≥ 24) / Moderate (12–23) / Low (1–11) / None (≤ 0)

**Output per domain:**

```
Domain: {Name}
Representative question: "{question}"

Periods selected:
- Early: {date} — {N} relevant notes
- Middle: {date} — {N} relevant notes
- Present: {date} — {N} relevant notes

Answers:
[Early — {date}]
{answer with [VAULT: citations]}

[Middle — {date}]
{answer with [VAULT: citations]}

[Present — {date}]
{answer with [VAULT: citations]}

Scores:
           Early   Middle   Present
Specificity    {X}     {X}      {X}
Actionability  {X}     {X}      {X}
Personal rel.  {X}     {X}      {X}
Cross-domain   {X}     {X}      {X}
Total         {X}/40  {X}/40   {X}/40

Compound gain: {+N} — Compounding rate: {High | Moderate | Low | None}

Depth finding: {One sentence describing what the score pattern reveals}
```

### Phase 4: Synthesize the Depth Map

Rank domains by compound depth and produce the portfolio view.

**Ranking:** Sort by compounding rate (High → Moderate → Low → None), then by present score within each tier.

**Pattern analysis across domains:**

- **High-compounding domains** — where has context genuinely accumulated? What drove it? What do these domains have in common?
- **Low or no compounding** — which domains haven't deepened despite note volume? Is this because notes are informational (facts, references) rather than analytical (reasoning, synthesis)? Or because the domain is too young? Or because notes exist but don't build on each other?
- **Cross-domain connections** — which domains are feeding each other? Where are the cross-domain connections showing up in the answers? For subset scans, focus specifically on the relationships *between the specified domains* — what do they share, where do they diverge, and where could they inform each other?
- **Strategic gaps** — which of your stated priorities (from ruthless priorities) have thin domain depth? Where does your vault not yet support your ambitions? For single-domain or subset scans, note whether the scanned domains are aligned with current priorities.

**Output for Phase 4:**

```
Depth Map — {vault name or date}

High Compounding ({N} domains):
1. {Domain} — gain: +{N} — "{one-line depth finding}"
2. {continue...}

Moderate Compounding ({N} domains):
{same structure}

Low Compounding ({N} domains):
{same structure}

No Compounding ({N} domains):
{same structure}

Pattern Analysis:

What's driving depth in high-compounding domains:
{observation — e.g., "regular diary reflection + applied project work + external source ingestion"}

Why low-compounding domains haven't deepened:
{observation — e.g., "notes are primarily factual/reference rather than analytical; no synthesis pages"}

Cross-domain feeding patterns:
{which domains are cross-pollinating — visible in Phase 3 cross-domain scores}

Strategic gaps (priority alignment):
{which ruthless priorities lack deep domain support}
```

### Phase 5: Recommendations

Surface actionable next steps based on the depth map. Recommendations are prioritized by alignment with ruthless priorities.

**Recommendation types:**

**Invest here** — High-compounding domains that are still active and aligned with priorities. These are your strongest knowledge assets. Deepen further: synthesize more, ingest more sources, ask harder questions.

**Synthesize now** — Domains with moderate or high note volume but low compounding. Notes exist but aren't building on each other. The lever is synthesis work — running `nexus query`, writing essay drafts, creating concept pages that draw across the individual notes.

**Let mature** — Domains with high compounding but current dormancy. The knowledge is deep; no action needed until the domain becomes relevant again.

**Start here** — Domains flagged as "too young to scan" that are aligned with current priorities. These need active investment to build the foundation.

**Reconsider** — Domains with persistent no-compounding despite age and volume. Notes aren't building on each other. Consider: is this domain misnamed (notes scattered under wrong headings)? Is the content format wrong (information rather than analysis)? Or is this domain genuinely not a knowledge area — more of a reference collection?

**Output for Phase 5:**

```
Recommendations:

Invest Here ({N}):
- {Domain} — {why} — {specific next action}

Synthesize Now ({N}):
- {Domain} — {why} — {specific synthesis action, e.g., "run nexus query on X"}

Let Mature ({N}):
- {Domain} — {why}

Start Here ({N}):
- {Domain} — {why} — {first note to write or source to ingest}

Reconsider ({N}):
- {Domain} — {why} — {diagnostic question}
```

### Phase 6: File (User-Directed)

Ask the user: "Want me to file this depth map as a synthesis page in the Nexus?"

If yes, create a page in `Nexus/pages/synthesis/` with this frontmatter:

```yaml
---
type: synthesis
genesis: synthesis
synthesis-type: domain-scan
created: {ISO date}
updated: {ISO date}
vault-snapshot:
  domains-scanned: {N}
  high-compounding: {N}
  moderate-compounding: {N}
  low-compounding: {N}
  none: {N}
tags: [domain-scan, vault-depth, knowledge-portfolio]
---

# Domain Scan — {ISO date}

{Full output from Phases 4 and 5}

## Per-Domain Detail

{Full output from Phase 3 for each domain}
```

Update `Nexus/index.md` under `## Synthesis`. A domain scan is time-bound — note the date clearly so future scans can compare against it.

## Anti-Patterns

Carry over from `temporal` (load `resources/temporal.md` for the full list), plus:

- **Confusing note volume with depth.** A domain with 50 notes that are all factual/reference has lower compound depth than a domain with 15 notes of genuine analysis and synthesis. The scoring system measures this — volume alone doesn't move the score.
- **Over-scanning young domains.** A domain that's 2 months old with 6 notes is not scannable. Flag it and move on.
- **Treating the depth map as a report card.** Low compounding is diagnostic, not a failure. It often means notes are being used differently in that domain (reference vs. reasoning), or synthesis work is overdue.
- **Ignoring null results.** A domain that doesn't compound despite age and volume is an important finding. Something is structurally different about how notes in that domain are written or connected.
- **Skipping the strategic gap analysis.** The depth map is most useful when compared against ruthless priorities. A domain that compounds well but isn't priority-aligned is less actionable than a domain that compounds poorly and is your top priority.

## Constraints

- Minimum domain threshold: 8-10 notes, 3+ months span
- All three period-bounded answers must maintain hard context walls (no leakage)
- All scoring must be consistent across domains (same rubric, same examiner)
- Strategic gap analysis requires reading ruthless priorities — do not skip it
- Compound gain can be negative (present score < early score) — report this honestly
- The depth map ranking is not permanent; it is a snapshot. Note the date.

## Relationship to Other Modes

- **vs. `temporal`**: Temporal probes one question across three periods to show compounding for that question. Scan probes all domains with one representative question each to produce a comparative depth map. Scan uses temporal's methodology as its engine; temporal is the focused instrument, scan is the landscape survey.
- **vs. `nexus map`**: Map analyzes vault structure — links, clusters, orphans, topology. Scan analyzes vault depth — whether accumulated context actually compounds into better answers. Map shows the shape; scan shows the substance.
- **vs. `nexus discover`**: Discover surfaces implicit ideas and patterns within the accumulated content. Scan measures whether the accumulation is deep enough to support that kind of discovery. Scan tells you where discover is likely to find something interesting.
- **vs. `orient`**: Orient loads operational state for immediate work. Scan assesses the long-term depth of the knowledge portfolio. Different time horizons, different purposes.
