---
title: Layer 4 — PA Framework
description: Customizing personal-assistant.md — the operational layer. RITMO, Getting Things Done, Ruthless Priorities, and the daily, weekly, and quarterly review sequences that run your actual week.
---

# Layer 4 — PA Framework

> **Layer 4 of 4.** PA Framework loads last because it inherits voice, style, and accommodation rules from the three layers above. The framework operates *through* the persona, constrained by your accommodations, personalized by your profile. See [[README|The Personal Assistant]] for the full architecture.

## What PA Framework is for

`personal-assistant.md` is the operational layer. It's what the assistant actually *does*:

- Captures, clarifies, and organizes tasks using **Getting Things Done (GTD)**
- Matches work to energy and protects focus using **RITMO**
- Prioritizes strategically using **Ruthless Priorities**
- Runs your **daily planning** (morning routine and end-of-day shutdown)
- Runs your **weekly review**
- Runs your **quarterly Ruthless Priority review**
- Helps with **meeting notes summarization**
- Helps with **correspondence**

Of the four layers, this is the one you are least likely to edit. The frameworks are well-established, the review sequences are battle-tested, and the operational rules compose with the other three layers without friction.

Most users edit Layer 4 only when their vault paths differ from the defaults.

## The three frameworks, briefly

### RITMO

A rhythm-based productivity philosophy. Match work to energy. Build habits through gentle consistency. Use focused sessions to protect deep work. The core principles are rhythm over rigidity, focused sessions, calm consistency, retroactive honesty, gamification as motivation not pressure, and energy awareness.

RITMO is the *how* of executing — the posture the assistant takes toward any given work session.

### Getting Things Done (GTD)

The structural backbone for managing work. Five stages applied naturally in conversation:

1. **Capture** — get everything out of your head
2. **Clarify** — actionable or not? what's the next physical action?
3. **Organize** — next actions by context, projects, waiting-for, calendar, someday/maybe, reference
4. **Reflect** — daily and weekly reviews
5. **Engage** — choose what to work on by context, time, energy, priority, interest

GTD is the *structure* of managing work. The assistant applies it without making you think about it — when you mention a task in passing, it captures; when you describe a multi-step outcome, it treats it as a project.

### Ruthless Priorities

The strategic filter above GTD and RITMO. The hierarchy:

```
Ruthless Priorities (1–3, quarter/half-year horizon)
  └── Projects (GTD — multi-step outcomes that serve an RP)
       └── Next Actions (GTD — single steps)
            └── Focus Sessions (RITMO — how you execute)
```

Key principles:
- An RP is something so important you refuse to put it at risk.
- If you didn't make progress on it, it wasn't a Ruthless Priority.
- Being ruthless means explicitly saying "no" or "later" to things that could put your RPs at risk — and recording what you said no to.
- RPs require dedicated, protected resources. An RP without protected time is just a wish.

RPs are the *why* — they tell the assistant which work is protected and which is negotiable.

Together: RPs decide what matters, GTD structures how it gets tracked, RITMO governs how it gets executed.

## What the assistant does with all this

The framework wires the three systems into concrete routines:

- **Morning routine** — 6-step fixed sequence (calendar check, carry-forward, top 3, time-block suggestion, energy check, one focus intention)
- **End-of-day shutdown** — 6-step fixed sequence (review what got done, capture loose threads, update task list, check tomorrow, set one intention, close out)
- **Weekly review** — 9-step fixed sequence (inbox, projects, next actions, waiting-for, past calendar, upcoming calendar, someday/maybe, wins, intentions for next week)
- **Quarterly RP review** — 7-step fixed sequence against Azzarello's test, revisit parked RPs, update the registry
- **Meeting notes summarization** — summary + key decisions + action items + open questions + reference notes
- **Correspondence assistance** — clarify intent first, structure for scannability, suggest don't send, follow-up tracking

The sequences are fixed by design. The user always knows what step comes next. Within each step, the assistant adapts to the day's context — but the scaffolding stays the same.

## What to customize

For most users, customization is limited to path references. A few areas worth considering:

### Path references

The framework mentions specific paths like `Praxis/ruthless-priorities/ruthless-priorities.md`. If your vault uses different paths — or you've renamed workspace folders — update the references.

**Where to look:** the "Strategic Layer: Ruthless Priorities" section at the top, and anywhere else a concrete path is mentioned.

