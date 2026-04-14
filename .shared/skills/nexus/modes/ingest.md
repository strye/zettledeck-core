# Nexus Ingest — Process Source into Knowledge Base

Read a source document, extract key information, and integrate it into the Nexus by creating or updating pages, cross-references, index, and log.

**Mode:** `ingest`

## Input

The user provides one of:
- A file path to a document in `raw/` (or anywhere in the project)
- A URL to fetch and process
- A pasted block of text (treated as inline source)
- A file path outside the Nexus root (the LLM copies it to `raw/` first)

If the user provides a URL, fetch the content and save it to `raw/` as a markdown file before processing. The raw copy is the source of truth.

## Workflow

### Phase 1: Read and Understand

1. Read the source document completely.
2. Identify the source type (article, paper, transcript, notes, data, etc.).
3. Extract:
   - Title and author (if available)
   - Key claims, findings, or arguments
   - Named entities (people, organizations, tools, places, concepts)
   - Data points, statistics, or metrics
   - Relationships between entities
   - Contradictions with or support for existing Nexus content

### Phase 2: Discuss with User

Present a brief summary to the user:

```
📥 Source: {title}
Type: {article/paper/transcript/etc.}
Key takeaways (3-5 bullets):
  • {takeaway 1}
  • {takeaway 2}
  • {takeaway 3}

New entities: {list of entities not yet in the knowledge base}
Existing pages to update: {list of pages this source touches}
Contradictions: {any conflicts with existing content, or "none detected"}
```

Ask: "Anything to emphasize, skip, or correct before I integrate this?"

If the user says "just process it" or similar, skip discussion and proceed.

**NEXUS.md override**: If the schema sets `ingest-mode: batch`, skip this discussion phase entirely and proceed to Phase 3 automatically.

### Phase 3: Integrate

Execute these steps. The order matters: source summary first (it's the anchor), then fan out to entity/concept pages, then update the index and log last.

#### 3a: Create Source Summary Page

Create a new page in `pages/sources/` (or the configured sources directory):

```markdown
---
type: source
genesis: source
created: {ISO date}
updated: {ISO date}
source-type: {article/paper/transcript/etc.}
author: {author if known}
source: {URL if applicable}
raw-file: {path to file in raw/}
tags: [{relevant tags}]
---

# {Source Title}

## Summary
{2-4 paragraph summary of the source's key content}

## Key Claims
- {Claim 1} — {supporting detail or context}
- {Claim 2} — {supporting detail or context}

## Entities Mentioned
- [[Entity 1]] — {role in this source}
- [[Entity 2]] — {role in this source}

## Concepts
- [[Concept 1]] — {how this source relates to the concept}

## Connections
- {How this source relates to other sources or Nexus content}
- {Contradictions or reinforcements}

## Raw Source
{path to raw file or URL}
```

#### 3b: Create or Update Entity Pages

For each entity mentioned in the source:

**If the entity page doesn't exist**: Create it in `pages/entities/` (or configured directory):

```markdown
---
type: entity
genesis: derived
created: {ISO date}
updated: {ISO date}
entity-type: {person/org/tool/place/etc.}
sources: [{source page name}]
tags: [{relevant tags}]
---

# {Entity Name}

## Overview
{What this entity is, based on available sources}

## Appearances
- [[Source Title]] — {context of mention}

## Relationships
- {Links to other entities or concepts}
```

**If the entity page exists**: Update it:
- Add the new source to the `sources` frontmatter list
- Add an entry under `## Appearances`
- Update `## Overview` if the new source adds significant information
- Add new relationships if discovered
- Update the `updated` timestamp

#### 3c: Create or Update Concept Pages

Same pattern as entities, but for concepts/topics. Concept pages live in `pages/concepts/` (or configured directory) and follow the same create-or-update logic.

Concept pages have an additional section:

```markdown
## Evolution
- {How understanding of this concept has changed across sources}
- {Earlier sources said X, newer sources say Y}
```

#### 3d: Check for Contradictions

Compare the new source's claims against existing Nexus content:
- If a contradiction is found, note it on both the source summary page and the contradicted page.
- Use a consistent format: `> ⚠️ **Contradiction**: [[Source A]] claims X, but [[Source B]] claims Y.`
- Do not resolve contradictions automatically. Flag them for the user.

#### 3e: Update Index

Add the new source to `index.md` under the appropriate category. Update any entity or concept entries that were created or modified. Update the `page-count` and `source-count` in frontmatter. Update the `updated` timestamp.

#### 3f: Update Log

Append an entry to `log.md`:

```markdown
## [{ISO date}] ingest | {Source Title}

Processed {source type} from {author/origin}. Created {N} new pages, updated {N} existing pages.
New: {list of new page names}
Updated: {list of updated page names}
```

### Phase 4: Report

After integration, report to the user:

```
✅ Ingested: {Source Title}

Pages created: {N} ({list})
Pages updated: {N} ({list})
Contradictions flagged: {N or "none"}
Index updated: yes
Log entry added: yes
```

## Batch Ingest

If the user provides multiple sources at once (or the schema sets `ingest-mode: batch`):

1. Process each source through the full workflow above.
2. Between sources, do not pause for discussion (skip Phase 2).
3. After all sources are processed, provide a single consolidated report.
4. Cross-reference between the batch sources as well as against existing content.

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Source file not found | Report error, ask for correct path |
| URL fetch fails | Report error, suggest saving manually to `raw/` |
| Source is empty or unreadable | Report, skip, log the attempt |
| Nexus directories don't exist | Create them (following schema or defaults) |
| index.md doesn't exist | Create it with proper structure |
| log.md doesn't exist | Create it with proper structure |
| Entity/concept page has conflicting edits | Preserve both versions, flag for user review |
| Source already ingested (duplicate) | Check log. Warn user: "This source was ingested on {date}. Re-ingest to update, or skip?" |
