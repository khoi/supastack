# Verify the result and ship it

A build or type check proves a narrow property. Supastack asks for evidence from the artifact a user relies on: the command, application flow, stored value, response, or profile.

## Define the finish condition

Put observable checks in the first request:

```text
$supastack:poteto-mode add JSON output to this command. Keep text output byte-identical, parse the JSON, run both against the sample project, and show the results.
```

Match the evidence to the surface:

| Change | Evidence |
| --- | --- |
| CLI | Run the built command and capture stdout, stderr, and exit status. |
| Web or desktop UI | Walk the changed flow in the running application and capture the resulting state. |
| Service | Send a real request through its supported boundary and inspect the response and side effects. |
| Parser or migration | Replay a saved input and compare the output or written records. |
| Performance | Measure the same fixture before and after under the same harness. |

Treat missing control capability as a gap. A browser check needs browser control, an Electron or desktop flow needs computer use, and a native app needs its simulator or debugger. Unit tests do not replace a real-surface check because a matching tool is absent.

## Open and drive the PR by request

Ask for a PR when you want one:

```text
$supastack:poteto-mode open a PR with small ordered commits and put the evidence in its description.
```

The [Opening a PR helper](../../skills/poteto-mode/playbooks/opening-a-pr.md) cleans the diff, prepares the commits, and writes focused PR text. It returns the URL without starting a watcher.

Ask Babysit for status or merge-readiness work:

```text
$supastack:poteto-mode check PR 123 and report outstanding blockers.
```

```text
$supastack:poteto-mode drive PR 123 to merge-ready. Resolve valid review findings and CI failures, but do not merge.
```

The [Babysit playbook](../../skills/poteto-mode/playbooks/babysit.md) classifies the request as a status check, active drive, or background drive. It handles conflicts, review threads, and CI in order. It stops at merge-ready unless another authorized workflow grants merge authority.

## Land only after a fresh verdict

Request the merge outcome yourself:

```text
$supastack:poteto-mode verify and land this stack. Stop at the first PR that lacks a clean independent verdict.
```

The [Shipping playbook](../../skills/poteto-mode/playbooks/shipping.md) verifies each head and lands only the contiguous verified run from the bottom. It needs the repository's GitHub and Graphite tools when the stack uses them. A green check list does not waive the independent verdict or the user's merge authorization.

Next: [Run long work](./07-long-running.md).
