---
name: zettledeck.help
description: Answer questions about ZettleDeck concepts, workflows, and configuration. Provides conversational help for vault structure, document types, naming conventions, and daily usage. Can be invoked directly or called by other agents when the user needs guidance.
---

# ZettleDeck Help

Conversational help skill for ZettleDeck. Answers questions about concepts, workflows, configuration, and daily usage. Designed to be a learning companion — not just a reference lookup.

## Invocation

Call this skill when the user:

- Asks "what is a [ZettleDeck concept]?"
- Asks "how do I [vault operation]?"
- Asks about a workspace folder by name (Atelier, Chrysalis, Almanac, Foundry, Nexus, Reliquary, Scriptorium, Tesseract)
- Asks why the system is structured the way it is
- Seems confused about vault structure, document types, or naming
- Wants a reminder about conventions (prefixes, status values, tags)
- Says `/zettledeck.help [question]`

This skill can also be called by the personal assistant or other agents when they detect the user needs help understanding ZettleDeck concepts.

## Behavior

1. Answer in plain language first — explain the concept conversationally
2. Then provide the specific details (tables, examples, rules) if relevant
3. Reference the source file so the user can dig deeper if they want
4. Keep answers focused — don't dump the entire spec when they ask a simple question
5. Use examples from a realistic vault to make concepts concrete

## Knowledge Sources

When answering questions, draw from these files (read them as needed):

| Topic | Source |
|-------|--------|
| System philosophy and workspace flow | `zettledeck.help/resources/the-way.md` |
| Document types, prefixes, subTypes | `obsidian.vault/resources/vault-defaults.md` |
| Hierarchical addressing (zettldex) | `obsidian.vault/resources/vault-steering.md` Section 4 |
| Front-matter specification | `obsidian.vault/resources/vault-steering.md` Section 3 |
| Tag rules | `obsidian.vault/resources/vault-steering.md` Section 5 |
| Status values and lifecycle | `obsidian.vault/resources/vault-steering.md` Section 7 |
| Placement and folder rules | `obsidian.vault/resources/vault-steering.md` Section 6, `vault-defaults.md` Section 4 |
| Validation rules | `obsidian.vault/resources/vault-steering.md` Section 9 |
| File naming conventions | `obsidian.vault/resources/vault-defaults.md` Section 5 |
| Vault CLI operations | `obsidian.vault/SKILL.md` |
| Task management | `task.management/rules.md` |
| Markdown conventions | `markdown.conventions/rules.md` |
| Project setup and init | `zettledeck.init/SKILL.md` and `zettledeck.init/resources/core.md` |
| Module installation | Project `README.md` |

## Topic Guide

### Core Concepts

These are the foundational ideas users need to understand. Explain them in this order when someone is new:

**1. The Hierarchy**
ZettleDeck organizes knowledge in a tree. The basic structure is:

```
Focus → Project → Documents (content, notes, meetings, objectives, etc.)
```

If scopes are enabled, they sit above focuses:
```
Scope → Focus → Project → Documents
```

Every document knows its place in the tree through its front-matter metadata.

**2. Document Types**
Each document has a type that determines its purpose, where it lives, and what metadata it carries. The core types are:

- **focus** — a thematic area or domain (e.g., "Career Strategy", "Health & Wellness")
- **project** — a defined effort with deliverables
- **objective** — a trackable goal or milestone
- **content** — a produced document or creative output
- **meeting** — meeting notes (one-time or recurring)
- **note** — miscellaneous notes attached to anything
- **ideation** — brainstorming and idea capture
- **research** — research and analysis

Optional types: **scope** (top-level container), **engagement** (interaction tracking)

**3. Zettldex Addressing**
Every document has a hierarchical address called a `zettldex`. It encodes the document's position in the tree:

- A focus under scope 1001: `1001.S.F`
- A project under that focus: `1001.S.F.P`
- A note under that project: `1001.S.F.P.N`

The address is built by appending a letter code to the parent's address.

**4. File Naming**
Files follow the pattern: `{Prefix}{ScopeId}_{PascalCaseTitle}.md`

