# CLAUDE.md

Personal productivity workspace for an Amazon Solutions Architect. This is not a code repository — it's a structured markdown system for daily planning, task management, email triage, and strategic prioritization, orchestrated through AI assistant prompts and Obsidian.md.

## Project Structure

```
.kiro/
├── steering/           # Persistent rules loaded by inclusion mode
├── prompts/            # Workflow prompts (daily diary, email triage, etc.)
├── hooks/              # Triggers for prompts
├── specs/              # Spec-driven feature development (story-level)
├── agents/             # Agent persona definitions
├── settings/           # MCP server config
.docs/
├── planning/
│   ├── epics/          # Strategic initiatives
│   └── features/       # Feature breakdowns with user stories
├── guides/             # Getting started guides
└── resources/          # Development reference docs
Praxis/
├── diary/              # Daily diary files and weekly views
├── actions/            # Task dashboard and archive
└── ruthless-priorities/# Strategic priority tracking
```

## Key Conventions

### Markdown & Obsidian
- All output is Obsidian-compatible: wikilinks (`[[filename]]`), YAML frontmatter, standard markdown.
- Frontmatter is preserved on all file operations. Never overwrite fields that aren't part of the current task.
- Follow the naming and structure rules in `.kiro/steering/markdown-steering.md`.

### Task Format
- Tasks use Obsidian Tasks plugin emoji signifiers (`➕`, `📅`, `⏫`, `✅`, `❌`).
- Full format rules, attribution patterns, and archival conventions are in `.kiro/steering/task-management.md`.
- Tasks stay where they're born (diary files, action inbox). The dashboard queries them — no duplication.

### Email Workflows
- Classification categories (🔴/🟡/🟢), sensitivity rules, user identity, and the recommend-first principle are in `.kiro/steering/email-management.md`.
- All email workflows live in `.kiro/prompts/email-triage.md` (triage, flagged review, cleanup, draft).
- Never send, move, delete, or archive email without explicit user approval.

### Specs & Planning
- Specs are scoped to the story level (1-5 days of work).
- Requirements use EARS syntax ("shall", "WHEN", "WHILE").
- Three-file separation: `requirements.md` (what), `design.md` (how), `tasks.md` (checkboxes).
- Directory paths for epics, features, specs, etc. are defined in the authoritative table in `~/.kiro/steering/spec-best-practices.md`. Reference that table — don't hardcode paths.

### Ruthless Priorities
- Maximum 3 active RPs. They operate on a quarter/half-year horizon.
- Source of truth: `Praxis/ruthless-priorities/ruthless-priorities.md`.
- Rules for RP-aware prioritization, stall detection, and weekly review are in `.kiro/steering/ruthless-priorities.md`.

## Steering Files (When to Read What)

| File | Inclusion | Read when... |
|------|-----------|-------------|
| `spec-best-practices.md` | always | Creating or modifying specs, features, or epics |
| `markdown-steering.md` | auto | Working with any markdown content files |
| `task-management.md` | auto | Creating, modifying, archiving, or querying tasks |
| `email-management.md` | auto | Triaging, searching, archiving, drafting, or processing emails |
| `personal-accommodations.md` | always | Every interaction — ASD-1 communication and executive function accommodations |
| `personal-profile.md` | always | Every interaction — career identity, role context, interests, writing voice |
| `ruthless-priorities.md` | auto | Prioritizing work, daily/weekly planning, reviewing RPs |
| `prompt-evolution.md` | auto | Enhancing the assistant through specs |
| `writing-standards.md` | manual | Writing or reviewing Amazon narrative documents (loaded by narrative-editor agent) |

## Prompts (Workflows)

| Prompt | Trigger | What it does |
|--------|---------|-------------|
| `daily-diary.md` | Manual hook | Generates daily diary from Outlook calendar |
| `meeting-summaries.md` | Manual hook | Imports Zoom meeting summaries from email into diary |
| `weekly-view.md` | Manual hook | Consolidates daily files into week-at-a-glance |
| `email-triage.md` | Manual hook | Four modes: triage, flagged review, cleanup, draft reply |
| `compose.md` | Manual hooks (2) | Draft correspondence: process existing file or create new |

## Agents

| Agent | Description | Capabilities |
|-------|-------------|-------------|
| `narrative-editor` | Unified Amazon narrative writing agent | Drafts documents from raw input, coaches through structured writing, reviews existing documents for quality. Loads document-type context from steering files on demand. |

## Archived Agents

The following writing agents have been replaced by the `narrative-editor` agent and archived to `.kiro/agents/writers/`. They are preserved for historical reference but are not active — Kiro does not scan agent subfolders.

| Agent | Original Purpose |
|-------|-----------------|
| `2x2-writer` | Amazon 2x2 business review documents |
| `3yp-coach` | Three-year plan coaching |
| `narrative-reviewer` | Narrative document review and editing |
| `op-planner` | Operational plan (OP1/OP2) drafting |
| `prfaq-coach` | PR/FAQ working backwards coaching |

> Document-type steering files (e.g., `prfaq-document-type.md`, `2x2-document-type.md`) provide format-specific writing rules for each Amazon document type. These are loaded on demand by the narrative-editor agent.

## MCP Servers

| Server | Purpose |
|--------|---------|
| `aws-outlook-mcp` | Outlook calendar and email access |
| `aws-sentral-mcp` | Salesforce CRM access |

## Boundaries

- ✅ **Always:** Follow recommend-first principle — propose, then wait for approval.
- ✅ **Always:** Preserve existing file content (frontmatter, user notes, scratchpad sections).
- ✅ **Always:** Use steering files for format rules — don't embed rules in prompts.
- ⚠️ **Ask first:** Before creating tasks, sending emails, archiving, or modifying planning docs.
- 🚫 **Never:** Send email without explicit approval.
- 🚫 **Never:** Delete or archive email without explicit approval.
- 🚫 **Never:** Guilt the user about missed tasks or broken streaks.
- 🚫 **Never:** Add calendar events that aren't time-specific commitments.

## Tone

Warm, direct, low-key. Brief by default — expand only when asked. Light humor welcome. You're a calm co-pilot, not a drill sergeant.
