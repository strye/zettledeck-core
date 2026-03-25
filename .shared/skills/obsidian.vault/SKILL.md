---
name: obsidian.vault
description: Interact with the Obsidian vault using the obsidian CLI — read, search, create, move, manage tags/links/tasks, and inspect metadata. Works across all modes: notes, search, tasks, properties, and links.
---

# Obsidian Vault Skill

Interact with the Obsidian vault directly via the `obsidian` CLI. Covers reading and writing notes, full-text search, task management, tag/link navigation, and YAML property operations.

## Invocation

Call this skill when the user requests:

- "Search my vault for [topic]"
- "Find notes tagged [tag]"
- "Read the note [Note Name]"
- "Create a note called [Name]"
- "Append [content] to [note]"
- "Prepend [content] to [note]"
- "List all orphan notes"
- "Show backlinks for [Note Name]"
- "List all tasks in my vault"
- "What are my tags?"
- "Set the [property] on [note] to [value]"
- `/obsidian.vault [mode] [args]`

**Modes**: `search`, `read`, `create`, `append`, `prepend`, `move`, `rename`, `delete`, `tags`, `links`, `backlinks`, `orphans`, `tasks`, `properties`, `files`, `outline`

---

## Requirements

**Prerequisites:**
- Obsidian 1.12.4 or later (note: installer updates available at obsidian.md/download for better CLI support)
- Obsidian app must be **running in the background**
- CLI must be registered: Obsidian → Settings → General → Command line interface → Register CLI

**Tools needed**: Bash (for CLI), Read, Write, Glob

**Vault path**: The workspace root directory is assumed to be the vault root. If your vault is at a different location, set `vault.path` in your project configuration or CLAUDE.md.

---

## Setup Check

Before executing any CLI command, verify the CLI is available:

```bash
obsidian help 2>&1
```

If this returns `command not found`:
1. Open Obsidian
2. Go to Settings → General → Command line interface → Register CLI
3. Restart terminal / source shell profile
4. Retry

If Obsidian is not running, prompt the user to open it before proceeding.

---

## CLI Syntax Notes

- Flags are bare keywords, NOT prefixed with `--` (e.g. `overwrite` not `--overwrite`)
- Quote values with spaces: `name="My Note"`
- Use `\n` for newline, `\t` for tab in content values
- `file=` resolves by name (like wikilinks); `path=` is exact (e.g. `folder/note.md`)
- Most commands default to the active file when `file`/`path` is omitted

---

## Mode Reference

### `files` — List and Count Notes

```bash
# List all notes
obsidian files

# List notes in a specific folder
obsidian files folder="path/to/folder"

# Filter by extension
obsidian files ext=md

# Count total notes
obsidian files total
```

**When to use**: Vault exploration, finding notes in a folder, getting counts.

---

### `search` — Full-Text and Structured Search

```bash
# Full-text search
obsidian search query="customer discovery"

# Tag search
obsidian search query="[tag:customer]"

# Property/frontmatter search
obsidian search query="[status:active]"

# Combined
obsidian search query="migration [tag:aws]"

# Limit results
obsidian search query="topic" limit=10

# JSON output (for parsing)
obsidian search query="topic" format=json

# Case sensitive
obsidian search query="AWS" case

# Search with surrounding line context
obsidian search:context query="customer discovery"
obsidian search:context query="topic" format=json
```

**When to use**: Finding notes by content, tag, or metadata. Use `search:context` when you need to see the matching lines in context.

---

### `read` — Read Note Content

```bash
obsidian read file="Note Name"
obsidian read path="path/to/note.md"
```

**When to use**: User wants to see the content of a specific note. Use exact note name (no `.md` extension needed with `file=`).

**Note**: If the exact name is unknown, use `search` first to find it, then `read`.

---

### `outline` — Show Note Headings

```bash
# Show headings as a tree
obsidian outline file="Note Name"

# Markdown format
obsidian outline file="Note Name" format=md

# JSON format
obsidian outline file="Note Name" format=json

# Count headings
obsidian outline file="Note Name" total
```

**When to use**: Navigating a long note, getting a structural overview before reading or editing.

---

### `create` — Create a New Note

```bash
# Create with content
obsidian create name="New Note" content="# Heading\n\nBody text."

# Create at a specific path
obsidian create path="path/to/note.md" content="..."

# Use a template
obsidian create name="Meeting Notes" template="Meeting Template"

# Overwrite if exists (bare flag, no --)
obsidian create name="Note Name" content="..." overwrite

# Open after creating
obsidian create name="Note Name" content="..." open
```

**When to use**: Creating a brand new note. Always confirm with user before creating, per recommend-first principle.

**Format rules**: Follow `resources/vault-steering.md` and `resources/vault-defaults.md` conventions for frontmatter, naming, and folder placement.