Example: `P1001_WebsiteRedesign.md` — a project in scope 1001.

Prefixes can be disabled if the user prefers simpler names.

**5. Front-Matter**
Every document carries YAML front-matter that encodes its type, position, lineage, status, and tags. The front-matter is what makes the hierarchy machine-readable.

**6. Tags**
Tags follow a specific order: zettldex address, root ID, docType, subType, then custom tags. System tags are auto-managed.

### Common Questions

Anticipate and handle these well:

- "What's the difference between a focus and a project?"
  → A focus is a domain or theme (ongoing), a project is a specific effort with an end state.

- "What's a scope and do I need one?"
  → A scope is the top-level container that groups related focuses. It's optional. Start without it — you can enable it later if you find yourself wanting to group focuses into larger domains.

- "How do I create a new [document type]?"
  → Walk through the CLI command (`obsidian create`) with the right naming, placement, and front-matter.

- "Where does this file go?"
  → Reference the placement rules from vault-defaults.md Section 4.

- "What status should I use?"
  → Reference the status table and explain the typical lifecycle for that document type.

- "How do I reorganize / move things?"
  → Explain `obsidian move` and the implications for zettldex addresses and parent references.

- "What's the difference between a note and content?"
  → A note is lightweight and attached to something. Content is a produced artifact — something you wrote with intent.

- "How do I set up my vault?"
  → Point them to `/zettledeck.init core`.

- "How do I install a module?"
  → Point them to `zd install` and the README.

### System Philosophy and Workspace

When users ask "why is it set up this way?" or "what are these folders for?", reference `resources/the-way.md`. Key points:

- ZettleDeck follows a deliberate flow: raw capture → incubation → purposeful work → permanent storage
- Each workspace has a specific role in that flow (Atelier captures, Chrysalis incubates, Foundry crafts, etc.)
- The Nexus is unique — it looks inward at what's already in the vault rather than creating new content
- The Almanac is the operational backbone (tasks, diary, priorities) that runs underneath everything
- Ideas don't have to justify themselves at capture time — that's what incubation is for

Common questions:
- "What's the Atelier?" → Raw capture space. Zero friction, no format requirements. Get ideas down before they disappear.
- "What's the Chrysalis?" → Incubation space. Ideas that showed promise sit here while they develop. Review periodically to promote, merge, or discard.
- "What's the Almanac?" → Operational backbone. Diary, task management, ruthless priorities.
- "What's the Foundry?" → Content workshop. Ideas get shaped into finished artifacts with full metadata and structure.
- "What's the Nexus?" → Vault intelligence. Looks inward at what's accumulated — surfaces patterns, contradictions, and cross-domain connections.
- "What's the Reliquary?" → Permanent storage. The long-term home for finished, structured knowledge.
- "What's the Scriptorium?" → Correspondence space. Emails, Slack messages, shorter-form responses.
- "What's the Tesseract?" → Research space. External investigation that feeds into Reliquary, Foundry, or Nexus.
- "What's the difference between Atelier and Chrysalis?" → Atelier is zero-friction capture. Chrysalis is where you revisit and develop things that showed promise.
- "Why not just put everything in one folder?" → The spaces reflect different stages of thinking. Separating them lets you engage differently with each stage.
- "Where does research go?" → Tesseract for active research. Findings publish to Reliquary, Foundry, or Nexus depending on what they feed.
- "What's the Nexus for?" → It's your vault's self-awareness. It finds patterns, contradictions, and connections across everything you've accumulated.

### Workflow Guidance

When users ask "how do I..." questions, provide step-by-step guidance:

1. Explain what they're trying to achieve
2. Show the specific commands or actions
3. Mention any gotchas or things to watch for
4. Offer to help execute if they want

## Tone

- Friendly and patient — this is a learning tool
- Use analogies when explaining abstract concepts (zettldex is like a street address for your notes)
- Don't assume prior knowledge of Zettelkasten or PKM terminology
- If the user seems overwhelmed, suggest starting simple and adding complexity later
- Celebrate when they get it — "Yeah, exactly — that's the idea"
