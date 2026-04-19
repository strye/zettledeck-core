# ideate

Surface ideas already implicit in your workspace and generate new ideas grounded in vault patterns. Every output is tagged **surfaced** (already implied by the evidence) or **generated** (synthesized from patterns but not yet stated anywhere).

## Scope Resolution

Before analysis, resolve which workspace folders to cover.

**Default (no arguments):** Read `workspaceFolders` from `.zettledeck/core/config.json`. Include all entries where `"enabled": true`.

**With role arguments:** Filter `workspaceFolders` to only entries whose `"role"` matches one of the provided arguments. Warn on any role not found in config — do not silently skip.

```
/insight ideate                              — all enabled workspace folders
/insight ideate capture                      — folder with role "capture" only
/insight ideate capture incubation           — folders with roles "capture" + "incubation"
/insight ideate capture incubation documentRepo   — roles "capture" + "incubation" + "documentRepo"
```

Produce a scope summary before proceeding:
```
Scope: {N} workspace folders — {folder1} ({role1}), {folder2} ({role2}), ...
```

---

## Five-Phase Process

### Phase 1: Structural Analysis

Analyze the topology of the scoped folders.

**Steps:**
1. Run `vault link-graph {vault-root}` to get the full wikilink graph (TSV: source, target, weight); filter to files within scoped folders
2. Run `vault stats {vault-root}` for structural overview (file counts, word counts, orphan count)
3. Identify orphaned notes, deadends, and unresolved links within scope
4. Look for hidden relationships across folders in scope

**Look for:**
- Orphaned notes in specific domains (neglected interests)
- Deadends (topics that need expansion)
- Unresolved links (questions being actively asked)
- Structural bridges implied but never explicitly drawn

---

### Phase 2: Content Analysis

Read deeply across the scoped folders using the five detection methods below. Apply all five in order of reliability.

#### Detection Method 1 — Structural (Highest Reliability)

Connections the vault's architecture implies but never draws.

- Look for patterns in what connects to what vs. what doesn't
- Find notes that orbit the same missing target
- Identify domains that consistently orphan when they touch a specific topic

*Example: "Three workspace folders all have unresolved links to the same non-existent note name"*

#### Detection Method 2 — Thematic

Unnamed patterns recurring across 3+ domains or folders.

- Search for the same problem-solving approach used in multiple scopes
- Look for the same tension appearing in different contexts
- Find recurring decision patterns across folders

**Requirements:** Must appear in 3+ different scopes/domains. Must be unnamed (not tagged or explicitly referenced). Must be a consistent pattern, not coincidence.

#### Detection Method 3 — Logical

Premises scattered across notes whose conclusions go unstated.

- Identify Premise A in one note, Premise B in another
- Recognize that A + B logically implies C
- Verify that C never appears anywhere in scope

*Example: Note 1: "Deep work requires 4+ hour blocks" / Note 2: "Calendar is fragmented into 1-hour meetings" / Missing conclusion: "Current calendar structure prevents deep work"*

#### Detection Method 4 — Behavioral

Recurring decisions that reveal unarticulated beliefs.

- Review diary entries, decision logs, meeting notes within scope
- Identify consistent choices (favoring depth over breadth, avoiding certain risks)
- Extract the unstated values or beliefs driving those choices
- Verify the belief itself is never explicitly articulated

#### Detection Method 5 — Convergence (Lowest Reliability)

Forward-looking threads pointing toward the same unnamed destination.

- Find notes with future-oriented language ("should explore", "need to learn", "want to understand")
- Identify where 3+ threads point to the same unstated thing
- Articulate what they're converging toward

**Warning:** Lowest reliability. Only include findings with strong evidence across multiple independent notes.

---

### Phase 3: Check Previous Runs

Prevent redundant output by checking what's already been suggested.

1. Search scoped folders for previous `/insight ideate` outputs
2. Identify which suggestions gained traction (were acted upon or promoted to permanent notes)
3. Identify which stalled (mentioned once, never revisited)
4. Do not re-surface or re-generate stalled ideas unless the pattern has materially changed since the last run — if so, note what changed

