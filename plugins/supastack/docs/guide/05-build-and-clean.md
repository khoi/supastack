# Build and clean the change

Build prompts should name the observed state and the finish condition. The matched playbook supplies the engineering sequence.

## Match the prompt to the work

A bug starts with a reproduction:

```text
$supastack:poteto-mode this command emits two records after a retry. Reproduce it, trace the cause, fix it, and rerun the same case.
```

A feature pins new and existing behavior:

```text
$supastack:poteto-mode add a --json flag. Keep text output byte-identical and verify both forms against the sample project.
```

A refactor records behavior before moving structure:

```text
$supastack:poteto-mode move parsing into one module with no behavior change. Record current output and compare it after the move.
```

A performance task starts from a measurement:

```text
$supastack:poteto-mode startup takes 1.8 seconds on this fixture. Capture a profile, fix the measured cause, and show before and after.
```

The [Bug fix](../../skills/poteto-mode/playbooks/bug-fix.md), [Feature](../../skills/poteto-mode/playbooks/feature.md), [Refactoring](../../skills/poteto-mode/playbooks/refactoring.md), and [Perf issue](../../skills/poteto-mode/playbooks/perf-issue.md) playbooks add the steps you did not spell out. Hillclimb handles repeated attempts against one frozen metric and keeps only measured wins.

## Use `tdd` when a cheap test path exists

```text
$supastack:tdd implement the retry fix from the current context.
```

[`$supastack:tdd`](../../skills/tdd/SKILL.md) writes the smallest test that fails for the intended reason, then adds the fix and reruns the test. It avoids broad harness construction and brittle mocks when the real command offers stronger proof.

## Remove code noise before review

Supastack uses three separate passes:

| Pass | Scope |
| --- | --- |
| Installed `simplify` skill, or an equivalent local pass | Clarifies recently changed code without changing behavior. |
| `$supastack:no-comments` | Gives comments to the `comment_sicko` role and fixes accepted structural findings. |
| `$supastack:unslop` | Removes filler and ambiguity from documentation, commit bodies, and PR text. |

Run the comment pass from fresh eyes:

```text
$supastack:no-comments review the current diff.
```

The reviewer keeps licenses, public API contracts, and proven external constraints. It flags comments that compensate for unclear code and leaves the parent to decide whether to reshape the code.

## Keep delivery separate from implementation

Finishing code does not imply permission to commit, push, or open a PR. Request those actions when you want them. Poteto Mode invokes the Opening a PR helper only after the request or an authorized delivery workflow includes that outcome.

When you request a PR, the helper organizes commits, checks the diff, writes the PR text, and returns the URL. It does not begin a babysit loop unless you also ask for PR driving.

Next: [Verify and ship](./06-verify-and-ship.md).