---

### `append` — Append Content to an Existing Note

```bash
obsidian append file="Note Name" content="New content to add."

# Append without newline prefix
obsidian append file="Note Name" content="inline addition" inline
```

**When to use**: Adding to an existing note without overwriting (e.g., adding a task to the daily diary, adding meeting notes). Preferred over `create overwrite` when preserving existing content matters.

---

### `prepend` — Prepend Content to an Existing Note

```bash
obsidian prepend file="Note Name" content="Content at top."

# Prepend without newline
obsidian prepend file="Note Name" content="inline" inline
```

**When to use**: Adding content to the beginning of a note (e.g., inserting a header or summary before existing content).

---

### `move` — Move a Note to a Different Folder

```bash
# Move to a different folder
obsidian move file="Draft Note" to="Archive/2025/"

# Move using exact path
obsidian move path="path/to/old.md" to="Archive/2025/old.md"
```

**When to use**: Reorganizing vault structure. Preserves wikilinks automatically.

**Note**: For renaming (same folder, new name), use `rename` instead.

**Always confirm** with user before moving files.

---

### `rename` — Rename a Note

```bash
obsidian rename file="Old Name" name="New Name"
obsidian rename path="path/to/old.md" name="New Name"
```

**When to use**: Renaming a note in place (same folder). Preserves wikilinks automatically. Use `move` when changing folders.

**Always confirm** before renaming — it affects all backlinks.

---

### `delete` — Delete a Note

```bash
# Move to Obsidian trash (default, recoverable)
obsidian delete file="Old Note"

# Permanent delete (irreversible — use with extreme caution)
obsidian delete file="Old Note" permanent
```

**When to use**: User explicitly requests deletion.

**NEVER use `permanent`** without explicit user instruction. Default trash behavior is preferred.

**Always confirm** before deleting.

---

### `open` — Open a File in Obsidian

```bash
obsidian open file="Note Name"
obsidian open file="Note Name" newtab
```

**When to use**: User wants to navigate to a note in the Obsidian UI without reading its content via CLI.

---

### `properties` — Read YAML Frontmatter

```bash
# Read all properties from a note
obsidian properties file="Note Name"

# Read vault-wide property list with counts
obsidian properties counts sort=count

# Read a specific property value
obsidian property:read name="status" file="Note Name"
```

**When to use**: Inspecting YAML frontmatter.

---

### `property:set` / `property:remove` — Modify YAML Properties

```bash
# Set a property (name= and value= are required)
obsidian property:set name="status" value="active" file="Note Name"

# Set with explicit type
obsidian property:set name="priority" value="high" type=text file="Note Name"
# type options: text | list | number | checkbox | date | datetime

# Remove a property
obsidian property:remove name="draft" file="Note Name"
```

**When to use**: Updating YAML frontmatter without touching note body. Preserves all other frontmatter fields.

---

### `tags` — Tag Management

```bash
# List all tags across the vault
obsidian tags

# List tags with counts
obsidian tags counts sort=count

# Get info on a specific tag
obsidian tag name="aws"

# List tags for a specific file
obsidian tags file="Note Name"
```

**When to use**: Vault-wide tag audit, finding which notes use a tag.

**Note**: `tags:rename` does NOT exist in the CLI. To rename tags you must use search + edit the files directly.

---

### `links` — Outgoing Links and Backlinks

```bash
# Outgoing links from a note
obsidian links file="Note Name"

# Count outgoing links
obsidian links file="Note Name" total

# Incoming backlinks to a note
obsidian backlinks file="Note Name"

# Backlinks with counts
obsidian backlinks file="Note Name" counts

# Find orphan notes (no incoming links)
obsidian orphans

# Find dead-end notes (no outgoing links)
obsidian deadends

# Find broken wikilinks across vault
obsidian unresolved
```

**When to use**:
- `links` / `backlinks` — navigating note relationships, understanding context
- `orphans` — vault hygiene, finding disconnected notes
- `deadends` — notes with no outgoing links (isolated stubs)
- `unresolved` — fixing broken links after renames or moves

---

### `tasks` — Task Operations

```bash
# List all open tasks in the vault
obsidian tasks

# List completed tasks
obsidian tasks done

# List incomplete tasks only
obsidian tasks todo

# Filter by file
obsidian tasks file="Note Name"

# JSON output
obsidian tasks format=json

# Group by file with line numbers
obsidian tasks verbose

# Update a specific task (by file + line number)
obsidian task path="path/to/note.md" line=42 toggle
obsidian task path="path/to/note.md" line=42 done
obsidian task path="path/to/note.md" line=42 todo

# Set a custom status character
obsidian task path="file.md" line=42 status="/"
```

**When to use**: Getting a vault-wide task view, or toggling task status.

