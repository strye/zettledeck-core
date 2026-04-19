---
title: Layer 2 — Accommodations
description: Customizing personal-accommodations.md — the file that defines how the assistant works with you. Communication style, executive function support, sensory and energy management, correspondence coaching.
---

# Layer 2 — Accommodations

> **Layer 2 of 4.** Accommodations load after Profile but before Personality. This is deliberate — the persona should build on top of your communication rules, not over them. See [[README|The Personal Assistant]] for the full architecture.

## What Accommodations is for

`personal-accommodations.md` defines *how* the assistant communicates with you. Not the voice (that's Personality) and not the operational behavior (that's the PA Framework) — the working rules that govern every interaction.

The file covers any combination of:

- **Communication preferences** — how you want questions asked, how output should be structured, what counts as "too much"
- **Executive function support** — transitions between tasks, getting unstuck, focus and break management
- **Authenticity and style protection** — keeping the assistant from policing your natural communication style
- **Sensory and energy management** — factoring your environment and capacity into recommendations
- **Correspondence social translation** — interpreting inbound messages, tone-checking outbound ones

The shipped version includes examples of all of these. Not all of them will apply to you. Some that aren't in there yet probably should be. Accommodations is meant to be edited.

## The philosophy

Accommodations is where you tell the assistant what *works for you*, with the explicit permission to be specific and personal. The template ships with ASD-1 accommodation rules as a worked example because that was the author's starting point, but the structure is intentionally flexible.

**You don't need to label yourself as anything.** There is no requirement to identify, disclose, or name a diagnosis here. Write the rules that help you work well. If those rules happen to be neurodivergent-friendly, that's fine. If they're just professional preferences, that's also fine. If they're shaped by your culture, your role, your past work experiences — all fine.

The assistant will treat whatever you write here as constraints to respect. It will not ask why.

## The keep-prune-add approach

Three moves, in order:

### 1. Keep

Read through the shipped version. For every rule, ask: **does this apply to me?**

Rules worth keeping usually:
- Describe a preference you genuinely have
- Name a behavior you wish more systems respected
- Feel obvious when you read them ("yes, obviously that's how I'd want it")

Highlight or copy these. You'll keep them roughly as written, possibly with small wording tweaks.

### 2. Prune

For every rule that *doesn't* apply, delete it. Do not keep rules "just in case." A rule that doesn't apply to you is just context-window cost in every session.

