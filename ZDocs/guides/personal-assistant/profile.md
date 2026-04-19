---
title: Layer 1 — Profile
description: Customizing personal-profile.md — the file that tells the assistant who you are, what you do, how you think, and where you publish. The foundation every other layer builds on.
---

# Layer 1 — Profile

> **Layer 1 of 4.** Profile loads first because everything else references who you are. Accommodations tell the assistant *how* to treat you; Profile tells it *who* it's treating. See [[README|The Personal Assistant]] for the full architecture.

## What Profile is for

`personal-profile.md` is the identity layer. It tells the assistant:

- Your name, role, and where you work
- Your career arc and the themes running through it
- Your day-to-day responsibilities
- Your technical background (if applicable)
- Where you publish and what voice you use there
- What energizes you and what drains you
- What you actually value in how work gets done

This is the foundation. Every recommendation the assistant makes, every piece of correspondence it helps you draft, every plan it proposes — it calibrates against this file. A thin profile produces generic assistance. A rich, specific profile produces assistance that feels tailored.

## What it is not

- **Not a resume.** The format is internal, not external. You're briefing your assistant, not a recruiter.
- **Not aspirational.** Write who you actually are, not who you want to be. The assistant calibrates from what's here — if you claim strengths you don't have, you'll get advice that doesn't fit.
- **Not immutable.** Update it when your role changes, when you start publishing somewhere new, when your focus shifts. The assistant reads the current state every session.

## Why specificity pays off

Vague profiles produce generic assistance. Specific profiles produce assistance that feels tailored. The difference:

**Vague:**
> Focus: Technical consulting for enterprise customers.

**Specific:**
> Focus: ISV Solutions Architect at Amazon — I work with SaaS companies that run on AWS to design reference architectures, review technical bets, and help their engineering leaders make platform decisions. My clients are usually CTOs, VPE, or principal engineers at companies with $10M–$500M ARR.

The second tells the assistant: this user is talking to senior technical people, works in software-as-a-service context, makes reference-architecture decisions, and operates at a scale where platform choices are consequential. That shapes every recommendation the assistant makes.

Same difference across every section. **"I write about tech" is a miss; "I publish long-form essays on Substack about the cultural side of software — how teams work, why projects fail, what good engineering management looks like; my voice there is dry and skeptical" is a win.**

## Section-by-section guidance

### Identity

The basics: name, location, current role, focus. One or two lines each.

**What to get right:** the `Focus` line. It's the one-sentence answer to "what do you actually work on?" Spend a minute on it — it's referenced implicitly in every session.

### Career Arc

Two subsections: Timeline (a scannable table of roles) and Career Themes (the through-lines).

**Timeline is the skeleton; Career Themes is the soul.** The Timeline tells the assistant *where* you've been; Career Themes tell it *how you think*. Three to five bullets on the patterns that run through your career. What draws you to the work? How do you approach problems? What's consistent from early-career-you to now?

Example Career Themes for a real person:
- I'm drawn to problems at the intersection of technical and organizational dysfunction — my best work has been on teams where the technology was fine but the way the team worked with it wasn't.
- I've moved from deep technical IC work into architectural and advisory roles, but I've never fully left the code behind. I write to stay sharp.
- I think in systems. I find pure-software work less satisfying than software-plus-people problems.

That's three sentences that dramatically change how an assistant would frame recommendations for this person.

### Current Role Context

Your day-to-day. Who you work with, what kinds of problems you solve, what a typical week looks like.

**What to include:** concrete responsibilities, typical stakeholders, meeting cadence, typical deliverables. If the assistant is going to help you plan your week, it needs to know what your week actually contains.

### Technical Identity

If you work in a technical field, this lets the assistant calibrate depth without asking. Strengths, background (languages, tools, platforms), approach.

**Adapt or remove.** If you're not in a technical field, replace this section with whatever equivalent expertise you have — "Professional Identity," "Research Background," "Craft Background." The goal is the same: let the assistant know the domains where you have depth, so it doesn't over-explain or under-explain.

### Professional Interests and Writing

Two subsections: Writing Platforms (where you publish and in what voice) and Key Interests (what you actually care about).

**Writing Platforms** is important because voice matters. Your Substack voice is probably different from your LinkedIn voice is probably different from your internal Slack voice. The assistant should preserve the voice that fits the platform. A row per platform, with a brief voice description, goes a long way.

If you don't publish publicly, use this section for internal communication contexts — exec updates, team Slack, client briefs. The pattern is the same.

**Key Interests** is where you sneak in the stuff that most formal profiles miss. What do you read on weekends? What problems do you keep coming back to? These inform how the assistant frames advice and surfaces connections from your vault. Be honest. "I'm weirdly fascinated by municipal water infrastructure" belongs here if it's true.

### Working Style and Strengths

Three subsections: What Energizes, What Drains, Professional Values.

**What Energizes and What Drains** are for the assistant to recognize what kinds of work to schedule when, and what to protect you from when you're already drained. Concrete triggers, not abstract categories. "Prolonged open-ended social interaction without a clear purpose" is useful; "extroverted activities" is not.

**Professional Values** — your actual working principles. Not "excellence and integrity"-grade platitudes. Values like "I would rather say no and be respected than say yes and resent it" or "optimizing for team throughput beats optimizing for individual heroics." These show up in how the assistant helps you respond to requests, how it helps you make tradeoffs, what it nudges you toward.

### Boundaries — Profile

The hard rules for how this file's content should be used. The template ships with three sensible defaults: don't share profile details externally without direction, don't use profile content to speculate about emotional state, treat career history as fact not topic-for-praise.

Keep them. Add your own if there are other limits around how you want this information used.

## Keeping Profile current

Update Profile when:

- Your role or organization changes
- You start publishing somewhere new (add a Writing Platforms row)
- A major career theme shifts
- You notice the assistant giving you generic advice — look for the gap in the profile that caused it

You don't need to update it when small things change — a new project, a temporary focus. That's what conversation context is for. Profile is the stable foundation.

## A test for a good Profile

When you re-read your Profile, you should be able to imagine a close colleague reading it and saying "yes, that's him." If it reads like a LinkedIn summary or a bio blurb, it's too polished. If a new-to-you assistant would have to ask you basic questions about your role after reading it, it's too thin. The sweet spot is a document that captures the specific person you actually are at work.

---

**Next reading:**

- [[accommodations|Layer 2 — Accommodations]] — how the assistant should treat you
- [[personality|Layer 3 — Personality]] — how the assistant should sound
- [[README|The Personal Assistant]] — back to the guide index
