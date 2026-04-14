# Nexus Link — Strategic Connection Recommendations

Identify missing connections in the vault and recommend strategic links to improve graph traversability. Score each candidate across conceptual strength, structural impact, and priority alignment. Execute approved changes as metadata-only edits.

**Mode:** `link`

**Scope:** Vault-wide. Reads and (with user approval) modifies metadata in files across the Obsidian vault.

**Genesis:** Link does not usually create pages. When it does create stub pages, they are tagged `genesis: manual` (empty scaffolds for the user to fill).

## Core Principle

**"Your job is to make the graph traversable, not to generate understanding."**

Link focuses on structural connectivity — ensuring that related notes can be discovered through the graph. It does **not**:

- Synthesize content
- Create new insight from connections
- Fill empty hub notes with generated content
- Rewrite reasoning in source material

It **does**:

- Find orphaned notes that should be connected
- Bridge isolated clusters
- Resolve broken wikilinks (by creating empty stubs or flagging variants)
- Suggest backlinks based on conceptual strength
- Apply approved link additions as metadata-only edits to vault files

**Invocation:**

```
nexus link
```

## Workflow

### Phase 1: Structural Inventory

Scan the vault's connectivity landscape without deeply reading content. This is the same structural scan as `map` Phase 1, but the output is oriented toward identifying candidate connections rather than describing shape.

**What to check:**

- **Orphans** — notes with zero incoming or outgoing wikilinks
- **Dead ends** — notes with outgoing links but no incoming links
- **Unresolved links** — `[[...]]` references to notes that don't exist
- **Top hubs** — notes with many incoming wikilinks (potential MOCs)
- **Empty hubs** — hub notes that exist but have no content body

**Method:** Walk the vault directory, read each markdown file. Use the `vault` skill — `vault link-graph {vault-root}` — to build the link graph (returns TSV: `source`, `target`, `weight`). Identify the categories above from the graph.

**Output for Phase 1:**

```
Structural Overview:
- Orphans: {count} notes
- Dead ends: {count} notes
- Unresolved links: {count} instances
- Top hubs: {count} ({list top 5-10})
- Empty hubs: {count — flagged for awareness}
```

### Phase 2: Priority Context

Read recent context to establish what work is currently active. This is what filters recommendations to what matters *now*. A connection can be structurally sound but irrelevant if it's not aligned with current work.

**What to read:**

1. **Ruthless priorities** — always. Read `{rp-path}/ruthless-priorities.md`.
2. **Recent diary entries** — past 7 days. What projects are active? What topics keep coming up? What questions are being asked?
3. **Recent context files** — 5-6 files if they exist: weekly plans, project MOCs recently updated, active scope areas.

**Output for Phase 2:**

```
Priority Context:
- Ruthless Priorities: {list 1-3}
- Active Projects: {list}
- Active Topics: {list based on recent diary}
- Questions Being Asked: {unresolved topics from recent work}
```

### Phase 3: Orphan Rescue Scan

Assess isolated notes and determine which warrant connections.

**Prioritization:**

1. **Orphans matching current work** — highest priority
2. **Orphans containing questions** — questions suggest active thinking
3. **Recent orphans** (< 30 days old) — may not have been linked yet
4. **Older orphans** — may be legitimately archived or inactive

**Reading limit:** Cap at 100 notes total across all phases. Triage before reading — don't read every orphan, only the ones that match priority filters.

**For each candidate orphan:**
- Read the title and first few paragraphs
- Check if the topic relates to active work (Phase 2 context)
- If yes: identify 1-3 potential parent or sibling notes to connect to
- If no: skip or mark as low priority

**Output for Phase 3:**

```
Orphan Rescue Candidates: {count}

High Priority:
- [[Orphan note]]: Should link to [[parent note]] because {conceptual reason}

Medium Priority:
- [[Orphan note]]: Could link to [[sibling note]] because {thematic reason}

Low Priority / Skip:
- {count} orphans not aligned with current work
```

### Phase 4: Cluster Bridge Analysis

Find thematic connections between isolated clusters. This is where vocabulary variance gets surfaced — clusters often stay separate because the same idea is called by two different names.

