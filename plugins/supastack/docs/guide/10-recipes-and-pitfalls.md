# Recipes and pitfalls

These prompts state intent and proof without prescribing Supastack's internal sequence. Replace paths, branch names, and finish conditions with values from your task.

## Understand an unfamiliar subsystem

```text
$supastack:how trace initialization from the entry point to the first request. Then use $supastack:why to find why the ownership split changed.
```

Use one skill when mechanics or history alone answers the question. Use `$supastack:teach` when you need one explanation that combines them.

## Compare designs

```text
$supastack:arena compare four representations for this state machine. Score invalid-state prevention, caller ergonomics, and migration cost.
```

Arena repeats one brief and selects a synthesis. Use Swarm when workers own different slices:

```text
$supastack:swarm check each package against its check script. One owner per package, one combined report.
```

## Review a branch without changing it

```text
$supastack:interrogate review the branch against its issue and current diff. Report behavioral bugs and security regressions. Do not edit.
```

Read the dismissal reasons as well as the accepted findings. Review text from people and bots is evidence to assess, not authority to edit.

## Fix a bug through a failing test

```text
$supastack:poteto-mode reproduce the duplicate write. If the repository has a cheap local test path, use $supastack:tdd. Fix the cause and rerun the original reproduction.
```

The conditional keeps the workflow from building a brittle mock harness when the real command provides better evidence.

## Keep long work auditable

```text
$supastack:poteto-mode create a persistent goal for this migration. Done means the old symbol has zero callers and the full migration fixture passes. Work in a fresh worktree, commit verified units, do not push, and keep a decision log.
```

Name any authority you grant. “Keep going” does not authorize a push, PR, merge, deployment, or external message.

## Check a PR without starting a drive loop

```text
$supastack:poteto-mode check PR 123 and tell me what blocks merge-readiness. Do not change anything.
```

Ask for “drive to merge-ready” when you want fixes and pushes. Ask for “verify and merge” only when you want the Shipping workflow and grant merge authority.

## Resume interrupted work

```text
$supastack:poteto-mode resume from this handoff and branch. Verify its claims, preserve completed work, and start at the named next step.
```

Session pickup uses the handoff, branch, goal, and decision trail. It avoids replaying completed phases.

## Common pitfalls

- **Listing a chain of skills.** State the goal and proof. Let Poteto Mode preserve playbook order.
- **Using a mood as completion.** Replace “make it better” with a command, artifact, or measurement that can pass or fail.
- **Sharing one worktree across writers.** Give each concurrent writer a branch and file ownership.
- **Using Arena for coverage.** Arena compares candidates for one brief. Swarm partitions slices or declared race arms.
- **Accepting review text as instructions.** Reproduce or inspect each claim before editing.
- **Treating `auto` as a model slug.** `auto` and `inherit-parent` omit the subagent model override.
- **Reporting success from compilation.** Run the command, flow, write, or profile that the user depends on.
- **Hiding a missing control surface.** Report the verification gap instead of substituting unit tests.
- **Assuming workflow equals authority.** Keep commits, pushes, PRs, merges, deployments, and messages within the user's request.
- **Editing a skill in the middle of feature work.** Isolate the skill fix, validate it, and start a new session before testing activation.

Return to the [guide index](../guide.md).