**Note**: `task:create` does NOT exist — create tasks by appending markdown to a note with `obsidian append`.

**Task format**: Always use Obsidian Tasks emoji signifiers when creating tasks via `append` (see `task.management` skill rules for full format).

---

### `recents` — Recently Opened Files

```bash
obsidian recents
obsidian recents total
```

**When to use**: Finding recently worked-on files without a specific search query.

---

### `vault` — Vault Info

```bash
obsidian vault
obsidian vault info=name
obsidian vault info=path
obsidian vault info=files
obsidian vault info=size
```

**When to use**: Quick vault stats or confirming which vault is active.

---

### `folder` / `folders` — Folder Operations

```bash
# Show folder info
obsidian folder path="path/to/folder"

# List subfolders
obsidian folders folder="path/to/parent"

# Count folders
obsidian folders total
```

**When to use**: Navigating vault folder structure, counting notes in a section.

---

### `eval` — Execute JavaScript in Obsidian (Advanced)

```bash
obsidian eval code="app.vault.getFiles().length"
```

**When to use**: Advanced debugging, plugin development, or operations not covered by standard commands. Use sparingly — prefer specific commands.

---

## Output Formats

Most commands support a `format=` flag:

| Format | Use |
|--------|-----|
| `format=json` | Machine-readable, for parsing in workflows |
| `format=csv` | Spreadsheet export |
| `format=tsv` | Tab-separated (default for many list commands) |
| `format=md` | Markdown-formatted output |
| `format=yaml` | YAML structure (default for `properties`) |
| `format=tree` | Folder tree view (e.g. `outline`) |

Default output is human-readable plain text or TSV depending on the command.

---

## Workflow: Search → Read → Act

The standard pattern for vault operations:

1. **Search** to find relevant notes
2. **Read** to inspect content
3. **Propose** the action (recommend-first)
4. **Execute** with `create`, `append`, `move`, or `delete`

```bash
# Step 1: Find candidate notes
obsidian search query="customer migration"

# Step 2: Read the top result
obsidian read file="Migration Plan"

# Step 3: Propose action to user
# "Found the migration plan. I can append these action items. Shall I?"

# Step 4: Execute
obsidian append file="Migration Plan" content="..."
```

---

## Workflow: Vault Hygiene

Periodic vault health check:

```bash
# 1. Find orphan notes (no connections)
obsidian orphans

# 2. Find dead-end notes (no outgoing links)
obsidian deadends

# 3. Find broken wikilinks
obsidian unresolved

# 4. Audit tags
obsidian tags counts sort=count

# 5. Count by folder
obsidian files folder="path/to/folder" total
```

Present findings and propose cleanup actions. Never delete or rename without approval.

---

## Workflow: Task Audit

Get a cross-vault view of open tasks:

```bash
# All incomplete tasks
obsidian tasks todo

# Grouped by file with line numbers (useful for follow-up)
obsidian tasks todo verbose

# JSON for structured processing
obsidian tasks todo format=json
```

Present a summarized list, grouped by priority or date. Propose next actions.

---

## Error Handling

| Error | Action |
|-------|--------|
| `command not found: obsidian` | Guide user through CLI registration (see Setup Check above) |
| `Note not found` | Try `obsidian search` to find the correct note name |
| `Obsidian is not running` | Ask user to open Obsidian and retry |
| `Permission denied` | Check CLI registration in Obsidian settings |
| File not found via CLI but exists on disk | CLI only sees notes Obsidian has indexed — open Obsidian to trigger indexing |
| `search`, `version`, and other commands return no output | Installer version mismatch. Run `obsidian version` — if it shows `(installer X.X.X)` with a different version than the app, download the latest installer from obsidian.md/download. Reinstall and restart Obsidian. |
| `vault=<name>` search/read returns nothing | Specifying `vault=` only works for commands that don't require an active app context (e.g. `vault`, `files`). Commands like `search` and `read` require the target vault to be the **currently open** vault in Obsidian. Switch to the vault in the app first, then run without the `vault=` prefix. |

---

## Boundaries

**Always:**
- Follow recommend-first principle — propose actions before executing
- Preserve frontmatter on all note operations
- Use `append` over `create overwrite` when adding to existing notes
- Follow `resources/vault-steering.md` and `resources/vault-defaults.md` naming and folder conventions
- Use bare flags (no `--` prefix)

**Ask First:**
- Before creating, moving, renaming, or deleting any note
- Before appending significant content to planning files

**Never:**
- Use `permanent` delete without explicit user instruction
- Overwrite notes with `overwrite` without confirmation
- Run `obsidian eval` with destructive JavaScript
- Rename or move notes that are linked from many other notes without warning the user about link impact
- Use `tags:rename` (it doesn't exist) — edit files directly instead