**What to look for:**
- Groups of notes that reference each other but are disconnected from the main graph
- Topics described with different vocabulary (synonyms, old/new terms, formal/informal names, abbreviated/full names)
- Ideas that evolved under different names

**Example:**
- Cluster A talks about "focus time"
- Cluster B talks about "deep work"
- These are the same concept — should be bridged

**Method:** For each cluster identified in Phase 1, search for vocabulary variants in the rest of the vault. If another cluster uses a variant term, flag a bridge candidate.

**Output for Phase 4:**

```
Cluster Bridges: {count}

1. {Cluster A topic} ↔ {Cluster B topic}
   - Variant terms: "{focus time}" and "{deep work}"
   - Recommended bridge: Link [[Note A]] to [[Note B]]
   - Conceptual Strength: {score 1-5}
```

### Phase 5: Unresolved Link Triage

Evaluate broken wikilinks and decide what to do with each.

**Triage rules:**

**3+ citations** — warrants creating a stub note. Multiple places asking for this content. High priority.

**2 citations** — check for vocabulary variants first. It may already exist under a different name. Medium priority.

**1 citation** — only act if aligned with current priorities (Phase 2). Otherwise skip. Low priority.

**Stub note creation:**

When creating stubs:
- Title: exact text from the unresolved wikilink
- Content: **only** a backlinks section, nothing else
- Do **not** synthesize or generate content for the stub
- Let the backlinks show what's asking for this note

**Important:** Stub pages are scaffolds, not content. They get `genesis: manual` because the user will fill them. Nexus never writes reasoning content outside its own folder.

**Output for Phase 5:**

```
Unresolved Link Actions:

Create Stubs: {count}
- [[Topic Name]] — cited in {X} notes
- [[Another Topic]] — cited in {Y} notes

Check Variants: {count}
- [[Topic Name]] — might be [[Alternative Name]]

Skip: {count}
- Single mentions not aligned with priorities
```

### Phase 6: Score & Recommend

Rate each candidate connection across three dimensions (multiplicative scoring).

**Conceptual Strength (1-5):**
- 1: Same word, different context (surface)
- 2: Weak thematic connection
- 3: Clear thematic connection
- 4: Strong conceptual relationship
- 5: Same underlying principle or transferable insight

**Minimum threshold: 2** — avoid false connections.

**Structural Impact (1-5):**
- 1: Connects two already well-connected notes
- 2: Minor improvement to graph traversability
- 3: Bridges a small gap
- 4: Connects isolated cluster to main graph
- 5: Unlocks significant orphan rescue or cluster bridge

**Priority Alignment (1-5):**
- 1: Not related to current work
- 2: Tangentially related
- 3: Related to active area
- 4: Related to active project
- 5: Directly serves a ruthless priority

**Composite score:** Conceptual × Structural × Priority (max 125)

**Tier breakdown:**
- **Tier 1 (High):** 60-125
- **Tier 2 (Medium):** 30-59
- **Tier 3 (Low):** 15-29
- **Skip:** <15

Include borderline cases — sometimes a score 28 is worth surfacing for user judgment.

**Cap at 30 recommendations total.**

**Output for Phase 6:**

```
Recommendations by Tier:

Tier 1 (High Priority): {count}
1. Connect [[Note A]] to [[Note B]]
   - Conceptual: 4, Structural: 5, Priority: 4 | Score: 80
   - Why: {one-sentence explanation}
   - Where: {which section of Note A to add the link}

Tier 2 (Medium Priority): {count}
{same format}

Tier 3 (Low Priority / Borderline): {count}
{same format}

Flagged Issues:
- Empty hubs: [[Hub Name]] — {X} backlinks but no content
```

### Phase 7: Execute (After User Approval)

Present all recommendations to the user and ask which tiers to implement:

```
Ready to execute? Which tiers should I implement?
  • All tiers — implement all recommendations
  • Tier 1 only — high-confidence connections only
  • Selective — tell me specific recommendations to execute
```

Wait for approval before making any changes.

**Execution rules — metadata-only edits:**