---

### Phase 4: Pattern Synthesis

Synthesize findings before producing ideas.

For each pattern found:
```
Pattern: [Name]
Evidence:
- [Specific vault reference 1]
- [Specific vault reference 2]
- [Specific vault reference 3]
Implication: [What this suggests]
```

**Categories to look for:**
- **What's Working** — patterns of success, flow, productive systems
- **What's Frustrating** — recurring friction, bottlenecks, inefficiencies
- **What's Missing** — gaps between stated priorities and actual activity
- **Recurring Interests** — topics appearing across multiple domains
- **Bottlenecks** — capability gaps preventing progress

---

### Phase 5: Produce Ideas

Generate 3-5 total ideas (not 3-5 per category) across these ten categories:

1. **Tools to Build** — software, automation, scripts specific to your workflow
2. **Tools to Adopt** — existing tools/services that solve identified friction
3. **Systems to Implement** — processes, workflows, rituals to try
4. **Products to Purchase** — physical or digital products addressing specific needs
5. **Habits to Develop** — behavioral changes addressing patterns
6. **Subjects to Investigate** — learning topics aligned with recurring questions
7. **Content to Create** — writing, presentations, artifacts worth making
8. **Films to Watch** — specific films/documentaries relevant to current interests
9. **Conversations to Initiate** — specific people to talk to about specific topics
10. **Experiments to Run** — small tests to validate hypotheses

**Tag each idea:**
- `surfaced` — the idea is already implicit in the vault evidence; this run articulates what was already there
- `generated` — the idea is synthesized from patterns but was not previously implied by any single note or cluster

**Requirements for each idea:**
- **Specific:** "Read about productivity" ✗ | "Read 'Deep Work' — vault shows 15 references to focus fragmentation" ✓
- **Grounded:** must cite specific vault evidence
- **Actionable:** clear next step
- **Non-obvious:** not something you'd think of without the analysis

**Verification (surfaced ideas only):**
Before tagging an idea as `surfaced`, confirm it isn't already explicitly stated:
- Search with grep/ripgrep for the candidate idea and related terms across scoped folders
- Check variations and synonyms
- If found explicitly, mark as "Already Articulated" and exclude unless it adds new framing

---

## Output Structure

### Scope
```
{N} workspace folders: {folder list with roles}
```

### Patterns Identified

[3-5 patterns with evidence and implication, using the format from Phase 4]

---

### Ideas

For each idea (3-5 total):

**Idea:** [Specific, actionable suggestion]

**Type:** surfaced | generated

**Category:** [One of the ten categories]

**Evidence:**
- [Vault reference 1]
- [Vault reference 2]

**Impact:** [1-5] | **Novelty:** [1-5] | **Score:** [Impact × Novelty]

**Idea Strength** (1–4):
- **1 — Signal**: weak evidence, seen once or twice
- **2 — Forming**: recurring pattern across multiple entries
- **3 — Developed**: strong cross-domain evidence, clear shape
- **4 — Ready**: execution-ready, next steps are obvious

**Why now:** [Why this idea is relevant given current patterns]

---

### Highest-Leverage Opportunity

**Idea:** [The single idea with the highest score or most compelling rationale]

**Why this rises above the others:** [Explanation]

**First step:** [Concrete action]

---

### Near-Term Activation Plan

**Tomorrow:** [< 30 min action]

**This Week:** [1-4 hour investigation or setup]

**This Month:** [Meaningful implementation or deep exploration]

---

### Ideas Not Recommended

[1-2 ideas that might seem obvious but evidence suggests avoiding]

**Why not:** [Vault evidence showing this wouldn't work here]

---

### Conspicuous Absences

What did you expect to find but didn't? What does that absence itself suggest?

---

## Constraints

- 3-5 ideas total, not per category
- Every idea must cite specific vault evidence
- No generic productivity advice
- Prioritize ideas at the intersection of multiple patterns
- `surfaced` ideas must pass the verification check
- If previous runs exist, explain why new suggestions differ or what changed
- Scope warnings must be shown before analysis begins — never silently drop a requested role
