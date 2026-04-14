# Compare Temporal

Show how accumulated context improves answers over time.

## Core Concept

Answer single question three times from different vault periods:
- **Early** - Minimal relevant context
- **Middle** - Inflection point where context roughly doubled
- **Present** - Full accumulated knowledge

**Goal:** Isolate how "context compounds over time" by holding question and answer length constant while varying available information.

## Seven-Step Process

### Step 0: Validate Question

**Suitable:** Depends on personal context (hiring, strategy)
**Unsuitable:** Stable answers regardless of background

### Step 1: Map Vault's Temporal Shape

Use daily note density, context file timelines, backlink patterns, modification dates to establish when relevant material accumulated.

### Step 2: Select Three Periods

At inflection points where "relevant context roughly doubled," not fixed intervals.

### Step 3: Inventory Context

Exactly what exists in each period—daily notes, context files, essays—with specific counts of "relevant data points."

### Step 4: Record Predictions

Before generating answers, prevent post-hoc rationalization.

### Step 5: Generate Three Answers

**Constraints:**
- Hard context boundaries (no knowledge leakage)
- Equal length (within 20%)
- Consistent voice
- Sourced claims tagged [VAULT: note, date]

### Step 6: Anachronism Checks

Catch temporal contamination, compare actual vs. predicted improvements.

### Step 7: Score Answers

Four dimensions:
- Specificity
- Actionability
- Personal relevance
- Cross-domain connections

## Anti-Patterns

- Confusing length with quality
- Knowledge leakage between periods
- Fabricated compounding
- Deliberately weak early answers
- Treating answers as vault summaries
- Uncritical celebration of trivial improvements

**Note:** Null results (answers don't meaningfully improve) are valid findings.

Interact with the vault via the `vault` skill — `vault temporal-inventory {vault-path} [--since <date>] [--until <date>]` — to build a chronological mention timeline (returns TSV: `date`, `file`, `doctype`, `status`, `word_count`). Filter results for the target term and synonyms. Supplement with file system operations: walk directory trees, read files by path, and search file contents with grep/ripgrep.
