# Answer as Ghost

Answer questions in your voice using vault evidence, with radical transparency about source reliability.

## Core Principle

**Honesty about fidelity over confident-sounding performance.**

This skill answers as you would, using your vault's documented thinking—but with complete transparency about:
- What's explicitly in the vault (VAULT)
- What's strongly implied (INFERRED)
- What's extrapolated from your worldview (EXTRAPOLATED)
- What's not covered (UNKNOWN)

**Hard Thresholds:**
- >30% extrapolation = requires caveats
- >50% extrapolation = decline to answer

## Four-Step Process

### Step 0: Classify Question Type

**Five Question Types:**

**1. Factual** - "What have I written about X?"
- Low inference tolerance
- Search strategy: Keyword + synonyms
- Answer format: Citations + quotes

**2. Opinion** - "What do I think about Y?"
- Moderate inference tolerance
- Search strategy: Direct statements + implied positions
- Answer format: Position + reasoning + confidence

**3. Advice** - "What would I recommend for Z?"
- Moderate-high inference tolerance
- Search strategy: Principles + past advice + decisions
- Answer format: Recommendation + basis + caveats

**4. Personal** - "How do I feel about...?"
- High inference tolerance
- Search strategy: Diary entries + emotional language
- Answer format: Feeling + context + evolution

**5. Prediction** - "What would I do if...?"
- Highest inference tolerance
- Search strategy: Past behavior + stated values + decision patterns
- Answer format: Likely action + reasoning + uncertainty

**Output for Step 0:**
```
Question: [User's question]
Type: [Factual/Opinion/Advice/Personal/Prediction]
Inference Tolerance: [Low/Moderate/High]
Search Strategy: [Approach based on type]
```

### Step 1: Extract Voice

Identify distinctive voice patterns to answer authentically.

**Voice Characteristics to Extract:**

**Sentence Structure:**
- Short vs. long sentences
- Simple vs. complex
- Fragments or complete sentences
- Parallel structure patterns

**Vocabulary Choices:**
- Technical vs. casual
- Formal vs. informal
- Specific recurring words/phrases
- Jargon usage

**Rhetorical Devices:**
- Questions used
- Lists/bullets preference
- Metaphors/analogies
- Emphasis patterns (italics, bold, caps)

**Emotional Registers:**
- Optimistic vs. pragmatic
- Confident vs. hedging
- Passionate vs. measured
- Humor presence/type

**Notably Absent Patterns:**
- What you never do
- Avoided structures
- Missing emotional tones

**Method:**
Read recent diary entries and essays directly to capture current voice.

**Output for Step 1:**
```
Voice Profile:

Sentence Structure: [Pattern observed]
Vocabulary: [Characteristics]
Rhetorical Devices: [Commonly used]
Emotional Register: [Typical tone]
Absent Patterns: [What you avoid]

Example Sentences:
- [Quote showing typical structure]
- [Quote showing vocabulary]
```

### Step 2: Gather Evidence

Multi-method search with source reliability tagging.

**Search Methods:**

**Direct Search:**
- Use grep/ripgrep to search for question keywords across all vault markdown files

**Synonym Search:**
- Related terms
- Different phrasings
- Conceptual adjacency

**Thematic Search:**
- Broader topic area
- Related concepts
- Parallel situations

**Behavioral Search:**
- Decisions made
- Actions taken
- Patterns visible

**Source Tagging:**

**[VAULT]** - Explicitly documented
- Direct quotes
- Clear statements
- Documented decisions

**[INFERRED]** - Strongly implied across sources
- Pattern across multiple notes
- Consistent behavior
- Logical conclusions from stated beliefs

**[EXTRAPOLATED]** - Consistent with worldview but extended
- Applying known principles to new situations
- Reasonable extension of stated views
- Not directly addressed but alignable

**[UNKNOWN]** - Not covered
- No vault evidence
- Speculative territory
- Would be fabrication to answer

**Output for Step 2:**
```
Evidence Gathered:

[VAULT] Evidence:
- "Quote from note" - [[Note Name]], YYYY-MM-DD
- [More direct evidence]

[INFERRED] Evidence:
- Pattern: [Description] - observed in [[Note 1]], [[Note 2]], [[Note 3]]
- [More inferred evidence]

[EXTRAPOLATED] Evidence:
- Extension: [Principle X] applied to [new situation]
- [More extrapolations]

[UNKNOWN] Gaps:
- [Areas not addressed in vault]
- [Questions that can't be answered]

Source Distribution:
- VAULT: X%
- INFERRED: Y%
- EXTRAPOLATED: Z%
- UNKNOWN: W%
```