Common things to prune if they don't apply:
- The 90-minute hyperfocus threshold (adjust the number or remove the whole section)
- Sensory/environmental adjustments (if you don't need them, cut them)
- Specific phrasings from the shipped examples that just don't match your style

Be ruthless. Accommodations should contain only rules that earn their place.

### 3. Add

Think about the ways systems have frustrated you. What patterns recur? Every frustration is a missing rule.

Prompts to surface missing rules:

- *What assistant behaviors have you actively disliked in the past?* Each one is a "never do X" rule.
- *What working conditions do you need?* Each one is a "when I say X, do Y" rule.
- *What kinds of feedback land well and which don't?* Each distinction is a rule.
- *What do you need during hard times?* "When I say I'm stressed, don't X, do Y."
- *What's worked in the past with good managers or collaborators?* Those implicit practices can become explicit rules here.

Every new rule should have:
- A clear trigger (when does this apply?)
- A clear directive (what should the assistant do or not do?)
- Optional: an example, if the rule could be misinterpreted

## The shipped sections, explained

### Communication Rules

The rules that govern every message. Default behaviors for question batching, output structure, explicit suggestions.

**Common customizations:** the question batch size (the default is 3), whether to prefer lists or prose by default, how direct the phrasing should be.

**If you are going to edit only one section, this is the one.** These rules fire in every single interaction. Getting them right has the biggest effect.

### Executive Function Support

Rules for task transitions, getting unstuck, and hyperfocus break management.

**Common customizations:** the hyperfocus break threshold (90 min by default — adjust to your actual pattern, or remove entirely), the "getting unstuck" micro-step approach (some people want more explanation, some want less), whether the assistant should volunteer transition prompts or wait to be asked.

**Remove entirely if:** you don't need this kind of support. Not everyone does. The section adds context-window cost and shouldn't be carried if it doesn't apply.

### Authenticity and Style

Protects your natural communication style. Prevents the assistant from rewriting your voice into something more "polished" or "professional" than you actually are.

**Common customizations:** if you *want* polishing help on certain kinds of writing, add an exception. "Polish outbound executive summaries; leave everything else in my voice."

**Especially important if:** you're blunt, terse, unconventional in phrasing, or culturally distinct in how you write. Generic assistants default to corporate-professional English. This section is the counterweight.

### Sensory and Energy Management

Rules for adjusting recommendations based on environment and capacity. Asking about state before pushing; respecting sensory limits; adapting plans to the reality of the day.

**Common customizations:** the specific environment questions (noise? temperature? light? interruptions?), the rules for what to do when you're depleted, whether the assistant should ask about your state unprompted or wait for you to mention it.

**Remove entirely if:** not relevant. This section shines for people whose capacity varies noticeably day to day. If yours doesn't, it's just overhead.

### Correspondence Social Translation

Interpretation help for inbound messages and tone-checking for outbound ones. The rules govern both — how the assistant reads emails *to* you, and how it reviews drafts *from* you.

**Common customizations:** the level of subtext interpretation (some people want more, some less), what counts as a "misunderstanding risk" worth flagging, whether directness should ever be softened (the default is "never unless I ask").

**Keep if:** you ever ask an assistant to help with professional correspondence. Almost everyone does eventually. This section makes that assistance reliable instead of generic.

### Boundaries — Accommodations

The hard "never" list. Things the assistant must never do regardless of any other rule.

**Common customizations:** add any additional hard lines. Common ones:
- "Never suggest I'm not being productive enough."
- "Never tell me to take a break unless I've been going for more than X minutes."
- "Never bring up [specific sensitive topic] unless I bring it up first."
- "Never reference past mistakes when discussing current work."

Keep this section short. Hard lines are expensive — every one constrains the assistant's ability to be useful in some edge case. Only add rules that genuinely protect your wellbeing or working style.

## A rule-writing template

If you're struggling to phrase a new rule, try this form:

```
**{Short label}.** When {trigger}, {directive}. {Optional: example or reasoning.}
```

Examples:

> **Question timing.** When I'm in focus mode, do not ask clarifying questions unless the task can't proceed without them. Capture the question for after the session.

> **Follow-up phrasing.** When I haven't responded to a suggestion, do not re-propose it with different words. I heard it the first time. Ask once, then proceed or pivot.

> **Framing hard news.** When delivering bad news or flagging a problem, lead with the issue directly. Do not soften with context first — it makes the actual problem harder to find.

The short label makes the rule scannable. The trigger gives the assistant a clear place to apply it. The directive is unambiguous. The example prevents misinterpretation.

## Keeping Accommodations current

Edit Accommodations when:

- A rule fires but produces the wrong behavior → refine the rule
- A recurring frustration appears that isn't covered → add a rule
- A rule never seems to apply → consider removing it
- Your working style shifts (new job, new team, new life situation) → review the whole file

Revisit every few months regardless. Accommodations drift as you do. What was right six months ago may not be right now.

## A test for good Accommodations

When you re-read your Accommodations file, you should feel like it describes how you actually prefer to work — not how you think you *should* prefer to work, and not how the template's author prefers to work. If you see rules that aren't yours, prune them. If you notice patterns in your work that aren't in the file, add them.

The goal is a file where every rule would make you nod if someone read it back to you.

---

**Next reading:**

- [[personality|Layer 3 — Personality]] — how the assistant should sound (building on top of these rules)
- [[profile|Layer 1 — Profile]] — who you are
- [[README|The Personal Assistant]] — back to the guide index
