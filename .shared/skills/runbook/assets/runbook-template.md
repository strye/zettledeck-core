---
title: "{TITLE}"
subType: runbook
permissions:
  skills: []
  tools: []
  providers: []
status: draft
created: {DATE}
---
# {TITLE}

{Description of what this runbook does and when to use it.}

## Inputs

{What the runbook needs to start.}

## Outputs

{What the runbook produces.}

## Rules

{Optional. Execution-time constraints that apply across all flows. Remove this section if no rules are needed.}

## Flows

### Flow: {flow-name}
- **pattern**: {triage | generate | transform | pipeline | custom}
- **execution**: sequential
- **checkpoint**: false

#### Step 1: {step-description}
- **execution**: sequential
- **required**: true

{Step instructions.}
