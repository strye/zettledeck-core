# Challenge Thinking

Pressure-test beliefs against vault history to surface contradictions and unexamined assumptions.

## Core Purpose

Use accumulated vault notes as evidence to challenge current beliefs by finding:
- Self-contradictions
- Abandoned positions never explicitly resolved
- Unearned confidence
- Wishful thinking
- Blind spots
- Stale thinking

**Key Principle:** Challenge only when vault contains genuine contradicting evidence. Cite specific notes and dates; vague challenges lack utility.

## Four-Step Process

### Step 1: Identify Beliefs

Extract statements from context files and recent daily notes.

**Search Patterns:**
Use grep/ripgrep to search across vault markdown files for:
- `"I believe"`
- `"the problem is"`
- `"convinced that"`

**Belief Types:**
- Confident assertions
- Problem diagnoses
- Value statements
- Strategic choices
- Predictions

**Prioritize beliefs tagged:**
- `[evolving]` - Still developing
- `[hypothesis]` - Explicitly tentative
- `[questioning]` - Under active scrutiny

**Output:**
```
Beliefs Identified: [count]

1. [Belief statement] - [[Source Note]], [Date] - Marker: [solid/evolving/hypothesis]
2. [Continue...]
```

### Step 2: Find Contradictions

Search backward through vault history for evidence that challenges beliefs.

**Contradiction Types:**

**Self-Contradictions:**
- Stated belief X now, stated opposite before
- Current position incompatible with past position

**Abandoned Positions:**
- Shifted from X to Y without explicitly acknowledging change
- Old belief still cited elsewhere as if current

**Unearned Confidence:**
- Marked `[solid]` but evidence is thin
- Confident assertion without testing
- Belief upgraded without clear trigger

**Wishful Thinking:**
- What you want to be true vs. what evidence shows
- Optimistic interpretation contradicted by outcomes

**Blind Spots:**
- Consistent pattern you don't acknowledge
- Others see but you don't
- Visible in behavior not beliefs

**Stale Thinking:**
- Old framing no longer accurate
- Context changed but belief didn't
- Assumption expired

**Search Method:**
- Use grep/ripgrep to search for historical mentions of the topic across vault files
- Read chronologically to find shifts
- Look for opposite positions
- Note when confidence changed

**Temporal Weighting:**
- Recent tensions (past 3 months): Demand immediate attention
- Ancient contradictions (12+ months): May indicate growth unless never resolved

**Output:**
```
Contradictions Found: [count]

Tension 1:
- Current: [Belief] - [[Note]], [Date]
- Historical: [Contradicting evidence] - [[Note]], [Date]
- Type: [Self-contradiction/Abandoned/Unearned/etc.]
- Gap: [Time between positions]
- Explicitly resolved? [Yes/No]
```

### Step 3: Structure Challenges

For each tension, document systematically.

**Challenge Format:**

**Current Position:**
[Statement of current belief with source]

**The Problem:**
[What the vault evidence reveals about this position]

**Vault Evidence:**
1. [Specific citation with date and quote]
2. [More evidence]
3. [More evidence]

**The Unresolved Question:**
[Genuine inquiry, not rhetorical]

**Severity:**
- **Crack:** Minor inconsistency, cosmetic
- **Tension:** Productive ambiguity or needs resolution
- **Foundation Risk:** Undermines larger framework

**Output:**
```
Challenge 1: [Topic]

Current Position:
"[Belief statement]" - [[Note]], YYYY-MM-DD, marked [solid]

The Problem:
Your vault shows [contradiction pattern]. While you now state [X], your actual behavior/past statements suggest [Y].

Vault Evidence:
1. YYYY-MM-DD: "Quote showing Y" - [[Note]]
2. YYYY-MM-DD: Decision to [action reflecting Y] - [[Note]]
3. YYYY-MM-DD: "Quote contradicting X" - [[Note]]

The Unresolved Question:
Which is actually true? [Genuine question based on evidence]

Severity: Tension
- This requires resolution but isn't urgent
- Could inform [strategic decision area]
```

### Step 4: Synthesize

Identify meta-patterns and suggest resolution actions.

**Meta-Patterns Across Challenges:**
- Domain-specific blindness (only in work notes, not personal)
- Temporal patterns (beliefs change seasonally)
- Compartmentalization (different contexts, different beliefs)
- Confidence inflation (upgrading without cause)

**Most Uncomfortable Question:**
The single question worth facing based on evidence.

**Concrete Resolution Actions:**

**Conversations:**
- Who to talk to about this tension?
- What perspective would help?

**Experiments:**
- What test would resolve this?
- What outcome would prove X or Y?

**Note Refinement:**
- Which notes need updating?
- Where to acknowledge the shift?
- How to mark unresolved tensions?

**Output:**
```
Meta-Patterns:

Pattern 1: [Description]
- Visible in challenges: [#1, #3, #5]
- Suggests: [Insight about thinking pattern]

Pattern 2: [Description]
[Continue...]

Most Uncomfortable Question:
[The question you've been avoiding, grounded in vault evidence]

Recommended Actions:

Conversations:
1. Talk to [Person] about [Tension #X] - they have experience with [related area]

Experiments:
1. Test [Belief] by [specific action] - outcome will resolve [Tension #Y]

Note Refinement:
1. Update [[Note]] to acknowledge shift from [old] to [new]
2. Mark [[Note]] with [questioning] instead of [solid] until [resolved]
```

## Complete Output Format

### Beliefs Under Scrutiny

[List from Step 1]

---

### Challenges

[For each challenge, use format from Step 3]

---

### Synthesis

**Meta-Patterns:** [From Step 4]

**Most Uncomfortable Question:** [From Step 4]

**Recommended Actions:** [From Step 4]

## Key Principles

**1. Cite Specific Evidence:**
- Every challenge must have specific note names and dates
- Vague challenges ("you seem inconsistent") lack utility
- Quotes strengthen challenges

**2. Avoid Rhetorical Questions:**
- Frame genuine inquiries
- "Which is true?" not "Aren't you contradicting yourself?"

**3. Challenge Only with Evidence:**
- Don't challenge what vault doesn't contradict
- Fabricated tensions are unhelpful

**4. Distinguish Evolution from Confusion:**
- Temporal analysis: Did thinking evolve intentionally?
- Growth vs. inconsistency

**5. Flag Compartmentalization:**
- Different contexts may warrant different stances
- But unacknowledged compartments are blind spots

## Constraints

- Minimum 3 vault citations per challenge
- Temporal span of evidence noted
- Distinguish rhetorical questions from genuine inquiries
- Severity rating required for each challenge
- Meta-pattern analysis mandatory
- At least one recommended action per challenge

## Execution

You should:
1. Search with grep/ripgrep for all beliefs about the topic (or recent beliefs if general)
2. Search historical vault for contradicting evidence
3. Structure challenges with specific citations
4. Identify meta-patterns
5. Surface most uncomfortable question
6. Suggest resolution actions

**Remember:** The goal is productive discomfort, not guilt. Challenge to clarify, not to criticize.
