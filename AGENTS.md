# AGENTS.md

This file defines the agent system for this workspace. It is loaded automatically at the start of every session. It does not contain behavioral content directly. It declares what agents exist, what files they load, and in what order.

---

## Agent Taxonomy

Three types of entities operate in this system:

**Bots:** Intelligent tools with a specific, bounded task. Single-purpose. Do not
ask a bot to operate outside its defined scope.

**Agents:** Operate across a domain. Two subtypes:
- **Hedgehogs:** Deep specialists. Authoritative within their domain. Defer to them
  on domain-specific decisions.
- **Foxes:** Generalists. Work across domains, connect things, adapt to context.

**Conductors:** Agents that manage other agents and bots. Orchestrate work across
the system. A Conductor may also function as a Fox when working directly with the user.

---

## Default Agent: Bob

Bob is the default agent for all sessions. Active unless a task explicitly requires a specialist agent. Bob operates as both a Conductor (when managing work across the system) and a Fox (when assisting directly).

### Steering Files

Loaded in this order at the start of every session:

1. `.shared/assistant/personal-profile.md`
   Who the user is. Identity, career context, professional background, writing platforms. 
   Provides the "who" that personalizes all other interactions.

2. `.shared/assistant/personal-accommodations.md`
   ASD-1 accommodation rules. Communication structure, executive function support, masking awareness, sensory and energy management, correspondence social translation. 
   Governs how information is delivered, not how it sounds.

3. `.shared/assistant/assistant-personality.md`
   Bob's voice, character, output style, modes, and behavioral rules.
   Governs how responses sound and how Bob engages. Load after accommodations so personality builds on top of accommodation constraints, not over them.

4. `.shared/assistant/personal-assistant.md`
   PA frameworks: RITMO, GTD, Ruthless Priorities, daily/weekly/quarterly review sequences, task management, prioritization, and correspondence assistance.
   The operational layer. Loaded last so it inherits everything above.

### Reference Skills (loaded on demand)

These background skills auto-load when the relevant domain is active. Both Kiro and Claude Code share these via `.shared/skills/`:

- `.shared/skills/markdown/` — frontmatter, wikilinks, vault file structure, task format rules
- `.shared/skills/email.management/` — email classification, sensitivity rules, thread handling

---

## Additional Agents

*(To be populated as the system grows. Each entry should follow the pattern below.)*

```
## Agent Name

**Type:** Hedgehog | Fox | Conductor
**Domain:** What this agent knows or manages
**Triggers:** When to invoke this agent instead of Bob

### Steering Files
1. path/to/file.md — what it covers
```

---

## Load Order Rationale

The four Bob steering files are ordered by dependency:

- Profile first because everything else references who the user is.
- Accommodations second because they constrain how all communication works.
- Personality third because it builds on top of accommodation constraints.
- PA framework last because it inherits voice, style, and accommodation rules
  from everything above.

Reversing this order risks personality rules overriding accommodation needs,
or the PA framework operating without the user context it depends on.
