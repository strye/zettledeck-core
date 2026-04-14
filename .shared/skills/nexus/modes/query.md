# Nexus Query — Search and Synthesize

Search the knowledge base for relevant pages, synthesize an answer with citations, and optionally file the answer back as a new page.

**Mode:** `query`

## Input

The user provides a question or topic to investigate. This can be:
- A direct question: "What are the main arguments for X?"
- A comparison: "How does A compare to B?"
- An exploration: "What do we know about X?"
- A synthesis request: "What themes emerge across sources about X?"

## Workflow

### Phase 1: Search the Knowledge Base

1. Read `index.md` to identify potentially relevant pages.
2. Scan page titles, summaries, and tags for relevance to the query.
3. Read the most relevant pages (typically 3-10, depending on query scope).
4. If the knowledge base is large and the index isn't sufficient, use file search or grep across `pages/` for keyword matches.

### Phase 2: Synthesize Answer

Construct an answer that:
- Draws from multiple pages where relevant
- Cites sources using wikilinks: "According to [[Source Title]], ..."
- Notes where sources agree, disagree, or provide complementary perspectives
- Identifies gaps: "The knowledge base doesn't currently cover X" or "Only one source addresses this"
- Distinguishes between well-supported claims (multiple sources) and single-source claims
- Notes the `genesis` of cited pages when relevant (e.g., "This connection was surfaced by discover mode" for `emergent` pages)

**Answer format** adapts to the question type:

| Question Type | Format |
|---------------|--------|
| Direct question | Concise answer with citations |
| Comparison | Table or structured comparison with citations per cell |
| Exploration | Overview with sections, each citing relevant sources |
| Synthesis | Thematic analysis with cross-references |

### Phase 3: Present and Offer Filing

Present the answer to the user. Then ask:

"Want me to file this as a page? It would go in `pages/synthesis/` and get indexed for future queries."

**If yes**: Create a new synthesis page:

```markdown
---
type: synthesis
genesis: synthesis
created: {ISO date}
updated: {ISO date}
query: "{original question}"
sources: [{list of pages cited}]
tags: [{relevant tags}]
---

# {Descriptive Title Based on Query}

{The synthesized answer, with wikilinks to cited pages}

## Sources Consulted
- [[Page 1]] — {what it contributed}
- [[Page 2]] — {what it contributed}

## Gaps and Open Questions
- {What the knowledge base doesn't cover yet}
- {Questions this answer raises}
```

Update `index.md` to include the new synthesis page. Append to `log.md`.

**If no**: Just present the answer. No changes to the knowledge base.

### Phase 4: Log

Regardless of whether the answer was filed, append to `log.md`:

```markdown
## [{ISO date}] query | {short query summary}

Query: "{original question}"
Pages consulted: {N} ({list})
Answer filed: yes/no {if yes, page name}
```

## Query Against Empty or Small Knowledge Base

If the knowledge base has few or no pages:
- Say so directly: "The knowledge base has {N} pages. There isn't enough content to answer this well."
- If raw sources exist but haven't been ingested, suggest: "There are {N} files in `raw/` that haven't been ingested yet. Want me to process them first?"
- If the question could be answered with a web search, offer: "I can search the web for this and ingest the results. Want me to?"

## Multi-Turn Queries

If the user asks follow-up questions in the same session:
- Maintain context from previous queries in the session.
- Don't re-read pages already consulted unless the follow-up targets different content.
- If a follow-up refines or extends a previous answer, offer to update the filed page rather than creating a new one.

## Error Handling

| Scenario | Behavior |
|----------|----------|
| index.md doesn't exist | Warn user, suggest running `nexus ingest` first or `nexus init` |
| No relevant pages found | Report honestly, suggest ingesting more sources or refining the query |
| Pages reference sources that no longer exist in raw/ | Note the broken reference, answer with available content |
| Query is too broad | Ask the user to narrow it: "That's a broad topic. Want to focus on a specific aspect?" |
| Query is about something not in the knowledge base at all | Say so. Offer to search the web and ingest results. |
