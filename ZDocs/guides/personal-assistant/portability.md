---
title: Portability
description: Using the four assistant files outside ZettleDeck — they work as verbatim system prompt additions in any agentic tool that accepts a system prompt.
---

# Portability

> One of the most valuable properties of the four-layer assistant is that it isn't locked to ZettleDeck. Each layer works verbatim as a system prompt addition in any agentic tool that accepts a system prompt. A well-designed assistant can follow you between tools. See [[README|The Personal Assistant]] for the full architecture.

## The portability premise

Each of the four files is plain markdown with generic frontmatter. No platform-specific syntax. No ZettleDeck-specific escape sequences. No proprietary directives.

This means:

- The files work as-is in Claude Code, Cursor, Kiro, Claude Desktop, custom GPTs, direct API calls, or any tool that takes a system prompt.
- Moving between tools doesn't require rewriting your assistant — you copy the files.
- You can use the same assistant at work (Claude Code), in a browser (Claude.ai projects), and at the API level (custom scripts) without maintaining three separate configurations.

There's one caveat: the framework file (Layer 4) mentions ZettleDeck-specific paths like `Praxis/ruthless-priorities/`. If you're using the assistant outside a ZettleDeck project, edit those references to point at wherever your equivalent data lives — or remove them and describe your structure in a way that fits the context.

## Using the files in specific tools

### Claude Code / Kiro (inside a ZettleDeck project)

Already wired. `zd setup` symlinks the four files into your tool's steering directory. `AGENTS.md` at the project root declares the load order. Nothing further required.

### Claude Desktop — Projects

Create a Project. For the system prompt or Project instructions, paste the content of all four files in load order (Profile, Accommodations, Personality, Framework). Separate them with clear section markers if the tool preserves markdown rendering.

If the tool has a length limit, start with Profile + Accommodations. Those two do the most personalization work. Add Personality and Framework as room allows.

### Custom GPTs

In the GPT builder, set the Instructions to the concatenation of the four files. Custom GPTs have a hard character limit — you may need to compress. Priorities:

1. **Keep Profile and Accommodations.** These are where most of the personalization is.
2. **Compress Personality.** Keep the archetype, character summary, three or four signature vocal tics, and the "never does" list. Drop the mode detail and long examples.
3. **Strip Framework.** Keep the priority hierarchy and a one-paragraph summary of each framework; drop the step-by-step routines unless you actively use the custom GPT for reviews.

A compressed version typically runs around 60% the size of the uncompressed files and covers 95% of the value.

### Direct API calls

Pass all four files in the `system` parameter, concatenated in load order. If you're caching the system prompt (prompt caching), this setup is a natural fit — the four layers rarely change, so they cache cleanly.

A simple pattern:

```python
system_prompt = "\n\n---\n\n".join([
    open("personal-profile.md").read(),
    open("personal-accommodations.md").read(),
    open("assistant-personality.md").read(),
    open("personal-assistant.md").read(),
])

response = client.messages.create(
    model="claude-sonnet-4-6",
    system=[
        {"type": "text", "text": system_prompt, "cache_control": {"type": "ephemeral"}}
    ],
    messages=[...],
)
```

The cache control annotation turns the four layers into a cached prefix, which dramatically reduces cost and latency for repeated calls.

### Cursor / Continue / other coding agents

Paste the content into whichever instruction surface the tool exposes — `.cursorrules`, custom system prompt, or equivalent. For coding agents specifically, you may want to move the Profile's Technical Identity section earlier in the prompt since coding agents reference it constantly.

### ChatGPT custom instructions (no-project mode)

The "What would you like ChatGPT to know about you?" and "How would you like ChatGPT to respond?" fields map loosely to Profile and Accommodations. Paste the essential bits of each.

You'll lose Personality and Framework in this setup — ChatGPT custom instructions don't have room for everything. For best results, use ChatGPT Projects instead if available.

## The removable frontmatter

Each file ships with YAML frontmatter:

```markdown
---
inclusion: always
name: personal-profile
description: ...
---
```

The `inclusion: always` directive is specific to Kiro's steering loader. Other tools ignore it. It doesn't hurt but it can be removed if you want clean content. Claude Code uses the presence of the file in the steering directory; no directive is needed.

## Running without all four layers

You don't have to use all four. Valid subsets:

- **Profile only** — the assistant knows who you are; sounds and behaves generically.
- **Profile + Accommodations** — personalized and respectful of your working style, no persona, no fixed routines.
- **Profile + Accommodations + Framework** — fully operational for daily/weekly use, neutral voice.
- **Profile + Accommodations + Personality** — personalized, well-voiced, but no opinions about how work gets organized.
- **All four** — the full ZettleDeck assistant.

Pick the subset that fits the tool and the context.

## When to keep files ZettleDeck-only vs. portable

Some users maintain two versions of their assistant:

1. **The ZettleDeck-native version** — uses concrete workspace paths, references specific skills, assumes the full ZettleDeck environment.
2. **The portable version** — paths abstracted, ZettleDeck-specific references removed, ready to drop into any tool.

This is overkill for most users but useful if you genuinely operate across very different contexts (a work laptop with ZettleDeck installed and a personal machine without it). If you maintain both, keep Profile and Personality in sync — they're the same file for both versions. Accommodations usually transfers cleanly too. Only Framework tends to diverge.

## The portability principle

The assistant files are *yours*. They encode your identity, preferences, voice, and operational methodology. That work should not be trapped in any single tool.

Write them well once. Carry them wherever you work.

---

**Next reading:**

- [[README|The Personal Assistant]] — back to the guide index
- [[profile|Layer 1 — Profile]] — the identity layer
- [[accommodations|Layer 2 — Accommodations]] — the working-rules layer
- [[personality|Layer 3 — Personality]] — the voice layer
- [[pa-framework|Layer 4 — PA Framework]] — the operational layer
