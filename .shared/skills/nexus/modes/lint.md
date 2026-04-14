# Nexus Lint — Health Check

Audit the knowledge base for structural and content issues. Surface problems, suggest fixes, and optionally auto-repair with user approval.

**Mode:** `lint`

## Workflow

### Phase 1: Scan

Read `index.md` and scan the Nexus directory structure. Build a picture of the current state:
- Total page count by type (source, entity, concept, synthesis, emergent)
- Total source count (files in `raw/`)
- Ingested vs. un-ingested sources (compare `raw/` contents against source pages)
- Genesis distribution (how many pages per genesis value)
- Link graph: use the `vault` skill — `vault link-graph {nexus-root}` — to build the link graph (returns TSV: `source`, `target`, `weight`); extract which pages link to which

### Phase 2: Check Categories

Run each check below. Collect all findings before presenting them.

#### 2a: Orphan Pages
Pages with no inbound links from other pages. These are disconnected from the knowledge graph.

**Detection**: For each page, check if any other page links to it (via wikilink or markdown link). Pages only linked from `index.md` still count as orphans (the index is a catalog, not a meaningful connection).

**Severity**: Low (orphans aren't broken, just disconnected)

#### 2b: Missing Pages (Broken Links)
Wikilinks that point to pages that don't exist.

**Detection**: Scan all pages for `[[Page Name]]` references. Check if each target page exists.

**Severity**: Medium (indicates incomplete integration)

#### 2c: Contradictions (Resolve-class only)

Claims in the knowledge base that cannot cohere and indicate confused thinking, stale data, or unreconciled conflicts that need cleanup. Not all contradictions are errors — this check only flags the **resolve** class: conflicts that should be fixed, merged, or superseded. Productive tensions and generative contradictions (the kind that fuel new insight, especially in theoretical or research work) are handled by `insight contradictions` and should not be flagged here.

**Severity**: Medium (contradictions aren't always errors, but resolve-class ones need attention)

##### Detection methods

Run all three methods. Collect candidates, then apply the filter gates before flagging anything.

**Pattern-based belief extraction**

Extract 15-20+ beliefs from pages by searching for explicit belief markers in the vault's markdown files. Common markers include: "I believe", "the truth is", "clearly", "obviously", "without question", "it's obvious that", and similar assertive phrases.

For each extracted belief, record:
- Source citation (page name + date)
- The belief statement, verbatim or lightly paraphrased
- The implied inverse statement

Example:
- Belief: "Deep work requires uninterrupted time"
- Implied inverse: "Interrupted time cannot produce deep work"

**Explicit contradictions**

- *Within same domain* — directly opposing claims about the same topic
- *Across domains* — conflicting claims where the same concept is treated incompatibly
- *Data conflicts* — conflicting statistics, dates, figures, or definitions referring to the same thing

**Implicit contradictions**

- *Stated values vs. documented behavior* — a page asserts a principle that other pages' actions contradict
- *Advice given vs. personal practice* — prescriptions that don't match the record
- *Priority contradictions* — multiple items simultaneously claimed as "most important," "top priority," or "the one thing that matters"

**Superseded information**

- Newer source contradicts an older claim on the same topic
- Pages not updated since a newer source on the same topic was ingested

##### Filter gates

Apply all four gates in order. A candidate contradiction must pass every gate to be flagged. Skipping anti-patterns here is how lint avoids manufacturing false conflicts.

**Gate 1 — Temporal Currency**

Is the older claim still within the last 6 months? If both claims are recent, it's a real present-tense conflict. If the older claim is stale and the newer one supersedes it, this is *evolution*, not contradiction — do not flag; instead, check whether the older page needs a stale-content mark (see check 2d).

**Gate 2 — Domain Compartmentalization**

Can these beliefs legitimately coexist in separate contexts — different projects, different frames, different scopes? A principle that applies in one domain and not another is not a contradiction; it's nuance. If they can coexist in separate contexts, skip — and consider whether `insight contradictions` would find this interesting as productive tension.

**Gate 3 — "Cannot Both Be True" test**

Are the two claims logically incompatible when held in the same frame at the same time? If they can both be true under any reasonable reading, skip. This is the strict logical test: the whole point of the category is that the beliefs cannot cohere.

**Gate 4 — Citation check**

Every flagged contradiction must cite both source pages with dates. No citation, no flag. If you cannot produce a precise source + date for both sides, the candidate is not ready to report.

##### Anti-patterns — do not flag

- **Evolution over time.** Changing your mind is growth, not contradiction. Handled by `insight trace` or lint's stale-content check.
- **Domain-specific beliefs held in separate frames.** This is nuance. If anything, it belongs to `insight contradictions` as productive tension.
- **Manufactured conflicts from surface-level wording differences.** Different words for the same idea are not contradictions.
- **Productive tensions that generate thought.** Theoretical and research work frequently holds opposing ideas in tension on purpose. That is the domain of `insight contradictions`, not lint.
- **Confidence-marker differences.** A page saying "I think X" and another saying "X is likely" is not a contradiction.

**Precision rule:** If the knowledge base is well-integrated, say so. Do not manufacture contradictions to fill a quota.

##### Output per contradiction

For each contradiction that passes all four gates, record:

- Both belief statements, verbatim or clearly paraphrased
- Page citations with dates for both sides
- Explanation of the logical incompatibility (which gate 3 condition fires)
- Suggested resolution path:
  - **Merge** — two pages make the same claim with conflicting details; combine them
  - **Supersede** — newer source replaces older; mark older as stale or update it
  - **Reconcile** — both are current but a unifying framing exists; rewrite for coherence
  - **Escalate** — the conflict is real and substantive; user judgment required

**Weight** is intentionally omitted here. Lint reports resolve-class contradictions as uniformly medium severity. Weight classification (trivial / moderate / significant / foundational) belongs to `insight contradictions`, where tensions are held rather than resolved.

#### 2d: Stale Content
Pages that reference sources or claims that have been superseded by newer information.

**Detection**:
- Pages not updated since a newer source on the same topic was ingested
- Entity or concept pages whose `updated` date is significantly older than the newest source mentioning them
- Claims marked with dates that are now outdated

**Severity**: Low to Medium (depends on how stale)

#### 2e: Un-ingested Sources
Files in `raw/` that don't have corresponding source summary pages.

**Detection**: List files in `raw/` (excluding `assets/` subdirectory). Check each against source pages.

**Severity**: Informational (not an error, just an opportunity)

#### 2f: Thin Pages
Pages that exist but have minimal content (e.g., just a title and one sentence).

**Detection**: Pages with fewer than 100 words of content (excluding frontmatter).

**Severity**: Low (better than nothing, but could be enriched)

#### 2g: Missing Cross-References
Pages that mention entities or concepts in their text but don't link to the corresponding page.

**Detection**: Scan page text for entity/concept names that exist as pages but aren't linked.

**Severity**: Low (easy fix, improves navigability)

#### 2h: Index Drift
Pages that exist but aren't listed in `index.md`, or index entries that point to pages that no longer exist.

**Detection**: Compare `index.md` entries against actual directory contents.

**Severity**: Medium (the index is the LLM's primary navigation tool)

#### 2i: Genesis Integrity
Pages missing the `genesis` frontmatter property, or pages with a `genesis` value that doesn't match their location or type.

**Detection**: Check all pages for valid `genesis` values. Flag pages in `pages/sources/` without `genesis: source`, emergent pages without `genesis: emergent`, etc.

**Severity**: Low (metadata hygiene)

### Phase 3: Report

Present findings in a structured report:

```
🔍 Nexus Lint Report — {date}

Knowledge base stats:
  Pages: {N} (sources: {N}, entities: {N}, concepts: {N}, synthesis: {N}, emergent: {N})
  Raw sources: {N} ({N} ingested, {N} pending)
  Links: {N} total, {N} broken
  Genesis: source: {N}, derived: {N}, synthesis: {N}, emergent: {N}, manual: {N}

Issues found: {total count}

🔴 Medium Priority:
  • {N} broken links: {list of broken wikilinks with source page}
  • {N} contradictions: {brief description of each}
  • {N} index drift issues: {pages missing from index or ghost entries}

🟡 Low Priority:
  • {N} orphan pages: {list}
  • {N} stale pages: {list with last-updated dates}
  • {N} thin pages: {list}
  • {N} missing cross-references: {list with suggested links}
  • {N} genesis integrity issues: {list}

ℹ️ Informational:
  • {N} un-ingested sources in raw/

Suggested actions:
  1. {Most impactful fix}
  2. {Second most impactful fix}
  3. {Third most impactful fix}
```

### Phase 4: Offer Fixes

After presenting the report, ask:

"Want me to fix any of these? I can:
- Auto-fix: index drift, missing cross-references, genesis integrity (low risk)
- Fix with review: orphan pages (add links), thin pages (enrich content)
- Flag only: contradictions, stale content (these need your judgment)"

If the user approves auto-fixes:
1. Execute the fixes
2. Update `index.md` if any pages were modified
3. Append a lint entry to `log.md`

If the user wants fix-with-review items:
1. Present each fix individually for approval
2. Apply approved fixes
3. Update index and log

### Phase 5: Log

Append to `log.md`:

```markdown
## [{ISO date}] lint | Health check

Found {N} issues ({N} medium, {N} low, {N} informational).
Auto-fixed: {N} ({list of fix types})
User-reviewed fixes: {N}
Remaining: {N}
```

## Lint Scope Options

If the knowledge base is large, the user may want to lint a subset:

- `nexus lint` — full knowledge base (default)
- `nexus lint sources` — only source pages
- `nexus lint entities` — only entity pages
- `nexus lint {page name}` — single page and its connections

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Nexus directory doesn't exist | Report: "No Nexus found. Run `nexus init` or `nexus ingest` first." |
| index.md doesn't exist | Report as a finding (index drift), offer to create it |
| log.md doesn't exist | Create it when logging the lint |
| Knowledge base has fewer than 3 pages | Run checks but note: "Knowledge base is very small. Most checks are more useful with 10+ pages." |
| Contradiction detection is uncertain | Flag as "possible contradiction" rather than definitive |
