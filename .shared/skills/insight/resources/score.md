# Score Idea Readiness

Find ideas in the vault that have accumulated enough depth and originality to become real work.

## Core Question

**"Could someone draft something today from what exists?"**

This mode identifies ideas ready to transition from internal thinking to external creation. An idea is "ready" when it has accumulated sufficient material in the vault to sustain a real work—not when it's perfect, but when it has enough substance to begin execution.

## Valid Signals

Look for these indicators of readiness:

- **Sustained Attention:** 10+ mentions across 5+ days minimum
- **Divergent Thinking:** Perspectives that differ from mainstream consensus
- **Documented Change:** Before/after captured over time
- **Living with Ambiguity:** Vault contains substance on multiple sides of a tension
- **Verified External Interest:** Evidence others care ("people keep asking", conversation notes)

## Eight-Step Detection Process

### Step 1: Density Detection

Find topics with accumulated thinking over time.

**Criteria:**
- 10+ mentions minimum
- Across 5+ days minimum
- Distributed across multiple note types (diary, projects, content)

**Method:**
- Use grep/ripgrep to search for topic mentions across all vault markdown files; count occurrences and note which files they appear in
- Run `vault link-graph {vault-root}` and filter by target to find inbound link density for a given note

**Look for:**
- Topics that keep coming up
- Ideas referenced across different scopes
- Themes that persist over weeks/months

### Step 2: Originality Detection

Surface perspectives that diverge from mainstream consensus, backed by direct experience.

**Criteria:**
- Challenges conventional wisdom
- Grounded in your actual experience (not just theory)
- Shows unique angle or insight

**Method:**
- Search for phrases like "most people think... but" or "conventional wisdom says... however"
- Look for diary entries documenting direct experience
- Find notes where you've explicitly disagreed with common approaches

**Warning:** Generic contrarian takes don't count. Must be original insight backed by experience.

### Step 3: Narrative Detection

Identify stories with documented arcs captured over time.

**Criteria:**
- Before/after states documented
- Challenge -> Resolution documented
- Change captured across multiple diary entries

**Method:**
- Review diary entries for temporal narratives
- Look for project retrospectives
- Find notes documenting transformation

**Examples:**
- "How I went from X to Y over 6 months" (documented in diary)
- "The problem that wouldn't go away until I tried Z" (captured in real-time)

### Step 4: Tension Detection

Locate unresolved questions where the vault contains substance on multiple sides.

**Criteria:**
- Vault has notes exploring 2+ opposing perspectives
- You've genuinely explored both sides
- Tension is productive, not just confusion

**Method:**
- Search for "on the other hand", "however", "tension between"
- Find notes tagged with conflicting stances
- Look for diary entries wrestling with paradoxes

**Value:** These make the most intellectually honest work—you've lived with the complexity.

### Step 5: Resonance Detection

Find evidence others care about this topic.

**Criteria:**
- "People keep asking me about X"
- Conversations where others engaged deeply
- External requests or questions

**Method:**
- Review meeting notes for repeated questions
- Check for notes like "third person this week asked about..."
- Search diary entries for mentions of others' interest

**Warning:** Don't confuse polite interest with genuine resonance. Look for multiple, independent instances.

### Step 6: Cross-Reference

Check against published work and prior runs to avoid duplication.

**Steps:**
1. Search vault for any published content on this topic
2. Check for previous `/insight score` outputs
3. If topic appeared before, has it accumulated new material since?
4. Merge signals across all detection methods for each candidate

### Step 7: Scoring

Rate each candidate across four dimensions (1-5 each):

**Depth (1-5):**
- 1: Shallow, few mentions
- 3: Solid exploration, 10+ mentions
- 5: Extensively developed, 20+ mentions, multiple perspectives

**Originality (1-5):**
- 1: Conventional wisdom restated
- 3: Fresh angle on known topic
- 5: Genuinely novel insight backed by experience

**Clarity (1-5):**
- 1: Confused, contradictory, unclear
- 3: Core idea is clear, details need work
- 5: Crystal clear thesis, well-articulated

**Urgency (1-5):**
- 1: No time pressure, can sit indefinitely
- 3: Would be valuable to capture now
- 5: Losing relevance if not captured soon, or people are actively asking

**Total Score:** Sum of all four (max 20)

**Readiness Tiers:**
- **16-20:** Ready to execute now
- **12-15:** Close, needs minor development
- **8-11:** Has potential, needs significant work
- **Below 8:** Not ready

### Step 8: Form Assessment

For candidates scoring 12+, suggest 2-3 natural formats.

**Possible Forms:**
- **Essay** (1,000-3,000 words) - For developed arguments
- **Post** (300-800 words) - For single insights
- **Thread** (10-20 tweets) - For narratives or step-by-step
- **Documentary** - For stories with visual/interview elements
- **Podcast Episode** - For conversations or interviews
- **Course/Workshop** - For teaching accumulated knowledge
- **Fiction** - For themes best explored through story
- **Series** - For topics too large for single piece

**For each suggested form:**
- **Why this form:** Explain why it fits the material
- **What exists:** What vault content would directly feed this
- **What's missing:** Gaps to fill before execution
- **Trade-offs:** Pros and cons of this format

## Output Structure

### Candidates Identified

Brief summary of detection process:
- Density candidates: [count]
- Originality candidates: [count]
- Narrative candidates: [count]
- Tension candidates: [count]
- Resonance candidates: [count]
- After cross-reference: [final count]

---

### Readiness Scores

For each candidate (ordered by total score):

**Idea:** [One-sentence description]

**Score:** [Total] (Depth: [X], Originality: [X], Clarity: [X], Urgency: [X])

**Tier:** Ready Now | Close | Has Potential

**Vault Evidence:**
- [Note/entry 1 with date]
- [Note/entry 2 with date]
- [Note/entry 3 with date]
- [Additional evidence...]

**Detection Methods:** [Which methods surfaced this: Density, Originality, Narrative, Tension, Resonance]

**Natural Forms:**
1. **[Format]** - Why: [explanation] | Exists: [vault content] | Missing: [gaps] | Trade-offs: [pros/cons]
2. **[Format]** - Why: [explanation] | Exists: [vault content] | Missing: [gaps] | Trade-offs: [pros/cons]

---

## Synthesis

### Strongest Candidate

**Idea:** [Top-scoring or most compelling]

**Why this is ready:** [Explanation of why this rises above others]

**Recommended form:** [Best format for this idea]

**Next step:** [Concrete first action to begin execution]

---

### Surprising Finding

[Something unexpected the analysis revealed—an idea you didn't realize was this developed, or a gap you didn't see]

---

### Thematic Threads

[Patterns across the candidates—do they cluster around certain themes? What does that suggest about current focus areas?]

---

### Conspicuous Absences

[What did you expect to find ready but wasn't? What areas have lots of mentions but low readiness scores? What does that suggest?]

## Constraints

- Only evaluate ideas with 10+ mentions across 5+ days
- Every candidate must pass "Could draft today?" test
- No generic or conventional wisdom (originality threshold)
- Include specific vault evidence (notes, dates, quotes)
- Cap at 10 candidates maximum (focus on quality)
- Minimum score of 8 to be included

## Execution

You should:
1. Run all 8 detection steps systematically
2. Score each candidate across 4 dimensions
3. Suggest natural forms for high-scoring ideas
4. Present findings ordered by readiness
5. Provide synthesis and next steps

**Remember:** This is about execution readiness, not idea quality. An idea can be brilliant but not ready (needs more development) or ready but not urgent (can wait). The goal is to find ideas where the vault has accumulated enough material to justify starting real work now.
