# Runbook File Format

Specification for `{name}-runbook.md` files.

## Frontmatter

```yaml
---
title: "Human-readable runbook title"
subType: runbook
permissions:
  skills:
    - email        # skill names this runbook invokes
    - diary
  tools:
    - email_inbox  # specific tools needed
    - email_move
    - write
    - read
    - subagent
  providers:
    - aws-outlook-email   # provider configs needed
status: active | draft | archived
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

### Required fields
- `title` — Human-readable name
- `subType` — MUST be `runbook`
- `permissions` — Skills, tools, and providers needed

### Optional fields
- `status` — Lifecycle state (default: `active`)
- `created`, `updated` — Dates

## Body Structure

```markdown
# {Title}

{Brief description of what this runbook does and when to use it.}

## Inputs

{What the runbook needs to start — parameters, date ranges, source locations.}

## Outputs

{What the runbook produces — files, actions, side effects.}

## Rules

{Optional. Execution-time constraints that apply across all flows. Each rule has an ID (R1, R2, ...) and describes a behavioral guardrail the runner MUST follow whenever the relevant action type occurs, regardless of which step triggers it.}

### R{n}: {rule-name}

{Description of the constraint, why it exists, and what the runner must do.}

## Flows

### Flow: {flow-name}
- **pattern**: triage | generate | transform | pipeline | custom
- **execution**: sequential | parallel (relative to other flows)
- **depends_on**: [{flow-name}, ...] (optional, for parallel flows that need prior results)
- **checkpoint**: true | false (pause for user review after this flow)

#### Step {n}: {step-description}
- **execution**: sequential | parallel (relative to sibling steps)
- **skill**: {skill-name} (optional, if step invokes a skill)
- **tool**: {tool-name} (optional, if step calls a specific tool)
- **required**: true | false (if true, failure halts the flow)

{Step instructions — what to do, how to do it, expected output.}

#### Step {n}: {step-description}
...

### Flow: {flow-name}
...
```

## Execution Semantics

### Flow ordering
- Flows are processed top-to-bottom by default (sequential).
- Flows marked `execution: parallel` that share the same position in the sequence run simultaneously via sub-agents.
- A flow with `depends_on` waits for named flows to complete before starting.

### Step ordering
- Steps within a flow are processed top-to-bottom by default (sequential).
- Steps marked `execution: parallel` that are adjacent run simultaneously via sub-agents.
- Sequential steps after a parallel group wait for all parallel steps to complete.

### Parallel grouping convention
Adjacent parallel steps/flows form a group. A sequential item breaks the group.

```markdown
#### Step 1: Do A
- **execution**: sequential
#### Step 2: Do B
- **execution**: parallel
#### Step 3: Do C
- **execution**: parallel
#### Step 4: Do D
- **execution**: sequential
```

Execution: Step 1 → [Step 2 ∥ Step 3] → Step 4

### Checkpoints
When a flow has `checkpoint: true`, execution pauses after the flow completes. The runner notifies the user and waits for a signal to continue.

### Working files
Steps that produce working files for user review SHOULD specify:
- File path (relative to runbook folder or absolute)
- File format description
- What the user should do with the file (review, annotate, approve)

## Example: Email Triage Runbook

```yaml
---
title: "Daily Email Triage"
subType: runbook
permissions:
  skills:
    - email
    - diary
  tools:
    - email_inbox
    - email_read
    - email_move
    - email_update
    - calendar_meeting
    - read
    - write
    - glob
    - subagent
  providers:
    - aws-outlook-email
    - aws-outlook-calendar
status: active
created: 2026-04-16
---
```

```markdown
# Daily Email Triage

Process unread emails: classify, present for review, execute user-annotated actions.

## Inputs

- Date: defaults to today
- Batch size: 50 (paginate if more)

## Outputs

- Working file: `{runbook-folder}/email-triage.md`
- Tasks written to today's diary
- Emails archived/deleted per user instructions

## Flows

### Flow: gather-and-classify
- **pattern**: triage
- **execution**: sequential
- **checkpoint**: true

#### Step 1: Load context
- **execution**: sequential
- **skill**: email (shared context rules)
- **required**: true

Read RP registry for RP-alignment flagging.

#### Step 2: Fetch unread emails
- **execution**: sequential
- **tool**: email_inbox
- **required**: true

Fetch all unread emails. Paginate at 50.

#### Step 3: Classify and write working file
- **execution**: sequential
- **tool**: write
- **required**: true

Classify each email (🔴/🟡/🟢). Write to `email-triage.md` with
conversation IDs, summaries, and recommended actions. User edits
Action: lines and adds bulk instructions.

**Checkpoint**: Pause here. User reviews and annotates the working file.

### Flow: execute-actions
- **pattern**: triage
- **execution**: sequential
- **depends_on**: [gather-and-classify]

#### Step 1: Read annotated working file
- **execution**: sequential
- **tool**: read
- **required**: true

Read `email-triage.md` and parse user annotations.

#### Step 2: Process deletes
- **execution**: parallel
- **tool**: email_move

Delete all emails marked "delete."

#### Step 3: Process archives
- **execution**: parallel
- **tool**: email_move

Archive all emails marked "archive."

#### Step 4: Accept meeting invites
- **execution**: sequential
- **tool**: calendar_meeting

Accept/tentative meeting invites as annotated.

#### Step 5: Create tasks
- **execution**: sequential
- **skill**: diary
- **tool**: write

Write tasks to today's diary from emails marked "task."

#### Step 6: Flag emails
- **execution**: sequential
- **tool**: email_update

Flag emails marked for follow-up.

#### Step 7: Update working file
- **execution**: sequential
- **tool**: write

Append execution summary to working file. Set status to completed.
```
