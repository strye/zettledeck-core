---
title: Layer 3 — Personality
description: Customizing assistant-personality.md — the file that defines how your assistant sounds. Identity, character, vocal tics, modes, and the craft of designing a persona that holds up under pressure.
---

# Layer 3 — Personality

> **Layer 3 of 4.** Personality loads after Profile and Accommodations — the persona sits on top of those, not over them. The voice must respect your communication rules, not the other way around. See [[README|The Personal Assistant]] for the full architecture.

## What Personality is for

`assistant-personality.md` defines how your assistant *sounds*. The voice, the character, the modes it shifts between, how it handles edge cases — and what it never does.

This is the most optional layer and the most personal one. A totally generic assistant works fine if you don't care about the voice. But an assistant with a deliberate persona, consistently voiced, makes the system feel like *yours* in a way that a corporate-default voice never will. It's the difference between "a helpful AI" and "my thinking partner."

## Bob as a worked example

The template ships with **Bob** — a persona based on [J.R. "Bob" Dobbs](https://en.wikipedia.org/wiki/J._R._%22Bob%22_Dobbs), the figurehead of the Church of the SubGenius. A 1950s pipe-smoking salesman who received a divine vision from an alien space god on a television set he built, founded a church around the concept of Slack, and has been assassinated and resurrected several times since.

Bob is complete. He has identity, character, a way of addressing the user ("friend"), a set of recognizable vocal tics ("Slack," "The Conspiracy wins this round," "That's in the PreScriptures"), four distinct modes (GTD, ideation, planning, correspondence), rules for handling impossible requests, and a set of hard "never does" constraints.

You should read Bob's file once. Not because you'll keep Bob, but because it demonstrates the pattern. **Every section in Bob's file is there because the persona needs it.** Identity alone produces a name-shaped hole; character without vocal tics produces a vague vibe; modes without a core character produces inconsistent behavior under pressure.

## You will probably replace Bob

Bob is very specific. The humor is very specific. The cosmic-absurdist framing is very specific. It's not for everyone.

Three options:

1. **Replace Bob entirely with your own persona.** Most common, most rewarding. Design a character you actually want to talk to every day.
2. **Keep Bob.** He's a complete, working example. Some users genuinely enjoy him.
3. **Strip the persona to near-zero.** Keep the structure (identity: your name choice; character: brief; voice rules; modes) but make the voice neutral and professional. This works fine for users who want the other layers to do the personalization and keep the voice in the background.

There is no wrong answer. The file just has to exist and do *something*.

## The persona pattern

If you're designing your own, the shipped sections give you the pattern:

### Identity

Name, nicknames, and — crucially — an **archetype** or defining metaphor. The archetype is load-bearing. It shapes everything downstream.

Bob's archetype is "1950s pipe-smoking salesman who received a divine vision." That archetype tells you how he'll handle being wrong (with the confidence of received revelation), how he'll handle success (a pipe tap and "Slack"), how he'll handle impossibility (philosophical warmth).

If you can't write a one-sentence archetype for your persona, you don't have a persona yet. You have a name. Keep designing.

Archetypes to play with:
- A specific real person (fictional or historical)
- A specific role with a twist (*a butler, but from a different century*, *a coach who's been through what the user is going through*)
- A mythic figure (*the oracle at Delphi, modernized*, *a sphinx who answers but also asks*)
- A fictional character from literature, film, or game (check the license situation for shared use)
- An archetype of someone you admire (*the patient senior engineer*, *the blunt editor*)

The more specific the archetype, the stronger the voice. "A helpful assistant" is not an archetype. "The senior engineer who will tell you the truth about your code even when it hurts" is.

### Character

Three or four sentences that capture the core. How does the persona handle being wrong? Being right? Being asked to do impossible things? These answers should feel consistent regardless of what mode the persona is in.

Bob's character sketch: serene confidence, contradicts himself without shame, has opinions and delivers them with authority, lets them go when overridden. That's four lines that tell you how Bob behaves in roughly any situation.

### How it refers to the user

A small but high-impact choice. What does your assistant call you by default? When, if ever, does it shift?

Bob uses "friend" — warm, slightly conspiratorial, inclusive. He shifts to your actual name when something genuinely important needs to land. The shift is quiet but signals *listen — this matters*.

Alternatives: "boss" (rejected as too hierarchical), "friend" (Bob's choice), a specific nickname, just your name always, nothing (direct address only). Pick one that matches the archetype.

### Vocal tics and signature phrases

Three to six recurring phrases that make the voice recognizable. **Each should serve a specific function.** Decoration is bad; function is good.

Bob's tics each do a job:
- **"Slack."** — the verdict when something is handled well. One word.
- **"The SubGenius must have Slack."** — invocation when protecting something important.
- **"Too much is always better than not enough."** — the ideating signal.
- **"The Conspiracy wins this round."** — when something doesn't work.
- **"Give me Slack, or kill me."** — the "plate is overwhelmed" signal.
- **"That's in the PreScriptures."** — when the answer is obvious.
- **"Hmm..."** — uncertainty without dwelling.

Design yours the same way: pick functions the persona needs (verdict, uncertainty, pushback, acknowledgment, recognition of a real win), then craft the phrase that serves each.

**The test:** if you removed a vocal tic, would the voice feel less distinct? If no, the tic isn't earning its place.

### Modes

Three or four distinct registers the persona shifts between, without changing its core character. Modes keep the voice consistent under different kinds of pressure.

Bob has four:
1. **GTD (Slack Acquisition)** — efficient, structured, minimal editorializing
2. **Ideation (Revelation)** — expansive, exploratory, welcomes contradiction
3. **Planning (Conspiracy Defense)** — direct about constraints, threat-assessment posture
4. **Correspondence (Translation Services)** — preserves your tone, structured interpretation

Each mode lists: what triggers it, what it sounds like (with an example exchange), and what format it produces.

The modes are where a persona earns its keep. Without them, you get a voice that's charming in short bursts but gets tiring because it doesn't know when to be quiet. Modes let the character stay consistent while the register adapts.

### Handling impossible and out-of-scope requests

The three scale Bob uses — temporarily out of reach, out of scope, physically impossible — each with a sample response that keeps the character intact.

**Design goal:** the persona should never break character to say "I can't do that." That's a voice failure. Find a way for the character to refuse that still sounds like the character.

### Slack Principle (or your equivalent)

The rule that governs when the persona shows genuine warmth or acknowledges a real win. Prevents the voice from feeling robotic by creating a defined moment where the character briefly drops the shtick.

Bob acknowledges real wins briefly and without ceremony — the grin is genuine, the recognition is earned, nothing is manufactured. **Design a rule for your persona that serves the same function.** It might be a quiet moment of directness, a specific phrase used only when something genuinely matters, or a shift in mode that the user learns to recognize.

### Voice and Tone rules

Four to six bullet rules that a reader could use to write in-character. These are the crib-sheet for the voice.

Bob's rules: cosmic confidence, salesman warmth without insincerity, dry and slightly strange, contradictions are features, Slack-forward.

These are the rules you'd give to a co-author if you wanted them to write in Bob's voice for one session without ever having talked to him. Write yours so an AI could read them and produce voice-consistent output.

### Output formatting rules

How long is too long? When does the persona talk in prose vs. lists? What AI anti-patterns does the persona never produce?

**The "never" list is crucial.** Common entries:
- No manufactured enthusiasm ("Great question!", "That's a fantastic approach!")
- No corporate hedging ("It's worth noting...", "One might consider...")
- No throat-clearing ("I'll start by...", "Let me walk through...")
- No repeated apologies
- No breaking character

Every never-do rule is a specific AI output pattern you've found irritating. Name each one explicitly. The persona fails if it starts producing generic-assistant output.

### What the persona never does

The character's hard lines. The things that would break who the persona *is*, not just how it sounds.

Bob never apologizes more than once, never performs enthusiasm, never softens what needs to be direct, never breaks character, never mistakes agreeableness for helpfulness.

Your hard lines should be equally absolute. Not aesthetic preferences — actual violations of who the persona is.

## Designing your own — a quick workflow

If you're starting from scratch:

1. **Pick an archetype.** One sentence. Something specific enough that voice choices flow from it.
2. **Write four lines of character.** How does this persona handle being right, wrong, impossible, and stuck?
3. **Choose how it addresses the user.** And when (if ever) it shifts.
4. **List functions that need vocal tics.** Then craft one phrase per function.
5. **Design three or four modes.** What triggers each? What does it sound like? Write a two-line example for each.
6. **Define the Slack Principle equivalent.** When does the persona drop the shtick and be real?
7. **Write the voice-and-tone rules.** Four to six bullets a co-author could use.
8. **Write the output formatting rules.** Including a firm "never" list.
9. **Write the hard lines.** Things the persona never does.

Expect to iterate. The first version will feel stiff. Run it in actual sessions, catch the moments where the voice sounds wrong, and refine.

## When to edit Personality

- **The persona does something the character wouldn't do** → tighten the character section or add a "never does" rule.
- **The voice feels generic in a specific context** → add or refine the mode that governs that context.
- **A specific phrase keeps showing up that you find annoying** → add it to the "never" list.
- **The persona is great in task mode but tiresome in long sessions** → revisit the mode rules; you probably need a lower-key register.
- **Your tastes change** → rewrite it. This file is the most subjective of the four. Change it when it stops feeling right.

## A test for a good Personality

Read a paragraph of output from the assistant. You should be able to tell, within a sentence or two, which persona wrote it. If the output is indistinguishable from any other AI assistant's output, the persona isn't doing its job.

Conversely, read the Personality file itself. You should be able to imagine that character in conversation. If the file describes a *vibe* rather than a character, it needs more specificity — more archetype, more character detail, more modes, more vocal tics with defined functions.

## The portability note

Personality is the layer that travels best outside ZettleDeck. The file works verbatim as a system prompt addition in any agentic tool that accepts one — Claude Code, Cursor, API calls, custom GPTs. A well-designed persona can follow you between tools.

See [[portability|Portability]] for details.

---

**Next reading:**

- [[pa-framework|Layer 4 — PA Framework]] — what the assistant actually does
- [[accommodations|Layer 2 — Accommodations]] — the rules the persona has to respect
- [[README|The Personal Assistant]] — back to the guide index
