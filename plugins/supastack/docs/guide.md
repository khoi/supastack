# Supastack guide

Supastack works best when you state the outcome, constraints, and proof you expect. `$supastack:poteto-mode` chooses one of 22 routable playbooks, loads the skills that the work needs, and keeps skipped steps visible. The Opening a PR file is a delivery helper, which brings the package to 23 playbook files.

Use the pages in order for your first task. Each page also stands on its own.

1. [Set up Supastack](./guide/01-setup.md). Install the checkout and choose models.
2. [Route work through Poteto Mode](./guide/02-poteto-mode.md). Write a useful prompt and understand the router.
3. [Understand the code](./guide/03-understand.md). Use `how` and `why` before editing.
4. [Design the change](./guide/04-design.md). Use `architect`, `arena`, `swarm`, and `interrogate` where design risk warrants them.
5. [Build and clean](./guide/05-build-and-clean.md). Match build work to a playbook, test first when it helps, and remove diff noise.
6. [Verify and ship](./guide/06-verify-and-ship.md). Exercise the real artifact, open a focused PR, and keep merge authority explicit.
7. [Run long work](./guide/07-long-running.md). Define done, preserve a decision trail, and choose the right autonomous workflow.
8. [Steer with principles](./guide/08-principles.md). Use the 21 principle names as precise corrections.
9. [Make it yours](./guide/09-make-it-yours.md). Configure models and author focused project skills.
10. [Recipes and pitfalls](./guide/10-recipes-and-pitfalls.md). Copy practical prompts and avoid common failure modes.

## Start with one real task

Give the router a symptom or outcome and a check that can pass or fail:

```text
$supastack:poteto-mode the export writes duplicate rows after a retry. Reproduce it, fix the cause, and show the output that proves the fix.
```

You do not need to list skills or choose a playbook. Direct invocation removes ambiguity for the current turn. Invoke Poteto Mode again when a later turn starts another routed task.

Next: [Set up Supastack](./guide/01-setup.md).

## Platform references

The guide follows the current [OpenAI skills and plugins model](https://learn.chatgpt.com/docs/skills-and-plugins), [Codex subagent behavior](https://learn.chatgpt.com/docs/agent-configuration/subagents), and [long-running work guidance](https://learn.chatgpt.com/docs/long-running-work). Workflow examples draw from the MIT-licensed pstack guide and use Supastack's Codex-native skills, paths, tools, and authorization rules.
