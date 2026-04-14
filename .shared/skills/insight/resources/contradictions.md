# Find Generative Contradictions

Surface productive tensions in the vault — beliefs, frameworks, or claims that cannot cohere in the same frame but that are worth **holding** rather than resolving. This mode is about the contradictions you want to sit with: the ones that generate thought, reveal hidden frames, or mark growth.

## Scope

This mode is for *generative* contradictions only. Resolve-class contradictions (confused thinking, stale data, unreconciled conflicts that should be cleaned up) are handled by `nexus lint` Phase 2c. If a contradiction should be fixed, it's not this mode's job. If it's worth thinking about, it is.

**When to use this mode:**
- You're doing theoretical or research work where contradictions are expected and often valuable
- You want to audit your strongest-held beliefs for tensions you've been ignoring
- You suspect growth has left older beliefs incoherent with newer ones, and you want to celebrate the shift
- You want to find the productive frictions that might seed a new insight

**When not to use this mode:**
- You want to clean up the vault — use `nexus lint`
- You want to pressure-test a specific belief — use `reflection challenge`
- You want to see how a belief evolved — use `nexus trace`

## Core Definition

A generative contradiction is a pair of positions held simultaneously in the vault that:

1. Cannot both be true in the same frame at the same time
2. Are both supported by real evidence (not manufactured from surface-level wording differences)
3. Are worth holding — because resolving them would destroy information, because the tension itself points at something interesting, or because the contradiction is evidence of thinking that has grown

The goal is not to fix anything. The goal is to make the tensions visible and classify them so you can decide what to do with each one.

## Five-Step Process

### Step 1: Belief Extraction

Extract 15-20+ beliefs from the vault. Focus on beliefs strong enough to carry theoretical weight — vague preferences don't generate meaningful contradictions.

**Where to look:**
- Context files and project notes — load-bearing claims
- Daily notes and diary entries — casual but sincere expressions
- Essay drafts and synthesis pages — crystallized positions
- Ruthless priorities — what's been declared as mattering most

**What to look for:**

Pattern-match for strong assertive language in vault markdown files. Common markers include: "I believe", "the truth is", "clearly", "obviously", "without question", "it's obvious that", "the real issue is", "what matters is", "the most important thing". Also look for imperative framings ("you must", "the right way is") and definitional claims ("X is fundamentally Y").

**For each extracted belief, record:**
- Source citation (page name + date)
- The belief statement (verbatim or lightly paraphrased)
- The implied inverse statement
- Your sense of how load-bearing this belief is in the user's thinking

**Example:**
- Belief: "Deep work requires uninterrupted time"
- Implied inverse: "Interrupted time cannot produce deep work"
- Load-bearing: high — referenced in productivity framework and multiple project plans

### Step 2: Detection — Where Tensions Live

Run all three detection methods. Collect candidates broadly at this stage. Filtering happens in Step 3.

**Explicit contradictions**

- *Same domain* — directly opposing claims about the same topic within one area of work or thought
- *Across domains* — claims where the same concept is treated incompatibly in different contexts
- *Framework conflicts* — two frameworks that cannot both be applied to the same situation

**Implicit contradictions**

- *Stated values vs. documented behavior* — principles asserted in one place contradicted by actions recorded elsewhere
- *Advice given vs. personal practice* — prescriptions that don't match the record
- *Definitional drift* — the same word used to mean two incompatible things across notes

**Priority contradictions**

- Multiple items claimed as "the most important thing"
- Hierarchies that mutually exclude each other
- Frameworks that rank priorities in incompatible orders

### Step 3: The "Worth Holding" Filter

This is where generative contradictions separate from resolve-class ones. A candidate passes this filter if **at least one** of the following is true:

**Domain Compartmentalization as a Feature**

The two beliefs can coexist in separate frames, and the frames themselves are interesting. This is not an error — it's evidence of nuanced thinking that applies different rules in different contexts. The contradiction is worth holding because the *comparison* of the two frames reveals something neither frame alone would show.

Example: "Move fast and iterate" (startup frame) and "Measure twice, cut once" (production frame) are contradictory in the same frame but generative across frames. Holding them together reveals when a project is actually in which phase.

**Load-Bearing Tension**

Both beliefs are load-bearing in different parts of the thinking. Resolving the contradiction would require tearing down structure on one side or the other. The tension is doing work — it's holding two real commitments in balance.

**Evidence of Growth**

One belief is older, one is newer, and both still carry weight in the vault. This is not a stale claim (which lint would flag) — it's a live tension between where the thinking used to be and where it is now. Worth celebrating as evidence of movement, not resolving as error.

**Generative Friction**

