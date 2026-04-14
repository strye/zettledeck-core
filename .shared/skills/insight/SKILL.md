---
name: insight
description: Vault intelligence — surface what your accumulated knowledge is pointing toward. Discover implicit ideas, assess execution readiness, identify high-leverage skills, scan knowledge depth, and demonstrate how context compounds over time. For self-reflection, belief pressure-testing, and voice-based answers, use the reflection skill. For knowledge base management and vault topology, use the nexus skill.
author: Will Strye
---

# insight

Surface what your vault is pointing toward — the ideas, depth gaps, and leverage points that your accumulated knowledge implies but hasn't stated.

## Modes

| Mode | Description | Invocation |
|------|-------------|------------|
| `ideate` | Surface implied ideas and generate new ones across workspace folders | `/insight ideate [role ...]` |
| `score` | Assess execution readiness of accumulated ideas — 4-dimension scoring | `/insight score` |
| `learn` | Find 3-7 high-leverage skills where 50-100hr investment produces step-function returns | `/insight learn` |
| `scan` | Survey knowledge depth across all domains — produces compound depth map | `/insight scan [domain ...]` |
| `temporal` | Show how accumulated context improves answer quality over time | `/insight temporal "question"` |
| `orient` | Systematically read the vault to build deep context before starting work | `/insight orient [scope]` |

## Invocation Examples

```
/insight ideate
/insight ideate jots
/insight ideate jots ideation documentRepo
/insight score
/insight learn
/insight scan
/insight scan "S03_Cloud_Architecture"
/insight scan "S03_Cloud_Architecture" "S07_AI_Strategy"
/insight temporal "How should I approach hiring?"
/insight orient
/insight orient S03_Cloud_Architecture
```

When invoked without arguments, display the mode table and ask which mode the user wants.

## Routing

On invocation, identify the requested mode and load the corresponding resource file:

| Mode | Resource |
|------|----------|
| `ideate` | `resources/ideate.md` |
| `score` | `resources/score.md` |
| `learn` | `resources/learn.md` |
| `scan` | `resources/scan.md` |
| `temporal` | `resources/temporal.md` |
| `orient` | `resources/orient.md` |

Read the resource file, then execute the workflow described within it. Pass through any arguments the user provided (role names, domain names, questions, etc.).

## Shared Dependencies

**File System (primary tool):**
All modes interact with the vault via the file system. Use standard tools to read, search, and walk vault directories:
- Read files directly by path
- Walk directory trees to inventory structure
- Search file contents with grep/ripgrep for keyword patterns
- Extract frontmatter from markdown files as needed

**Vault Scripts (via `vault` skill):**
- `vault link-graph {vault-root}` — wikilink graph (TSV: source, target, weight)
- `vault temporal-inventory {vault-root}` — time-ordered file inventory (TSV: date, file, doctype, status, word_count)
- `vault stats {vault-root}` — structural statistics

**Key Vault Paths (placeholders):**
- Ruthless Priorities: `{rp-path}/ruthless-priorities.md`
- Daily Diary: `{diary-path}/YYYY/MMM/YYYY-MM-DD_{Day}.md`
- Actions Dashboard: `{actions-path}/`

**Workspace Config:**
- `ideate` reads `workspaceFolders` from `.zettledeck/core/config.json` to resolve role → folder path

## Vault Structure Context

Shared across all modes:
- **Scopes:** `S{ID}_{Title}/` — Major life/work domains
- **Projects:** `P{ID}_{Title}/` — Multi-step outcomes
- **Content:** `C{ID}_{Title}.md` — Notes, ideas, artifacts
- **Daily Diary:** `{diary-path}/YYYY/MMM/YYYY-MM-DD_{Day}.md`
- **Ruthless Priorities:** `{rp-path}/ruthless-priorities.md`

## Mode Details

### ideate

Surface ideas already implicit in workspace patterns and generate new ideas grounded in vault evidence. Each output item is tagged **surfaced** (already implied by the evidence) or **generated** (synthesized from patterns). Accepts optional role arguments to scope analysis to specific workspace folders; defaults to all enabled folders.

**Full instructions:** Load `resources/ideate.md`

**Process:** Five phases — scope resolution, structural analysis (vault link-graph + stats), content analysis (5 detection methods), pattern synthesis, idea production with surfaced/generated tagging.

**Output:** Scope summary, patterns identified, 3-5 tagged ideas with Impact×Novelty scoring, highest-leverage opportunity, near-term activation plan, conspicuous absences.

---

### score

Find ideas in the vault that have accumulated enough depth and originality to become real work. Score readiness across four dimensions and suggest natural output forms.

**Full instructions:** Load `resources/score.md`

**Process:** Eight-step detection (Density, Originality, Narrative, Tension, Resonance, Cross-Reference, Scoring, Form Assessment).

**Output:** Candidates with readiness scores and tiers, form suggestions, strongest candidate, surprising finding, thematic threads, conspicuous absences.

---

### learn

Find 3-7 high-leverage skills where 50-100 hours of investment produces step-function returns across 3+ domains simultaneously.

**Full instructions:** Load `resources/learn.md`

**Process:** Five phases — Constraint Mapping, Leverage Detection (6 methods), Beyond the Vault, Verification (6 filters), ranked leverage map output.

**Output:** Ranked map of 3-7 skills with constraint addressed, domains unlocked, counterfactual impact, development path, and confidence level.

---

### scan

Survey knowledge depth across all vault domains to produce a **compound depth map** — a ranked portfolio view of where context has genuinely accumulated and where it remains shallow.

**Full instructions:** Load `resources/scan.md`. Also load `resources/temporal.md` — scan uses the temporal methodology as its analytical engine for per-domain probing.

**Process:** Six phases — inventory scannable domains, map vault's temporal shape, run condensed temporal probe per domain, synthesize depth map ranked by compounding rate, produce prioritized recommendations, offer to file.

**Parameters:** No arguments = full vault scan. One argument = single domain deep scan. Multiple arguments = subset scan with cross-domain relationship analysis.

**Output:** Ranked domain depth map, pattern analysis, strategic gap analysis against ruthless priorities, prioritized recommendations (Invest / Synthesize Now / Let Mature / Start Here / Reconsider).

---

### temporal

Demonstrate how accumulated context improves answer quality over time. Pose a single question, receive three answers from different vault periods (early/middle/present) showing how context compounds.

**Full instructions:** Load `resources/temporal.md`

**Process:** Seven steps — validate question, map vault's temporal shape, select three periods at inflection points, inventory context, record predictions, generate three answers with hard context boundaries, anachronism checks, score answers.

**Output:** Three period-bounded answers with source tags, scoring comparison, and compounding analysis. Null results (answers don't meaningfully improve) are valid findings.

---

### orient

Systematically read the vault to build deep context before starting work. Eliminates the need for basic clarifying questions. No praxis dependencies — operates purely on vault content.

**Full instructions:** Load `resources/orient.md`
