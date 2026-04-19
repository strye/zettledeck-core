---
name: runbook
description: "Create and run repeatable workflows from markdown runbook files. Use when user says 'runbook', wants to automate a repeatable process, or references a runbook file."
tags: [skill, workflow, automation, runbook]
---

# Runbook

Lightweight tool for creating and executing repeatable workflows defined in markdown files.

## Modes

| Mode | Trigger | Description |
|------|---------|-------------|
| `help` | `/runbook` or `/runbook help` | Show usage and available runbooks |
| `new` | `/runbook new` | Walk user through creating a new runbook |
| `run` | `/runbook {fileName}` or `/runbook run {fileName}` | Execute a runbook |

## Invocation

```
/runbook                    → help
/runbook help               → help
/runbook new                → create new runbook
/runbook run {fileName}     → run a specific runbook
/runbook {fileName}         → run (shorthand)
```

## Mode: Help

Display available modes and list any existing runbooks found in the default location.

**Default location:** `.zettledeck/runbooks/`

Scan the default location for `*-runbook.md` files and list them.

## Mode: New

Walk the user through creating a new runbook. See `references/runbook-schema.md` for the file format spec and `references/patterns.md` for predefined execution patterns.

### Steps

1. **Name and location**
   - Ask for a runbook name (`rb_name`). Kebab-case, no spaces.
   - Ask where to place the runbook, suggesting the default: `.zettledeck/runbooks/{rb_name}/`
   - Use the user's answer as `parent_fld`; fall back to `.zettledeck/runbooks/` if they accept the default.

2. **Create folder**
   - Create `{parent_fld}/{rb_name}/`

3. **Design flows and steps**
   - Work with the user to outline:
     - Flows (named groups of steps)
     - Pattern for each flow (triage, generate, transform, pipeline, or custom) — see `references/patterns.md`
     - Execution order: which flows run in sequence vs parallel
     - Steps within each flow, and their execution order
     - Inputs, outputs, and working files
     - Which skills or tools each step needs
   - **Skill delegation principle**: When an existing skill already handles a task (e.g., `/diary meeting-summary`, `/email triage`), the runbook step MUST invoke that skill rather than reimplementing its logic. This ensures consistency — when a skill's rules are updated, all runbooks that use it inherit the fix. Runbook steps may invoke a skill partially (e.g., "run Phase 1 and 2 only") and add runbook-specific rules on top.
   - For any step that produces a working file for user review, define the file format and location.
   - A single runbook MAY contain flows with different patterns (e.g., a generate flow followed by a triage flow).

4. **Discover rules**
   - Review the designed flows for actions that have non-obvious execution constraints — things that could silently fail, cause data loss, or produce incorrect results if done the naive way.
   - Common rule categories:
     - **ID resolution**: When an action requires looking up a different object type (e.g., calendar event ID vs email ID for meeting RSVPs)
     - **Ordering constraints**: When operations must happen in a specific sequence (e.g., mark read before archive)
     - **Source of truth**: When a step must read from disk vs memory
     - **Rate limiting**: Batch ceilings for parallel operations
     - **Protection**: Items that should never be auto-acted on without explicit user override
   - Each rule gets an ID (`R1`, `R2`, ...) and a clear description of what the runner must do and why.
   - Steps that are governed by a rule reference it by ID (e.g., "see **R1**").
   - If no rules are needed, omit the `## Rules` section.

5. **Discover permissions**
   - Based on the designed flows, enumerate all skills, tools, and providers needed.
   - List them in the runbook frontmatter under `permissions`.
   - This ensures the runner knows upfront what's required — no mid-run permission prompts.

6. **Write runbook file**
   - Create `{parent_fld}/{rb_name}/{rb_name}-runbook.md` using the template from `assets/runbook-template.md`.
   - Populate with the designed flows, steps, rules, and metadata.

7. **Confirm**
   - Show the user the created file path and a summary of flows/steps.
   - Offer to do a dry-run or edit.

## Mode: Run

Execute a runbook file.

### Steps

1. **Resolve file**
   - If `{fileName}` is a path, use directly.
   - If `{fileName}` is a name (no path), look in `.zettledeck/runbooks/` for `{fileName}/{fileName}-runbook.md` or `{fileName}-runbook.md`.
   - If not found, ask user to confirm location or offer to create a new runbook.

2. **Read and validate**
   - Read the runbook file.
   - Validate frontmatter has required fields (`subType: runbook`, `permissions`).
   - Confirm all required skills/tools/providers are available.
   - **Load rules**: If the runbook has a `## Rules` section, parse all rules and hold them in context for the entire execution. Rules apply across all flows — the runner must check applicable rules before executing any step.
   - **Check for existing working file state**: If the runbook has a working file (defined in Outputs) and that file exists with `status: in-progress`, the previous run paused at a checkpoint. Skip completed flows and resume from the next flow (typically `execute-actions`). Ask the user: "Found an in-progress working file from a previous run. Resume from where we left off?"

3. **Execute flows**
   - Process flows in declared order.
   - **Sequential flows**: execute one at a time, in order.
   - **Parallel flows**: spawn sub-agents via the `subagent` tool for each parallel flow. Wait for all to complete before proceeding to the next sequential group.
   - Within each flow, process steps the same way — sequential steps run in order, parallel steps spawn sub-agents.

4. **User checkpoints**
   - When a flow produces a working file for user review (marked `checkpoint: true`), pause execution and notify the user.
   - Resume when user signals completion (e.g., "continue", "go ahead", "process").

5. **Report**
   - After all flows complete, summarize what was done: files created/modified, actions taken, errors encountered.

## Core Concepts

### Runbook
The top-level instruction file (`{name}-runbook.md`). Contains metadata and 1–n flows.

### Flow
A named group of related steps within a runbook. Flows execute relative to each other as either `sequential` (default) or `parallel`.

### Step
An individual action within a flow. Steps execute relative to each other as either `sequential` (default) or `parallel`. A step may invoke a skill, call a tool, read/write files, or produce output for user review.

### Checkpoint
A pause point where execution stops and waits for user input. Typically after producing a working file the user needs to review and annotate before the next flow can proceed.

### Execution Patterns
Predefined templates for common flow shapes. Applied at the **flow** level, not the runbook level — a single runbook MAY contain flows with different patterns. See `references/patterns.md`.

### Permissions
Skills, tools, and providers a runbook needs. Declared in frontmatter during design so the runner can verify availability before execution starts.

### Rules
Execution-time constraints that apply across all flows. Each rule has an ID (`R1`, `R2`, ...) and describes a behavioral guardrail the runner MUST follow whenever the relevant action type occurs. Rules live in the `## Rules` section between Outputs and Flows. Steps reference rules by ID. Rules are discovered during the `new` workflow and refined through operational experience.

## Parallel Execution

When flows or steps are marked `parallel`, the runner uses the `subagent` tool to spawn independent agents for each parallel unit. The parent waits for all parallel units to complete before proceeding.

**Sub-agent constraints:**
- Each sub-agent receives the step/flow instructions and any required context.
- Sub-agents MUST NOT modify the same file simultaneously — design parallel units to work on independent outputs.
- If a parallel step needs results from another parallel step, it MUST be redesigned as sequential.

## Error Handling

- If a step fails, log the error and continue to the next step (unless the step is marked `required: true`).
- If a required step fails, halt the flow and report to the user.
- If a sub-agent fails, report which parallel unit failed and offer to retry or skip.
