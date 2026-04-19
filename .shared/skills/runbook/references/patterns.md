# Execution Patterns

Predefined templates for common runbook shapes. Select one during `/runbook new` as a starting point.

## Triage

Fetch data, classify it, produce a working file for user review, then execute user-annotated actions.

**Shape:** Gather → Classify → Write working file → ⏸ Checkpoint → Execute actions → Report

**Example:** Email triage — fetch unread emails, classify by priority, write triage file, user reviews/annotates, execute archive/delete/task actions.

**Flows:**
1. `gather` (sequential) — Fetch source data
2. `classify` (sequential) — Categorize items, extract actions
3. `present` (sequential) — Write working file for user review, checkpoint
4. `execute` (sequential) — Process user-annotated instructions from working file

**Key traits:**
- Always has a checkpoint between classify and execute
- Working file is the user's control surface
- Execute flow reads the working file for instructions

---

## Generate

Gather inputs from one or more sources, produce output file(s).

**Shape:** Gather inputs → Process → Write output(s) → Report

**Example:** Weekly diary view — read daily files, extract meetings/actions, build consolidated weekly file.

**Flows:**
1. `gather` (sequential or parallel) — Collect inputs from multiple sources
2. `build` (sequential) — Assemble output from gathered data
3. `write` (sequential) — Create/update output file(s)

**Key traits:**
- No checkpoint needed (output is the deliverable)
- Gather flow may parallelize across independent sources
- Idempotent — safe to re-run

---

## Transform

Read source material, process/convert it, write to destination.

**Shape:** Read source → Transform → Write destination → Report

**Example:** Meeting summary import — read summary emails, extract content, insert into diary files.

**Flows:**
1. `read` (sequential or parallel) — Read source(s)
2. `transform` (sequential) — Process/convert content
3. `write` (sequential or parallel) — Write to destination(s)

**Key traits:**
- Source and destination are different files/locations
- Transform logic is the core value
- May parallelize read and write across independent items

---

## Pipeline

Multi-stage processing where output of one stage feeds the next, with optional parallel branches.

**Shape:** Stage 1 → Stage 2 → [Stage 3a ∥ Stage 3b] → Stage 4 → Report

**Example:** Account review — pull spend data, pull opportunity data (parallel), merge into review document, checkpoint for user review, finalize.

**Flows:**
1. `stage-1` (sequential) — Initial processing
2. `stage-2a`, `stage-2b` (parallel) — Independent data gathering
3. `stage-3` (sequential) — Merge parallel results
4. `review` (sequential, checkpoint) — User review if needed
5. `finalize` (sequential) — Final output

**Key traits:**
- Explicit dependencies between stages
- Parallel branches for independent work
- May include checkpoints at review stages
