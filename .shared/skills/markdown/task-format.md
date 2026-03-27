# Task Format — Rules

Conventions for writing tasks in Obsidian markdown files. All workflows that create or modify tasks follow these formatting rules.

## Task Format

Standard task line:

```
- [ ] {description} {attribution} {priority} {dates}
```

### Emoji Signifiers (Obsidian Tasks Plugin)

| Signifier | Meaning | When to Use |
|-----------|---------|-------------|
| `➕ YYYY-MM-DD` | Created date | Always — every task gets one |
| `📅 YYYY-MM-DD` | Due date | When a deadline is known |
| `⏳ YYYY-MM-DD` | Scheduled date | When deferred to a future date |
| `🛫 YYYY-MM-DD` | Start date | When work can't begin until a date |
| `✅ YYYY-MM-DD` | Done date | On completion |
| `❌ YYYY-MM-DD` | Cancelled date | On cancellation |

### Priority Signifiers

| Signifier | Level |
|-----------|-------|
| `⏫` | High — blocks progress or has an imminent deadline |
| `🔼` | Medium — important but not blocking |
| (none) | Normal — standard work |
| `🔽` | Low — nice to have, no urgency |

### Field Order

Description first, then attribution, then priority, then dates. Dates in order: created, scheduled, start, due.

```
- [ ] Review proposal *(from: Acct Review, Monday)* ⏫ ➕ 2026-03-08 📅 2026-03-12
```

## Attribution

Every task created by the assistant includes a source attribution after the description, before signifiers.

| Source | Pattern |
|--------|---------|
| Meeting | `*(from: {meeting subject}, {DayName})*` |
| Email | `*(from: email — {email subject}, {YYYY-MM-DD})*` |
| Manual | No attribution — user-entered tasks have none |

## Waiting-For Items

Same format as action items, with an `@{person}:` prefix in the description:

```
- [ ] @Kate: Send updated timeline *(from: Standup, Monday)* ➕ 2026-03-08 📅 2026-03-14
```

The `@` prefix is how the dashboard query distinguishes waiting-for items from owned actions.

## RP Alignment Tags

Tasks related to a Ruthless Priority can include an Obsidian tag with the `#rp/` namespace:

```
- [ ] Review migration plan #rp/platform-modernization ⏫ ➕ 2026-03-08
```

RP tags are optional. The assistant may suggest them when a task clearly aligns with an active RP.

## Examples

Action item from a meeting:
```
- [ ] Draft architecture proposal *(from: Acct Review, Tuesday)* ⏫ ➕ 2026-03-08 📅 2026-03-14
```

Waiting-for from email:
```
- [ ] @Jordan: Confirm budget approval *(from: email — RE: Q2 Budget, 2026-03-07)* 🔼 ➕ 2026-03-08 📅 2026-03-12
```

Completed:
```
- [x] Send follow-up to Kate *(from: email — RE: Timeline, 2026-02-18)* ➕ 2026-02-18 📅 2026-02-20 ✅ 2026-02-20
```

Low priority with no deadline:
```
- [ ] Research Obsidian Dataview integration 🔽 ➕ 2026-03-08
```
