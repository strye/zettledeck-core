# Nexus Init — Interactive Setup

Walk the user through customizing their Nexus knowledge base. Creates a `NEXUS.md` schema file and scaffolds the directory structure. This mode is optional: the knowledge base works with sensible defaults if the user never runs init.

**Mode:** `init`

## Behavior

This is a conversational walkthrough, not a form. Ask questions in batches of 2-3, adapt based on answers, and build the schema incrementally. The user can say "use defaults" at any point to skip remaining questions and accept defaults for everything not yet configured.

## Walkthrough Sequence

### Step 1: Domain and Purpose

Ask the user:
1. What is this knowledge base about? (topic, domain, or purpose)
2. Is this for a specific project, ongoing research, personal knowledge, or something else?

Use the answers to set the `domain` and `purpose` fields in the schema and to inform page type suggestions in Step 3.

### Step 2: Directory Structure

Present the default structure and ask if they want to customize:

```
Nexus/
├── NEXUS.md          — schema file (this is what we're building)
├── index.md          — content catalog
├── log.md            — activity record
├── raw/              — your source documents (immutable)
│   └── assets/       — images and attachments from sources
└── pages/            — LLM-generated pages
    ├── sources/      — source summaries
    ├── entities/     — entity pages (people, orgs, tools, etc.)
    ├── concepts/     — concept and topic pages
    └── synthesis/    — cross-cutting analysis, comparisons, discoveries
```

Ask:
1. Does this structure work, or do you want different directory names or organization?
2. Where should the Nexus root live? (default: `Nexus/` in the project root)

### Step 3: Page Types and Categories

Based on the domain from Step 1, suggest relevant page types beyond the defaults. Examples:

| Domain | Suggested Additional Types |
|--------|---------------------------|
| Research | `papers`, `methods`, `datasets`, `findings` |
| Personal | `goals`, `habits`, `reflections`, `people` |
| Book/reading | `characters`, `themes`, `plot-threads`, `quotes` |
| Business | `competitors`, `customers`, `decisions`, `metrics` |
| Technical | `tools`, `patterns`, `architectures`, `tradeoffs` |
| Course/learning | `lectures`, `exercises`, `key-terms`, `connections` |

Present the suggestions and ask:
1. Which of these additional page types would be useful? (or suggest your own)
2. Any page types from the defaults you want to remove or rename?

### Step 4: Conventions

Ask about preferences (present defaults, let user override):

1. Cross-reference style: wikilinks `[[Page Name]]` (default) or markdown links `[text](path)`?
2. Frontmatter: include tags, source counts, status fields? (default: yes to all)
3. Any naming conventions for pages? (default: title case, no prefixes)

### Step 5: Ingest Preferences

Ask:
1. Do you prefer to ingest sources one at a time with discussion, or batch-ingest with less supervision? (default: one at a time)
2. When ingesting, should the LLM automatically create entity/concept pages for new terms, or ask first? (default: auto-create)

### Step 6: Review and Generate

Present a summary of all choices. Ask the user to confirm or adjust.

On confirmation:
1. Generate `NEXUS.md` using the schema template (see `references/schema-template.md`)
2. Create the directory structure
3. Create empty `index.md` and `log.md` with proper frontmatter
4. Log the init to `log.md`

## "Use Defaults" Shortcut

If the user says "use defaults", "just set it up", "basic is fine", or similar at any point:
1. Skip remaining questions
2. Use defaults for all unconfigured settings
3. Ask only for the Nexus root path (or default to `Nexus/`)
4. Generate schema and scaffold immediately

## Re-Running Init

If `NEXUS.md` already exists when init is invoked:
1. Read the existing schema
2. Tell the user: "You already have a Nexus schema. Want to update it, or start fresh?"
3. If updating: walk through the same steps but show current values as defaults
4. If starting fresh: back up existing `NEXUS.md` to `NEXUS.md.bak` and proceed normally

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Nexus root doesn't exist | Create it (with user confirmation) |
| Directory structure partially exists | Create only missing directories, don't overwrite |
| NEXUS.md already exists | Offer update or fresh start (see above) |
| User abandons mid-walkthrough | Save nothing. No partial schemas. |
| index.md or log.md already exist | Preserve them. Don't overwrite existing content. |