The contradiction, stated plainly, produces a question the user couldn't otherwise ask. The friction is the source of new thinking. If stating the contradiction makes you want to write something new, it's generative.

**If none of these apply:** the contradiction is probably resolve-class. Refer the user to `nexus lint` for cleanup and do not flag it here.

### Step 4: Classification

For each contradiction that passes the filter, classify it on two axes.

**Category:**

- **Hold** — productive tension that should be preserved. Resolving it would destroy information. The contradiction is doing work. Most generative contradictions live here.
- **Celebrate** — evidence of growth. Old belief is still on record, new belief has emerged, and the gap between them is a marker of how the thinking has moved. Not something to fix — something to honor.

(The third category, "Resolve," does not exist in this mode. If a contradiction should be resolved, it belongs to `nexus lint` Phase 2c, not here. When in doubt about whether a contradiction is Hold or Resolve, ask the user.)

**Weight:**

- **Trivial** — stylistic or low-consequence tension. Interesting to note, not worth dwelling on.
- **Moderate** — affects one area of work or thinking. Worth a paragraph of reflection.
- **Significant** — affects multiple areas, or sits at the center of one major area. Worth a dedicated note.
- **Foundational** — one of the load-bearing tensions in the entire vault. The kind of contradiction that if resolved would change how the user thinks about everything downstream. Rare. Flag prominently.

### Step 5: Output

Present findings in the following structured format. Every contradiction must include citations with dates. No citation, no flag.

```
🧭 Insight Contradictions — Generative Tensions

Extracted {N} beliefs from {N} vault pages.
Candidates found: {N}
Passed "worth holding" filter: {N}

Foundational (rare): {N}
Significant: {N}
Moderate: {N}
Trivial: {N}

---

1. [HOLD | SIGNIFICANT] {Short title}

   Belief A: "{statement}"
   Source: [[Page]] ({date})

   Belief B: "{statement}"
   Source: [[Page]] ({date})

   Why they can't cohere (same frame):
   {one-paragraph explanation of the logical incompatibility}

   Why this is worth holding:
   {which filter condition triggered: compartmentalization / load-bearing /
   growth / generative friction — with specific reasoning}

   What this tension generates:
   {the question, the framing, the comparison, or the insight that only
   exists because both beliefs are held simultaneously}

2. [CELEBRATE | MODERATE] {Short title}

   [Same structure]

...
```

**For each contradiction, also note:**
- Whether the tension is recent (past 3 months), longstanding (6+ months), or newly surfaced
- Any related contradictions that might cluster together
- Whether the tension maps to an existing concept page or would warrant a new one

## Anti-Patterns

Do not flag:

- **Evolution masquerading as contradiction.** If the older belief is clearly superseded and no longer holds weight, it's stale content (lint's job), not a generative tension.
- **Surface-level wording differences.** Two sentences that say the same thing in different words are not contradictions.
- **Manufactured conflicts.** If you have to stretch to make the two beliefs incompatible, they aren't. Don't fill a quota.
- **Psychological over-interpretation.** This mode reports what the vault says, not what you think it means about the user's psyche. Stay on the evidence.
- **Confidence-marker differences.** "I think X" and "X is likely" are not in conflict. Different confidence levels are not contradictions.

**Precision rule:** If the vault is well-integrated and holds no productive tensions, say so. The honest answer is often that there are only two or three contradictions worth flagging. That's fine. Do not manufacture tensions to justify the run.

## Constraints

- Mandatory citation with dates for both sides of every flagged contradiction
- Every flagged contradiction must pass the "worth holding" filter (Step 3)
- Every flagged contradiction must have a classification (Category + Weight)
- Foundational-weight flags are rare by definition — if every contradiction looks foundational, something is wrong with the scoring
- All searches operate on the file system across the vault root, passed at invocation time

## Relationship to Other Modes

- **vs. `nexus lint` Phase 2c** — lint handles resolve-class contradictions (confused thinking, stale data, unreconciled conflicts that should be cleaned up). This mode handles hold-class and celebrate-class contradictions (productive tensions worth sitting with). The two modes share detection methodology (belief extraction, pattern-matching for belief markers, the "cannot both be true" logical test) but filter and classify differently. When you're not sure which category a contradiction belongs to, ask the user.
- **vs. `reflection challenge`** — challenge pressure-tests a specific belief through counter-evidence. This mode surfaces pairs of beliefs that already conflict in the record. Challenge is targeted at one belief; contradictions is broad-scan across many.
- **vs. `nexus trace`** — trace shows how one idea evolved through vocabulary shifts and confidence changes. A generative contradiction may be a snapshot of a live evolution. If a flagged contradiction in this mode looks like it might be an arc in disguise, recommend the user run `nexus trace` on the underlying idea.
