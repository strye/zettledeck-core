# Synthesize Perspective

Generate third-person portrait of yourself as a stranger would see you through your vault.

## Core Purpose

Create external perspective—how someone reading your vault without knowing you would describe you. This is structural and thematic analysis that reveals character through evidence.

**Key Requirements:**
- Every claim traces to specific vault evidence
- At least one uncomfortable observation
- At least one admiring observation
- No flattery, therapy-speak, or diplomatic hedging
- Perceptive, unflinching observation from stranger with no stake

## Four-Phase Process

### Phase 1: Structural Mapping

Analyze vault architecture before content.

**Method:**
- Walk the vault root directory to list top-level folders
- Run `vault link-graph {vault-root}` to identify highly connected vs. isolated notes (TSV: source, target, weight)
- Run `vault stats {vault-root}` for total file counts and structural overview
- Read frontmatter tags from a sample of notes to understand tag distributions

**Record:**
- Total notes
- Link patterns (highly connected vs. isolated)
- Folder hierarchies
- Tag distributions
- Connectivity gaps

### Phase 2: Content Ingestion

Read systematically across three domains:

**1. Context Files** - Stated priorities
**2. Daily Notes** - Actual behavior
**3. Essays** - Formalized thinking

**Plus:** Follow 5 most-linked notes (from link-graph output) to understand gravitational centers.

### Phase 3: Seven Mandatory Analyses

**1. Topic Frequency Map:**
- Rank topics 10-15 deep
- Distinguish lived vs. theorized

**2. Stated vs. Revealed Priorities:**
- Chart gaps between declared and demonstrated focus

**3. Emotional Frequency:**
- Track dominant emotions and triggers

**4. Relationship Map:**
- Map social world as vault reveals it

**5. Recurring Questions:**
- Distinguish curiosity (once) from obsession (repeated)

**6. Writing Style:**
- Document patterns, vocabulary, metaphors, what's unsaid

**7. Conspicuous Absences:**
- Identify what should appear but doesn't

### Phase 4: Five-Section Portrait

**Section 1: First Impression (2-3 paragraphs)**
Dominant energy and immediate personality

**Section 2: What They Actually Care About**
Gravitational centers revealed by evidence distribution

**Section 3: What They Are Building Toward**
Life trajectory inferred from context and daily notes

**Section 4: The Patterns They Cannot See**
Minimum: 2+ uncomfortable observations + 2+ admiring ones
- Contradiction patterns
- Avoidance patterns
- Repetition patterns
- Projection patterns
- Narrative patterns
- Blind spot patterns

**Section 5: The Unasked Question (second person only)**
A genuine, unasked question the vault evidence points toward

## Complete Output Format

### First Impression

[2-3 paragraphs describing dominant energy, immediate personality, first-read vibe]

---

### What They Actually Care About

[Gravitational centers by evidence density, not stated priority]

**By the numbers:**
- [Topic A]: [X] notes, [Y] diary mentions, [Z] hours (if measurable)
- [Continue for top 5...]

**What this reveals:** [Interpretation]

---

### What They Are Building Toward

[Life trajectory inferred from patterns]

[Based on evidence, where is this person heading? What are they constructing? What future do vault patterns suggest?]

---

### The Patterns They Cannot See

**Uncomfortable Observations:**

**1. [Pattern Name]**
Evidence: [Specific notes, dates, quotes]
Interpretation: [What this suggests they're missing]

**2. [Pattern Name]**
[Same structure]

**Admiring Observations:**

**1. [Pattern Name]**
Evidence: [Specific notes, dates, quotes]
Interpretation: [What this reveals about strengths]

**2. [Pattern Name]**
[Same structure]

---

### The Unasked Question

[Shift to second person]

[A genuine question the vault evidence points toward that you haven't explicitly asked yourself. Must be grounded in patterns observed above.]

## Constraints

- Every claim must cite specific vault evidence
- Minimum 2 uncomfortable + 2 admiring observations
- Avoid: flattery, therapy-speak, summaries, generics, judgment, diplomatic hedging
- Feel like perceptive observation from stranger with no stake
- Final question must be second person, unasked, evidence-grounded

## Execution

You should:
1. Map vault structure using `vault link-graph` and `vault stats`; walk directories for folder layout and tag patterns
2. Read context files, daily notes, essays, and top 5 hub notes by path
3. Complete all 7 mandatory analyses
4. Write 5-section portrait with evidence citations
5. Include minimum 2 uncomfortable + 2 admiring observations
6. End with unasked question in second person

**Remember:** Be perceptive and unflinching. The value is in seeing what the person can't see about themselves.
