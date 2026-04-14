# orient

Systematically build comprehensive context about the user and their work before starting any task.

## Purpose

This mode loads deep context to enable effective work without requiring basic clarifying questions. Instead of asking "What are you working on?" or "What matters to you?", this mode reads the vault systematically to discover the answers.

## Core Principle

**Maximize context depth to minimize friction in execution.**

When context is properly loaded, you can:
- Make recommendations aligned with actual priorities
- Reference real projects and active work
- Understand confidence levels (solid vs. evolving ideas)
- Work efficiently without constant back-and-forth

## Four-Step Process

### Step 1: Read Core Context Files

Read foundational documents that establish baseline understanding.

**Priority Order:**

1. **Ruthless Priorities**
   - Path: `{rp-path}/ruthless-priorities.md`
   - What to extract: Current 1-3 ruthless priorities, time horizon, what's at risk if these fail

2. **Vault Overview** (if exists)
   - Common names: `README.md`, `vault-overview.md`, `vault-steering.md`
   - What to extract: Vault organization, naming conventions, key principles

3. **Company/Work Context** (if exists)
   - Look in root or scope folders
   - What to extract: Role, team, current initiatives

4. **Personal Workflow** (if exists)
   - Look for: `workflow.md`, `systems.md`, `.claude/CLAUDE.md`
   - What to extract: How user works, tools, preferences

**Method:**
- Read `{rp-path}/ruthless-priorities.md` directly
- Read `vault-steering.md` if it exists at the vault root
- Search for `README.md` or `vault-overview.md` at the vault root

### Step 2: Explore Key Directories

Understand vault organization by listing and inspecting major folders.

**Key Directories:**

1. **Scopes** - Major life/work domains (S{ID}_{Title}/)
2. **Projects** - Active multi-step outcomes (P{ID}_{Title}/)
3. **Praxis/** - Daily operations (diary, actions, priorities)
4. **Content areas** - Where user stores notes, ideas, artifacts

**Method:**
- Walk the vault root directory to list top-level folders and count markdown files
- Scan frontmatter across a sample of notes to identify the property/tagging system in use

**What to extract:**
- How many scopes exist? (Life domains)
- How many active projects?
- What's the scale of the vault? (total files)
- What tagging/property system is in use?

### Step 3: Follow Backlinks from Core Documents

Recursively discover connected documents by examining links.

**Starting Points:**
- Ruthless priorities document
- Recent weekly plans
- Active project MOCs (Map of Content)

**Method:**
- Read `{rp-path}/ruthless-priorities.md` and extract all `[[wikilinks]]`
- Read each linked note; extract its wikilinks for the next hop
- Stop at 2-3 hops deep

**What to extract:**
- What projects connect to ruthless priorities?
- What notes reference active work?
- What's the "neighborhood" around current focus?

**Limit:** Don't go more than 2-3 hops deep. Focus on proximity to current work.

### Step 4: Review Recent Activity

Understand what's happening now by reading recent temporal documents.

**4a: Daily Notes (Past 5-7 Days)**
- Path: `{diary-path}/YYYY/MMM/YYYY-MM-DD_{Day}.md`
- What to extract:
  - What meetings happened?
  - What tasks were worked on?
  - What's top of mind?
  - Any open questions or blockers?

**4b: Weekly Learnings** (if exists)
- Path: Variable, search for "weekly" + "learning"
- What to extract:
  - How is thinking evolving?
  - What insights emerged recently?
  - What patterns are visible?

**Method:**
- Walk `{diary-path}/YYYY/MMM/` for the current and previous month; read the most recent 5-7 entries
- Search for "weekly" + "learning" in the diary path to locate weekly learnings files

**Note:** Vault structural health (orphans, dead ends, unresolved links, tag distribution) is not part of this mode. That analysis belongs to `nexus map` (topology) and `nexus lint` (mechanical issues). Run those modes when you want a structural picture of the vault.

## Synthesis Phase

After gathering information, synthesize into a clear summary.

### Output Structure

**Current Priorities:**
- [List 1-3 ruthless priorities with brief context]
- [Note any tension or misalignment between stated and actual priorities]

**Active Projects:**
- [List 3-5 most active projects based on recent mentions]
- [Note which ruthless priority each serves, if clear]

**Open Questions:**
- [List 3-5 questions the vault is actively asking]
- [These are unresolved links, recurring topics in diary, explicit questions]

**Recent Thinking Shifts:**
- [Note any changes in perspective visible in recent entries]
- [Topics gaining attention vs. losing attention]

**Confidence Markers:**
- [Solid]: Ideas/beliefs stated consistently across multiple notes
- [Evolving]: Ideas in active development, contradictions present
- [Hypothesis]: Tentative ideas, explicitly marked as experimental

**Context Loaded Status:**
- Files read: [count]
- Days reviewed: [count]
- Domains covered: [list]
- Ready to work on: [specific domains if requested, or "any area"]

## Prioritization by Domain

If user requests context for a specific domain:

**Syntax:** `/insight orient [domain]`

**Example:** `/insight orient S03_Cloud_Architecture`

**Adjusted Process:**
1. Still read core context files (Step 1)
2. Focus Step 2-4 on the specified domain
3. Read recent content in that scope
4. Follow backlinks specific to that domain
5. Note how domain connects to ruthless priorities

## Key Principles

1. **Prioritize Specifics Over Generics**
   - Don't just say "user values productivity"
   - Say "user is focused on reducing meeting load, mentioned in 4 of last 7 diary entries"

2. **Note Confidence Levels**
   - Some beliefs are solid (repeated consistently)
   - Some are evolving (contradictions present, questions asked)
   - Some are hypotheses (explicitly experimental)

3. **Connect to Ruthless Priorities**
   - Everything should trace back to the strategic layer
   - If activity doesn't connect to RPs, note the potential drift

4. **Respect Privacy**
   - Summarize personal content appropriately
   - Don't include sensitive details in synthesis unless relevant

5. **End Ready to Work**
   - Final message should be: "Context loaded. What would you like to work on?"
   - User should feel you understand their world

## Constraints

- Read core files completely, but scan others for keywords
- Don't read every file in the vault (use search and backlinks strategically)
- Focus on recent activity (past 7-30 days)
- Synthesis should be 1-2 screens max
- Include file paths for key documents discovered

## Vault Structure Context

Our vault uses this structure:
- **Scopes:** `S{ID}_{Title}/` - Major life/work domains
- **Projects:** `P{ID}_{Title}/` - Multi-step outcomes
- **Content:** `C{ID}_{Title}.md` - Notes, ideas, artifacts
- **Daily Diary:** `{diary-path}/YYYY/MMM/YYYY-MM-DD_{Day}.md`
- **Ruthless Priorities:** `{rp-path}/ruthless-priorities.md`

Interact with the vault via the file system: read files by path, walk directory trees, and search file contents with grep/ripgrep.

## Example Usage

**User invokes:** `/insight orient`

**You should:**
1. Read core context files (ruthless priorities, vault overview, etc.)
2. Explore vault structure (scopes, projects, scale)
3. Follow backlinks from core documents (1-2 hops)
4. Review recent diary entries (5-7 days) and weekly learnings
5. Synthesize findings into clear summary
6. End with: "Context loaded. What would you like to work on?"

**User invokes:** `/insight orient S03_Cloud_Architecture`

**You should:**
- Follow same process but focus on the specified scope
- Read recent content in that scope
- Note how it connects to ruthless priorities
- Synthesize domain-specific context

**Remember:** The goal is to understand the user's world deeply enough to work effectively without constant clarification. Be thorough but efficient.
