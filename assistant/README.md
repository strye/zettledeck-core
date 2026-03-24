# Personal Assistant — Four-Layer Architecture

Your assistant is composed of four files that load together. Each handles a distinct concern. They're separated so you can update one without touching the others.

```
assistant/
├── personal-assistant.md       # Layer 1: The engine — GTD/RITMO framework, planning, reviews
├── assistant-personality.md    # Layer 2: The persona — name, voice, vocal tics, modes
├── personal-accommodations.md  # Layer 3: The accommodations — how to communicate with you
└── personal-profile.md         # Layer 4: The identity — who you are, career, interests
```

## How It Works

All four files carry `inclusion: always` in their frontmatter. Your AI tool loads them automatically into every conversation. Together they answer:

- **What does the assistant do?** → `personal-assistant.md`
- **How does it sound?** → `assistant-personality.md`
- **How does it treat me?** → `personal-accommodations.md`
- **Who am I?** → `personal-profile.md`

## Setup

1. **Start with Layer 4** — fill in `personal-profile.md` with your actual information. Everything else personalizes from it.
2. **Customize Layer 3** — `personal-accommodations.md` ships with ASD-1 rules as a complete example. Keep what applies, remove what doesn't, add what's missing.
3. **Adapt Layer 2** — `assistant-personality.md` ships with Kellog as a sample persona. Replace with your own, or use it as a template to understand the pattern.
4. **Layer 1 probably needs no changes** — the GTD/RITMO engine is generic. The only edits are path references if your vault structure differs.

## Portability

These files are designed to work verbatim as system prompt additions in any agentic tool — Claude Code, Cursor, API calls, custom GPTs, or any platform that accepts a system prompt. No platform-specific syntax. Load them and they work.

Place the files in `.shared/assistant/` and symlink from each tool's steering/agent directory.

## Layer Reference

| Layer | Customize | Why |
|-------|-----------|-----|
| `personal-assistant.md` | Rarely — only vault paths | GTD/RITMO rules are generic and complete |
| `assistant-personality.md` | Fully — this is your assistant's voice | Kellog is one example; design your own |
| `personal-accommodations.md` | Partially — keep what applies, add what's missing | ASD-1 rules are comprehensive starting points |
| `personal-profile.md` | Fully — replace all placeholders with your info | Nothing in the template is yours yet |
