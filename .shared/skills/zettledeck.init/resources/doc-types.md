---
mode: doc-types
description: Displays the current document types registered in config
---

# Doc Types — Current Configuration

## Steps

1. Read `.zettledeck/core/config.json`
2. If the file does not exist, tell the user: "No config found. Run `/zettledeck.init core` first."
3. Display the document types table (see format below)

---

## Display Format

```
Document Types
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Prefix  docType     Source   Description
 S       scope       core     Domain anchor; root of the knowledge graph
 F       focus       core     A thematic area or domain within a scope
 P       project     core     A defined project with deliverables
 O       objective   core     A trackable goal, milestone, or task unit
 C       content     core     A produced piece of writing or document
 M       meeting     core     Meeting notes, one-time or recurring
 N       note        core     Miscellaneous notes
 I       ideation    core     Brainstorming and idea capture
 R       research    core     Research and analysis notes
```

For each type also show its `validParents` and `subTypes` in a compact secondary block:

```
scope     parents: (none)                          subTypes: from scopeSubTypes
focus     parents: scope                           subTypes: ideation, domain, research, vision, strategy, wellness, other
...
```

---

## After Display

Suggest next actions:

> "To add a document type: `/zettledeck.init add-doc-type`"
> "To remove a document type: `/zettledeck.init remove-doc-type`"