These edits are permitted outside the Nexus root because they are metadata enhancements, not content changes. Every edit adds a wikilink or creates an empty stub. None rewrite reasoning or prose.

**Where to add links:**
- Within relevant note sections, *not* appended to the bottom as a dumping ground
- In context where the link makes sense — near related content
- Prefer modifying an existing sentence to include a wikilink over inserting a new sentence

**Bad:** Add `[[Related Note]]` as a bare line at the bottom of the file.
**Good:** In a section about "Deep Work", change the sentence "I need uninterrupted time for this." to "I need uninterrupted time for this — see [[Focus Time Framework]]."

**Creating stub notes:**

- Exact title from the unresolved wikilink
- YAML frontmatter if the vault uses it — include `genesis: manual` and `type: stub`
- Content: only a backlinks section

```markdown
---
type: stub
genesis: manual
tags: [stub]
created: {YYYY-MM-DD}
---

# {Note Title}

## Backlinks

Notes that reference this:
- [[Note 1]]
- [[Note 2]]
```

**Empty hubs:**

Flag but never fill. Report: "Hub [[X]] has Y backlinks but no content." Let the user decide whether to fill or restructure. Never generate content for an empty hub.

**Per-file approval:** For anything touching a file outside the Nexus root, present the exact edit and wait for approval before applying. Batch approvals are acceptable if the user explicitly says "apply all Tier 1" — but the user must see what will be changed first.

**Post-execution verification:** After applying edits, re-read each modified file and confirm the link is in place. Report any failures.

### Phase 8: Log

Append to `Nexus/log.md`:

```markdown
## [{ISO date}] link | Strategic connection pass

Scanned: {N} notes. Candidates: {N}. Recommendations: {N} across {N} tiers.
Approved: {N}. Applied: {N} link additions, {N} stub pages created.
Flagged: {N} empty hubs.
```

## Constraints

- Read maximum 100 notes across all phases
- Minimum conceptual strength of 2 — no false connections
- Every recommendation must have a one-sentence explanation
- Empty hubs flagged, never filled
- Stub notes have only a backlinks section, never synthesized content
- Cap at 30 recommendations total
- After execution, verify each edit was applied
- Never modify content prose outside the Nexus root — only metadata enhancements (wikilinks, frontmatter, stub creation)

## Path Configuration

Vault root is passed at invocation time. Reads `{rp-path}/ruthless-priorities.md` for priority alignment scoring (resolves from shared praxis config at runtime). Reads recent diary entries from `{diary-path}` for Phase 2 context.

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Vault has fewer than 10 notes | Report: "Vault is too small for meaningful link analysis. Run again after more content accumulates." |
| Ruthless priorities file doesn't exist | Skip priority alignment scoring. Score only Conceptual × Structural (max 25). Note the reduced scoring in the output. |
| No orphans, no dead ends, no unresolved links | Report honestly: "The graph is already well-connected. No link recommendations at this time." |
| User approves a Tier but the target file has changed since scanning | Re-read the file, confirm the target location still exists, ask for re-confirmation before applying. |
| A proposed edit would be a content change, not metadata | Skip the edit. Report it as requiring manual action. Never rewrite content outside the Nexus root. |
| User requests stub creation for a term that has no citations | Refuse. Stubs are only created for unresolved wikilinks with 3+ citations (or 2+ after variant check). |

## Relationship to Other Modes

- **vs. lint**: Lint reports structural issues and can auto-fix some of them (index drift, missing cross-refs, genesis integrity). Link scores and prescribes connection-level fixes with priority-aware judgment. Some overlap on orphan detection is expected — lint says "these orphans exist"; link says "here's which orphans to connect, to what, and why it matters." When the boundary is unclear, ask the user which mode should own a given finding.
- **vs. map**: Map is the diagnostic survey. Link is the prescriptive action pass. Map says "here's the shape and the gaps"; link says "here are the exact wikilinks to add, scored and ordered."
- **vs. connect**: Connect is targeted between two specific domains. Link is a broad vault-wide pass. A connect run may produce recommendations that would also show up in a link run — that's fine.
