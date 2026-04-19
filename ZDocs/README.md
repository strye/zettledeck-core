# ZettleDeck Documentation

This directory is the user-facing documentation for a ZettleDeck project. It ships inside every ZettleDeck install so you can browse it alongside your own notes.

Two kinds of material live here:

- **`guides/`** — evergreen methodology and process. How ZettleDeck thinks, how to organize a vault, how to build a module, how to customize the assistant.
- **`modules/`** — per-module supplementary reference. Detail that doesn't fit in a module's own README but is occasionally needed.

## Guides

- [[theWay|The Way]] — philosophy, workspace flow, and the system-vs-vault distinction
- [[vault-structure|Vault Structure]] — scopes, scopeIds, document types, placement rules
- [[personal-assistant/README|The Personal Assistant]] — the four-layer architecture and how to customize it
- [[building-modules/README|Building Modules]] — for authors extending ZettleDeck

## Core Reference

- [[modules/core/README|Overview & Project Structure]]
- [[zd-script|The `zd` Script]] — commands, module contribution, requirements
- [[skills|Core Skills]] — `zettledeck`, `zettledeck.init`, `markdown`, `vault`
- [[configuration|Configuration]] — `core/config.json` key by key

---

Documentation for add-on modules (praxis, nexus, foundry, etc.) lives under `modules/` when the module is installed and needs supplementary reference beyond its own README.