**Easier alternative:** `/zettledeck.init core` handles workspace folder renames by updating config roles. Skills resolve paths at runtime via role, so renaming a folder doesn't require editing this file. If you're just renaming, use the init wizard.

### Focus session defaults

The default is Pomodoro-style 25/5. If you use different intervals (45/15, 90/10, or a flow-state approach without breaks), update the RITMO "Focused sessions" bullet.

### Review cadences

The default quarterly RP review cadence can be changed to monthly, bi-monthly, or whatever fits your role. Update the "default cadence" line in the Quarterly RP Review section.

### Contingency plans

The "if pulled into an unplanned meeting," "if context is lost mid-task," and "if energy crashes mid-day" responses can be tailored if your own patterns are different. Some users need a different approach for energy crashes; some don't use calendar-disruption triggers at all.

### Correspondence defaults

The "be concise," "clarify intent first," "structure for scannability," "suggest don't send" rules are defaults. If your correspondence context is different — for example, you write long-form letters rather than business emails — adjust accordingly.

## What not to customize

Some parts of the framework are load-bearing and should stay:

- **The five GTD stages.** They're canonical and they work. Don't rename them.
- **The fixed sequence of the routines.** The whole point of the morning routine and weekly review is that the steps are the same every time — that's what makes them usable under varying energy and stress. If you start tailoring the order, you lose the scaffolding effect.
- **The RP hierarchy.** RP → project → next action → focus session is how the frameworks compose. Breaking the hierarchy breaks the filtering.
- **The "never do X" rules.** Things like "never prioritize busywork," "never assume context you don't have," "never let a full work week pass without surfacing RP progress" are there to prevent specific failure modes. Cut them only with clear cause.

## If you want to swap frameworks entirely

You can. If GTD + RITMO + RPs doesn't fit how you work, replace the PA Framework file wholesale with your own system. Examples:

- **Bullet Journal + Eisenhower Matrix** — if you're more tactile and less computational, the Bullet Journal's rapid logging and monthly/weekly migration pairs naturally with Eisenhower priority quadrants.
- **OKRs + Scrum-style sprints** — if your work is genuinely goal-based and time-boxed, OKRs can replace RPs and sprint planning can replace weekly reviews.
- **Deep Work + Time Blocking** — if you want a minimal system focused on protecting deep work time, Cal Newport's Deep Work principles plus aggressive time blocking is a viable Layer 4.
- **Your team's existing methodology** — if you're already inside a product-management or engineering framework (Shape Up, Shape Up-adjacent, etc.), encode *that*.

The requirements for any Layer 4 replacement:

1. It has to be a coherent system (not a grab-bag of rules).
2. It has to define at least one regular review cadence (daily, weekly, or both).
3. It has to have a prioritization mechanism — something above next-actions that tells the assistant what to protect.
4. It has to fit on top of Accommodations (the communication rules) and Personality (the voice) without conflict.

## The "do not touch skill files from here" rule

Layer 4 is read into every session as steering. It should not contain project-specific paths that get rewritten by init — those live in `.zettledeck/{module}/config.json` and are read at runtime by skills.

If you find yourself wanting to encode project-specific config in this file, stop and check: does the relevant skill already read a config value? If so, use `/zettledeck.init` to set it rather than hardcoding here. If not, consider whether a skill should be reading a config value.

## Keeping the framework current

Edit Layer 4 when:

- Your vault paths change and you're not using the init wizard
- Your working rhythms shift enough that the focus-session defaults or review cadences no longer fit
- You adopt a new framework element (a different prioritization method, a new review step) that you want running every session
- The assistant is running a sequence and a step consistently doesn't apply — consider removing the step rather than ignoring it

Do not edit Layer 4 when:

- A single-session context needs changing (that's conversational context, not steering)
- A specific project has different rules (that's project-level CLAUDE.md or `.zettledeck/` config)
- You want a voice change (that's Personality)
- You want a communication rule change (that's Accommodations)

## A test for a good PA Framework

The assistant should be able to run your morning routine, your weekly review, and your quarterly review *without asking you what the steps are.* If the assistant ever asks "what step comes next?" — the framework is failing at its job. The steps should be baked in.

Conversely, the assistant should never run a step that isn't in your framework. If it invents a step, the framework needs tightening, or you need to add the step explicitly.

---

**Next reading:**

- [[portability|Portability]] — using these files outside ZettleDeck
- [[personality|Layer 3 — Personality]] — the voice the framework operates through
- [[README|The Personal Assistant]] — back to the guide index
