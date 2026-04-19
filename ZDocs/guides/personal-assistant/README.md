---
title: The Personal Assistant
description: The four-layer assistant architecture — identity, accommodations, personality, and PA framework — and how to customize it into something genuinely personal.
---

# The Personal Assistant

ZettleDeck ships with a four-layer personal assistant that loads into every session. Out of the box it comes with a sample persona (Bob), placeholder profile content, and ASD-1 accommodation rules as a starting point. *None of that is yours yet* — the template is scaffolding, and making the assistant feel genuinely personal is the point.

This guide walks you through each layer: what it does, why it exists, and how to customize it into something that actually fits you.

## The four layers

Your assistant is composed of four files. They load in order at the start of every session and answer four different questions:

```
assistant/
├── personal-profile.md           # Layer 1: Who am I?
├── personal-accommodations.md    # Layer 2: How should it treat me?
├── assistant-personality.md      # Layer 3: How should it sound?
└── personal-assistant.md         # Layer 4: What does it do?
```


| Layer | File                         | Answers                                   |
| ----- | ---------------------------- | ----------------------------------------- |
| 1     | `personal-profile.md`        | Who am I?                                 |
| 2     | `personal-accommodations.md` | How should the assistant treat me?        |
| 3     | `assistant-personality.md`   | How should it sound?                      |
| 4     | `personal-assistant.md`      | What does it do (GTD / RITMO / reviews)?  |

All four files carry `inclusion: always` in their frontmatter. Your AI tool loads them automatically into every conversation.

## Why four layers

You could jam everything into one massive system prompt. People do. It works, sort of, until you want to change something — at which point editing a 2000-line prompt to tweak one behavior is a mess.

Four layers let you change one concern without touching the others:

- **Update your job title** → edit Profile. Personality, accommodations, and framework are unaffected.
- **Change assistant voices** → swap Personality. Everything about *you* stays put.
- **Add a new accommodation** → add a rule to Accommodations. The persona doesn't notice.
- **Adjust the daily review sequence** → edit PA Framework. Voice and identity unchanged.

Separation of concerns, applied to a system prompt. Each layer has one job. Each job has one owner.

## Load order matters

The files load in this order:

1. **Profile first** — the user's identity is the foundation. Everything else references who you are.
2. **Accommodations second** — the rules that constrain *how* communication works, before any voice gets layered on top.
3. **Personality third** — the voice builds on top of the accommodations, not over them. The persona has to respect your communication rules, not the other way around.
4. **PA Framework last** — the operational layer inherits voice, style, and accommodation rules from everything above.

Reversing this order risks personality rules overriding accommodation needs, or the PA framework operating without the user context it depends on. The order is wired into `AGENTS.md` at the project root — you don't have to manage it, but it's worth knowing.

## How to customize — recommended order

You customize in roughly the opposite order from how the layers load. Start with what's most broken in the template, work toward what's most already-right.

### Start with Layer 1 — Profile

**Why first:** everything else references your identity. A good profile turns generic recommendations into context-aware ones.

**What to do:** fill in every section with your actual information. The template ships with nothing but placeholders. Spend real time on "Career Themes" and "Working Style" — these are the sections that pay the most dividends.

→ [[profile|Layer 1 — Profile]]

### Then Layer 3 — Accommodations

**Why second:** this is where you tell the assistant how to treat you. Communication style, executive function needs, energy management, how to handle your correspondence. Without this, the assistant defaults to generic "helpful assistant" behavior.

**What to do:** the template ships with ASD-1 accommodation rules as a worked example. Keep what applies, remove what doesn't, add what's missing. You don't need to label yourself as anything — just write the rules that help you work well.

→ [[accommodations|Layer 2 — Accommodations]]

### Then Layer 3 — Personality

**Why third:** by now the assistant knows you and knows how to treat you. Time to decide how it sounds.

**What to do:** the template ships with "Bob" as a worked example — a persona based on the Church of the SubGenius. Bob is complete and functional but very specific; you'll probably want to replace him with something of your own. Keep the structure (identity, character, vocal tics, modes) and fill it in.

→ [[personality|Layer 3 — Personality]]

### Layer 4 — PA Framework usually stays

**Why last:** this layer encodes GTD + RITMO + Ruthless Priorities. The frameworks are well-established and generic — most users need no edits beyond updating vault path references if their structure differs.

**What to do:** read it to understand what your assistant knows how to do. Edit only if you want to swap frameworks or your vault paths don't match the defaults.

→ [[pa-framework|Layer 4 — PA Framework]]

### Portability

These files work outside ZettleDeck too. Any agentic tool that accepts a system prompt can use them verbatim.

→ [[portability|Portability]]

## How the four layers are wired in

The file that ties everything together is `AGENTS.md` at the project root. It declares the default agent (Bob, by default) and the order in which the four assistant files load.

A minimal reading: `AGENTS.md` names the agent, lists the four files in load order, and explains what each layer contributes. It's short and worth reading once before you start customizing — you'll see exactly how the layers compose.

Additional specialist agents (a deep-research persona, a code-review persona, etc.) can be declared in `AGENTS.md` alongside Bob. Each agent gets its own list of steering files loaded when it's active. Modules often contribute specialist agents of their own — see [[building-modules/skills-and-agents|Skills & Agents]] for how modules register them.

## The customization philosophy

The goal isn't to produce a perfect assistant on day one. The goal is to produce a useful assistant today and improve it over time.

- **Start imperfect.** An assistant that knows 60% of who you are is dramatically more useful than a generic one. Don't wait to fill in every section.
- **Iterate.** When the assistant does something you wish it wouldn't, open the relevant layer and add a rule. When it repeatedly gives you advice that misses your context, check whether your Profile explains what you do.
- **Be specific.** Vague profiles produce generic assistance. "I'm a Solutions Architect at Amazon who works on ISV customer integrations, and I publish long-form essays on Substack with a dry voice" is infinitely more useful than "I'm a tech worker who writes sometimes."
- **Respect the separation.** When you catch yourself writing a rule, ask which layer it belongs to. A communication rule belongs in Accommodations, not Personality. A framework tweak belongs in PA Framework, not as a Profile note.

## Where these files live

In a ZettleDeck project:

```
.shared/assistant/
├── personal-profile.md
├── personal-accommodations.md
├── assistant-personality.md
├── personal-assistant.md
└── README.md                # Short orientation, same content as this guide's index
```

Symlinked into your tool's steering/agent directory via `zd setup`. You edit the files in `.shared/assistant/`; the symlinks take care of making them visible to Claude Code or Kiro.

---

**Next reading:**

- [[profile|Layer 1 — Profile]] — start here
- [[accommodations|Layer 2 — Accommodations]]
- [[personality|Layer 3 — Personality]]
- [[pa-framework|Layer 4 — PA Framework]]
- [[portability|Portability]] — using these files in any agentic tool
