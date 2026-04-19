---
title: zettledeck-core Reference
description: What zettledeck-core ships, the project structure it produces on disk, and where to find detailed documentation for each component.
---

# zettledeck-core Reference

Authoritative reference documentation for `zettledeck-core` — the foundation module that ships with every ZettleDeck project. For the big-picture philosophy see [[theWay|The Way]]; for how knowledge is organized inside the Reliquary see [[vault-structure|Vault Structure]]; this page and its companions are about what the template itself contains.

## What core provides

Core is the minimum viable ZettleDeck. Five things come out of the box:

- **A project template** — clone it and you have a runnable ZettleDeck vault.
- **A module composer** — [[zd-script|`zd`]], the CLI that installs add-on modules and wires them into Claude Code or Kiro.
- **An init system** — the `/zettledeck.init` skill that walks you through configuring vault structure, document types, and module-specific settings.
- **Core skills** — four skills loaded by default: `zettledeck` (methodology + promote), `zettledeck.init` (setup), `markdown` (conventions), `vault` (file analysis). See [[skills|Core Skills]].
- **The four-layer personal assistant** — identity, accommodations, personality, and PA framework, loaded every session. See [[personal-assistant/README|The Personal Assistant]].

Core also scaffolds three workspace folders at the project root: `Atelier/`, `Chrysalis/`, and `Reliquary/`. These are the minimum capture-incubate-keep flow. Other workspaces (Praxis, Foundry, Nexus, Scriptorium, Tesseract) are scaffolded by their respective add-on modules.

## Project structure

What a ZettleDeck project looks like after `zd setup` has run:

```
my-vault/
├── .shared/                           # Shared assets (hidden from vault; tool-neutral)
│   ├── assistant/                     # Four-layer personal-assistant personality
│   │   ├── personal-profile.md           Who the user is
│   │   ├── personal-accommodations.md    How to communicate with the user
│   │   ├── assistant-personality.md      The assistant's voice and modes
│   │   └── personal-assistant.md         GTD / RITMO / review frameworks
│   ├── skills/
│   │   ├── markdown/                  Markdown + task format conventions
│   │   ├── zettledeck/                Methodology — help, promote, vault rules
│   │   ├── zettledeck.init/           Interactive project setup
│   │   └── vault/                     Link graph, temporal inventory, vault stats
│   ├── agents/                        Agent definitions (populated by modules)
│   ├── steering/                      Steering files
│   ├── templates/                     Template files (populated by modules)
│   └── settings/
│       └── mcp.json                   Merged MCP server definitions
├── .zettledeck/                       # Infrastructure (hidden from vault)
│   ├── zettledeck.yml                 Module manifest — declare add-on modules
│   ├── core/config.json               Core vault configuration
│   ├── init-state.yml                 Init tracking (created by zd / init)
│   ├── {module}/init-steps.md         Init steps contributed by each module
│   ├── {module}/note-rules.md         Note-taking rules contributed by each module
│   ├── providers/                     Capability provider definitions
│   └── scripts/
│       ├── bootstrap                  Installs jq + yq
│       └── zd                         Module composer CLI
├── .claude/                           # Claude Code wiring (created by zd setup)
│   ├── skills → ../.shared/skills
│   └── agents → ../.shared/agents
├── .kiro/                             # Kiro wiring (created by zd setup)
│   ├── skills → ../.shared/skills
│   ├── steering → ../.shared/steering
│   ├── settings → ../.shared/settings
│   └── agents/                        Individual symlinks + generated JSON
├── .mcp.json → .shared/settings/mcp.json   (Claude Code only)
├── AGENTS.md                          Declares the default agent and load order
├── Atelier/, Chrysalis/, Reliquary/   Workspace folders (core scaffolds these)
└── README.md
```

Add-on modules scaffold their own workspace folders (`Praxis/`, `Nexus/`, `Foundry/`, `Scriptorium/`, `Tesseract/`) non-destructively at install time.

### Why the split between `.shared/` and `.zettledeck/`

The two directories look similar — both are hidden from the vault, both hold infrastructure — but they serve different purposes.

- **`.shared/`** holds content the *agentic tool* reads: skills, agents, steering, assistant layers, MCP settings. Wiring into Claude Code or Kiro is via symlinks to this directory.
- **`.zettledeck/`** holds content the *`zd` script and the init system* read: module declarations, config, init state, per-module init-steps and note-rules, providers, the `zd` CLI itself.

A rough test: if the agentic tool needs to see it in every session, it's in `.shared/`. If it's consumed by `zd` or `/zettledeck.init`, it's in `.zettledeck/`.

### What's hidden from the vault

Both `.shared/` and `.zettledeck/` are dot-prefixed so they're hidden from Obsidian and most markdown viewers by default. This is deliberate — the infrastructure should stay out of your way when you're browsing your actual knowledge. Neither directory contains vault content; nothing you'd want to browse lives there.

## Where to go next

- [[zd-script|The `zd` script]] — commands, module contribution, requirements, and troubleshooting
- [[skills|Core skills]] — detailed reference for `zettledeck`, `zettledeck.init`, `markdown`, `vault`
- [[configuration|Configuration]] — `.zettledeck/core/config.json` key by key
- [[personal-assistant/README|The Personal Assistant]] — customizing the four-layer assistant
- [[building-modules/README|Building Modules]] — for authors extending what core ships
