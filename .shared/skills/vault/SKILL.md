---
name: vault
description: Vault file utilities — link graph analysis, temporal inventory, and structural statistics. Load when any skill needs vault-wide file analysis. Invoked as `vault link-graph`, `vault temporal-inventory`, or `vault stats`.
---

# Vault

Shared infrastructure skill providing vault analysis operations. These operations know only about vault structure — markdown files, frontmatter, timestamps, and wikilinks. They have no knowledge of module-specific concepts (nexus index, belief markers, diary format).

All operations output TSV to stdout with a header row. The calling skill performs all analytical reasoning on the data.

**Other skills must invoke vault operations by name — never by script path.** The vault skill manages which scripts back each operation. If the implementation changes, only this skill needs updating.

## Invocation

```
vault link-graph <vault-root> [--scope <folder>] [--min-weight <n>]
vault temporal-inventory <vault-root> [--scope <folder>] [--since <YYYY-MM-DD>] [--until <YYYY-MM-DD>]
vault stats <vault-root> [--scope <folder>] [--format tsv|text]
```

## Operations

---

### `vault link-graph`

Build a wikilink graph from vault markdown files.

**Output columns:** `source`, `target`, `weight`

- `source` — file containing the link (relative path, no `.md` extension)
- `target` — wikilink target as written (aliases and heading anchors stripped)
- `weight` — number of times source links to target

**Options:**

| Option | Default | Description |
|--------|---------|-------------|
| `--scope <folder>` | — | Restrict to a subfolder of vault-root; output paths relative to that folder |
| `--min-weight <n>` | `1` | Only emit edges with weight ≥ n |

**Used by:** nexus lint, nexus map, nexus connect, nexus link, nexus trace

---

### `vault temporal-inventory`

Build a time-ordered inventory of vault markdown files.

**Output columns:** `date`, `file`, `doctype`, `status`, `word_count`

Date resolution order: frontmatter `date`/`created` → filename date prefix → file mtime.

**Options:**

| Option | Default | Description |
|--------|---------|-------------|
| `--scope <folder>` | — | Restrict to a subfolder of vault-root; output paths relative to that folder |
| `--since <YYYY-MM-DD>` | — | Include only files dated on or after this date |
| `--until <YYYY-MM-DD>` | — | Include only files dated on or before this date |

**Used by:** nexus trace, insight temporal, insight scan, insight align

---

### `vault stats`

Structural statistics for a vault or vault subfolder.

**Output (default `text`):** human-readable summary
**Output (`--format tsv`):** `metric`, `value`

**Metrics reported:**

| Metric | Description |
|--------|-------------|
| `total_files` | Total markdown file count |
| `total_words` | Approximate total word count (frontmatter excluded) |
| `unique_doctypes` | Number of distinct `docType` values seen |
| `unique_statuses` | Number of distinct `status` values seen |
| `tagged_files` | Files with at least one `#tag` or frontmatter `tags` field |
| `orphan_files` | Files with no outgoing wikilinks |
| `date_range_first` | Earliest file date |
| `date_range_last` | Most recent file date |
| `files_no_date` | Files where date could not be determined |

**Options:**

| Option | Default | Description |
|--------|---------|-------------|
| `--scope <folder>` | — | Restrict to a subfolder of vault-root |
| `--format tsv\|text` | `text` | Output format |

**Used by:** nexus map, insight orient, insight scan

---

## Operation Routing

| Invocation | Script |
|------------|--------|
| `vault link-graph` | `scripts/vault-link-graph` |
| `vault temporal-inventory` | `scripts/temporal-inventory` |
| `vault stats` | `scripts/vault-stats` |

Scripts live at `.shared/skills/vault/scripts/`. Routing is managed here — callers never reference script paths directly.

---

## Deferred Operations

**`vault diary-scan`** — Extracts diary content by pattern (date range, keyword, section header). Belongs in `zettledeck-praxis/skills/diary/scripts/` because it requires diary path configuration and diary file structure knowledge from the praxis module. Used by: insight orient, insight align, insight promote, future praxis modes.
