---
name: reflection
description: Self-reflection through vault evidence — answer questions in your documented voice, pressure-test beliefs against vault history, surface generative contradictions, and generate third-person portraits revealing character through evidence. For forward-looking analysis (ideas, skill leverage, knowledge depth), use the insight skill.
author: Will Strye
---

# reflection

Understand who you are and how you think, as evidenced by your vault. Every mode reads what's already accumulated and shows you something about yourself you couldn't see without the analysis.

## Modes

| Mode | Description | Invocation |
|------|-------------|------------|
| `answer` | Answer a question in your documented voice with radical source transparency | `/reflection answer "question"` |
| `challenge` | Pressure-test beliefs against vault history — surfaces blind spots and unearned confidence | `/reflection challenge [topic]` |
| `synthesize` | Generate a third-person stranger portrait of the vault author | `/reflection synthesize` |
| `contradictions` | Surface generative contradictions — productive tensions worth holding, not resolving | `/reflection contradictions` |

## Invocation Examples

```
/reflection answer "What do I think about remote work?"
/reflection challenge
/reflection challenge "hiring"
/reflection synthesize
/reflection contradictions
```

When invoked without arguments, display the mode table and ask which mode the user wants.

## Routing

On invocation, identify the requested mode and load the corresponding resource file:

| Mode | Resource |
|------|----------|
| `answer` | `resources/answer.md` |
| `challenge` | `resources/challenge.md` |
| `synthesize` | `resources/synthesize.md` |
| `contradictions` | `resources/contradictions.md` |

Read the resource file, then execute the workflow described within it. Pass through any arguments the user provided (questions, topics, etc.).

## Shared Dependencies

**File System (primary tool):**
All modes interact with the vault via the file system. Use standard tools to read, search, and walk vault directories:
- Read files directly by path
- Walk directory trees to inventory structure
- Search file contents with grep/ripgrep for keyword patterns
- Extract frontmatter from markdown files as needed

**Vault Scripts (via `vault` skill):**
- `vault link-graph {vault-root}` — wikilink graph (TSV: source, target, weight); used by `synthesize`
- `vault stats {vault-root}` — structural statistics; used by `synthesize`

**Key Vault Paths (placeholders):**
- Ruthless Priorities: `{rp-path}/ruthless-priorities.md`
- Daily Diary: `{diary-path}/YYYY/MMM/YYYY-MM-DD_{Day}.md`

**MCP Servers (optional):**
- `aws-outlook-mcp` — calendar event analysis; used by `align` for drift detection

## Vault Structure Context

Shared across all modes:
- **Scopes:** `S{ID}_{Title}/` — Major life/work domains
- **Projects:** `P{ID}_{Title}/` — Multi-step outcomes
- **Content:** `C{ID}_{Title}.md` — Notes, ideas, artifacts
- **Daily Diary:** `{diary-path}/YYYY/MMM/YYYY-MM-DD_{Day}.md`
- **Ruthless Priorities:** `{rp-path}/ruthless-priorities.md`

## Mode Details

### answer

Answer a question in your documented voice using vault evidence, with radical transparency about source reliability. Every claim is tagged VAULT / INFERRED / EXTRAPOLATED / UNKNOWN. Declines to answer if >50% of the response would require extrapolation.

**Full instructions:** Load `resources/answer.md`

**Process:** Four steps — classify question type (5 types, each with different inference tolerance), extract voice profile, gather evidence with source tagging, compose answer with inline tags, transparent analysis with confidence score.

**Output:** Question classification, voiced answer with inline source tags, transparency analysis (source distribution, vault gaps, voice fidelity), trust recommendation.

---

### challenge

Pressure-test beliefs against vault history by finding contradictions, abandoned positions, and unexamined assumptions. Surfaces self-contradictions, unearned confidence, and blind spots with specific vault evidence.

**Full instructions:** Load `resources/challenge.md`

**Process:** Four steps — identify beliefs (search for confident assertions, problem diagnoses, value statements), find contradictions (6 types: self-contradiction, abandoned positions, unearned confidence, wishful thinking, blind spots, stale thinking), structure challenges with severity ratings, synthesize meta-patterns.

**Output:** Beliefs under scrutiny, structured challenges with vault evidence, meta-patterns, most uncomfortable question, recommended actions.

---

### synthesize

Generate a third-person portrait of the vault author as a stranger would perceive them — structural and thematic analysis revealing character through evidence, not assumption. Unflinching; no flattery or diplomatic hedging.

**Full instructions:** Load `resources/synthesize.md`

**Process:** Four phases — structural mapping (vault link-graph, stats, folder layout), content ingestion (context files, daily notes, essays, top 5 hub notes), seven mandatory analyses (topic frequency, stated vs. revealed priorities, emotional frequency, relationship map, recurring questions, writing style, conspicuous absences), five-section portrait.

**Output:** First impression, what they actually care about, what they're building toward, patterns they cannot see (2+ uncomfortable + 2+ admiring), the unasked question (second person).

---

### contradictions

Surface **generative** contradictions — productive tensions in the vault worth holding rather than resolving. Uses a "worth holding" filter, classifies as Hold or Celebrate only (no Resolve), and assigns a weight rating.

**Full instructions:** Load `resources/contradictions.md`

**Distinction from other modes:**
- **`nexus lint` Phase 2c** — resolve-class contradictions (confused thinking, stale data, conflicts needing cleanup)
- **`reflection challenge`** — pressure-tests a specific belief through counter-evidence
- **`reflection contradictions`** — broad-scan for productive tensions worth sitting with
- **`nexus trace`** — shows how one idea evolved (may reveal a contradiction is an arc in disguise)

**Process:** Five steps — belief extraction, three detection methods (explicit / implicit / priority), "worth holding" filter (compartmentalization, load-bearing tension, evidence of growth, generative friction), classification (Hold/Celebrate + weight), structured output.

**Output:** Contradictions with belief statements, dated citations, logical incompatibility explanation, category, weight, and what the tension generates.

---

