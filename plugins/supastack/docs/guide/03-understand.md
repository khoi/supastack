# Understand the code before changing it

Supastack separates two questions that often get mixed together. `how` traces current behavior. `why` searches the record for intent.

## Trace current behavior with `how`

```text
$supastack:how how do we deduplicate notifications? Check whether subscriber lookup has an N+1 query.
```

[`$supastack:how`](../../skills/how/SKILL.md) follows runtime flow, types, ownership, and boundaries. A large subsystem can use read-only explorers and return their findings as a compact explanation. A narrow question stays in the parent thread.

Ask for critique when the structure itself concerns you:

```text
$supastack:how explain the sync service, then critique its ownership boundaries.
```

The skill explains the current mechanism before judging it.

## Search the record with `why`

```text
$supastack:why why was the retry limit set to five, and does that reason still hold?
```

[`$supastack:why`](../../skills/why/SKILL.md) starts with source control and uses available connectors for issues, documents, team chat, observability, errors, or analytics. It separates direct evidence from inference and reports sources that returned nothing.

The skill cannot search a private system without an installed and authorized connector. A missing source stays a named gap instead of becoming a guessed explanation.

Use the Session pickup playbook when you want to resume one known thread or branch:

```text
$supastack:poteto-mode take over this branch. Read the handoff and decision log, verify inherited claims, and continue from the recorded resume point.
```

## Pick the smallest tool

| Need | Use |
| --- | --- |
| Current mechanics | `$supastack:how` |
| Historical intent | `$supastack:why` |
| One interrupted task | Poteto Mode's Session pickup playbook |

Run Investigation through Poteto Mode when you want a cited answer and no code changes. The explicit read-only boundary prevents an explanation request from turning into an unsolicited fix.

Next: [Design the change](./04-design.md).