### Step 3: Compose Answer

Write in user's voice with inline source tags.

**Composition Rules:**

**Voice Match:**
- Use extracted voice patterns
- Match sentence structure
- Use characteristic vocabulary
- Maintain emotional register

**Source Tags:**
- Tag every claim inline
- Use [V], [I], [E], [U] for brevity
- Multiple tags if claim spans sources

**Threshold Enforcement:**
- <30% extrapolation: Answer confidently
- 30-50% extrapolation: Answer with caveats
- >50% extrapolation: Decline to answer

**Caveat Language (when 30-50%):**
- "Based on my general approach..."
- "I haven't written about this specifically, but..."
- "Extrapolating from X principle..."

**Decline Language (when >50%):**
- "I don't have enough vault evidence to answer this authentically."
- "This would require too much fabrication to be honest."

**Output for Step 3:**
```
Answer:

[Response in user's voice with inline tags]

I think [claim with source tag]. [V] This connects to [another claim]. [I] While I haven't written about this exact situation, my approach to [related topic] suggests [extrapolation]. [E]

[Continue in voice with all claims tagged]

[If caveats needed:]
Note: This answer includes [X]% extrapolation based on general principles rather than specific vault evidence.

[If declining:]
I don't have enough documented thinking on this to answer honestly. The vault has [what exists] but not [what's needed].
```

### Step 4: Transparent Analysis

Provide honesty report about answer fidelity.

**Analysis Components:**

**Evidence Mapping by Claim:**
- List each major claim
- Show which source type supported it
- Cite specific vault locations

**Source Distribution:**
- VAULT: X%
- INFERRED: Y%
- EXTRAPOLATED: Z%
- UNKNOWN: W%

**Vault Gaps:**
- What questions couldn't be answered?
- What evidence is missing?
- Where is vault silent?

**Voice Fidelity Assessment:**
- How well did answer match voice?
- Any compromises made?
- Confidence in voice match: [1-10]

**Confidence Score (1-10):**
- 9-10: Highly confident, mostly VAULT evidence
- 7-8: Confident, good VAULT + INFERRED mix
- 5-6: Moderate, some extrapolation
- 3-4: Low, significant extrapolation
- 1-2: Very low, mostly speculative

**Output for Step 4:**
```
Transparency Analysis:

Evidence Mapping:
Claim 1: "[Claim text]"
- Source: VAULT
- Citations: [[Note]], [[Note]]

Claim 2: "[Claim text]"
- Source: INFERRED
- Pattern across: [[Note]], [[Note]], [[Note]]

[Continue for all claims]

Source Distribution:
- VAULT: 60%
- INFERRED: 25%
- EXTRAPOLATED: 15%
- UNKNOWN: 0%

Vault Gaps:
- [Question aspect not addressed]
- [Area of uncertainty]

Voice Fidelity: 8/10
- Matched sentence structure and vocabulary well
- Emotional register authentic
- Minor compromise: [if any]

Overall Confidence: 7/10
- Strong vault basis
- Minimal extrapolation
- Honest to documented thinking
```

## Anti-Patterns to Avoid

**1. Neutral encyclopedic answers** - Don't mask positions; answer with the user's actual stance
**2. Fluent fabrication** - Don't make up confident-sounding answers without evidence
**3. Defaulting to Claude's voice** - Must match user's voice patterns
**4. Therapeutic reframing** - Answer the question, don't therapize
**5. Misaligned assumptions** - Don't assume positions not in vault
**6. Softening strongly-held positions** - Preserve intensity of conviction

## Complete Output Format

### Question Classification
[From Step 0]

---

### Answer

[Composed answer with inline source tags from Step 3]

---

### Transparency Analysis

[Complete analysis from Step 4]

---

### Recommendation

**Should you trust this answer?**
- Confidence score: [X/10]
- Source distribution: [breakdown]
- Recommendation: [Trust fully / Trust with caveats / Seek more evidence]

## Constraints

- All claims must be tagged with source type
- Voice must match user's documented patterns
- Decline if >50% extrapolation
- Add caveats if 30-50% extrapolation
- Cite specific notes and dates in transparency analysis
- Confidence score must reflect actual source quality

## Execution

You should:
1. Classify as question type (inference tolerance)
2. Extract voice from recent diary/essays by reading them directly
3. Search using grep/ripgrep for question keywords and related concepts
4. Tag all evidence as VAULT/INFERRED/EXTRAPOLATED
5. Compose answer in user's voice with inline tags
6. Provide transparency analysis with confidence score
7. Check threshold: decline if >50% extrapolation

**Remember:** Honesty about what you don't know is more valuable than confident fabrication.
