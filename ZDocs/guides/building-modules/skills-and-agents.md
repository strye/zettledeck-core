---
title: Skills & Agents
description: The behavioral assets a module ships — skills (on-demand), agents (addressable personas), and steering (always-on rules).
---

# Skills & Agents

The three asset types that give your module its *behavior*. Each is loaded into the agentic tool (Claude Code, Kiro) at a different scope: skills load on demand, agents are invoked explicitly, steering applies always.

## `skills/`

Each subdirectory is one skill. The directory name becomes the skill name in `.shared/skills/`.

**Installed to:** `.shared/skills/{skill-name}/`

**Install behavior:** Directory copied recursively. Skipped if a skill with the same name already exists.

**Update behavior:** Entire directory replaced — the module owns the skill wholesale.

### Format

```
skills/
└── {skill-name}/
    ├── SKILL.md           # Required — skill definition
    └── resources/
        ├── {mode-a}.md    # Mode-specific instructions
        └── {mode-b}.md
```

**SKILL.md frontmatter:**

```markdown
---
name: skill-name
description: Trigger description — what Claude reads to decide whether to load this skill
---
```

The `description` field is critical — it determines when Claude auto-triggers the skill. Be specific. Generic descriptions (`"help with writing"`) fail silently; specific ones (`"invoke when editing diary files or working with weekly-review templates"`) get picked up reliably.

### Mode routing

Larger skills use the mode-routing pattern. `SKILL.md` dispatches to mode-specific resource files based on the invocation argument. See [[modules/core/skills|Core Skills]] for examples from the shipped skills (`zettledeck`, `zettledeck.init`).

The pattern keeps `SKILL.md` small (it carries only the routing logic) and moves the detailed instructions into `resources/` where each mode gets its own file. Only the resource for the invoked mode gets loaded — context window stays tight.

## `agents/`

Agent markdown definition files. Each `.md` becomes an addressable agent that can be invoked explicitly.

**Installed to:** `.shared/agents/`

**Install behavior:** Each `.md` file copied. Skipped if an agent with the same name already exists.

**Update behavior:** Each `.md` file overwritten.

After install/update, `zd` auto-wires agents for Kiro (symlink + companion `.json`). Claude Code uses the `.claude/agents → .shared/agents` symlink, so no per-agent wiring is needed there.

Agents are for *personas* — a specialist with its own voice and domain that the user can summon by name. Bob, the default ZettleDeck assistant, is an agent. A research specialist with deep domain knowledge and a distinct voice would be an agent. If your module introduces a distinct mode of working with a clear personality, put it in `agents/`.

## `steering/`

Always-on steering files loaded into every session by Claude Code or Kiro. Use this for rules that must apply in *every* session, not just when a skill is invoked.

**Installed to:** `.shared/steering/`

**Install behavior:** Each `.md` file copied. Skipped if already exists.

**Update behavior:** Each `.md` file overwritten.

**Be sparing here.** Steering content is paid-for context window on every invocation. Prefer skills (loaded on demand) over steering (loaded always) unless the rule genuinely applies universally.

Good steering: universal markdown conventions, always-on safety rules, the core ZettleDeck workspace map that every session needs.

Bad steering: skill-specific instructions, detailed workflows, domain reference. All of those belong in skills.

---

**Next reading:**

- [[module-config|`module-config.json`]] — the config merge system your behavioral assets often depend on
- [[project-assets|Templates, Scaffolding & Scripts]] — the non-behavioral assets your module ships
- [[user-config|Init & Note Rules]] — the user-facing surfaces for configuring your skills at runtime
