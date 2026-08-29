# Make Supastack yours

Supastack's router carries one engineering style. You can change model assignments or add focused project skills without editing the router itself.

## Configure model roles

```text
$supastack:setup-supastack
```

[`$supastack:setup-supastack`](../../skills/setup-supastack/SKILL.md) writes `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml`. It validates model slugs and model-specific reasoning efforts against the current Codex session when the interface exposes them. Each selector stores `model` and `reasoning_effort` separately. Selector arrays control panel size for Arena, Architect, How critics, and Interrogate.

Use `inherit-parent` or `auto` on either field to omit that override. Delete a key to restore Supastack's default selector.

## Capture a lesson from one task

```text
$supastack:reflect this migration repeated work we should encode for next time.
```

[`$supastack:reflect`](../../skills/reflect/SKILL.md) asks independent reviewers for tooling, judgment, and divergent proposals. A synthesizer categorizes them before any skill change. Approve rules that would change a future decision; leave one-off events out.

## Author a focused skill

Use Codex's `skill-creator` when you know the workflow:

```text
$skill-creator create a project skill for verifying database migrations in this repository.
```

Poteto Mode's [Authoring a skill playbook](../../skills/poteto-mode/playbooks/authoring-a-skill.md) adds grounding, validation, link checks, and delivery when you want the full workflow:

```text
$supastack:poteto-mode author a skill for verifying database migrations. Validate it and prepare a PR for review.
```

## Write and test the instructions

Use [`$supastack:technical-writing`](../../skills/technical-writing/SKILL.md) for documentation, RFCs, readmes, commit bodies, and PR descriptions. Use [`$supastack:unslop`](../../skills/unslop/SKILL.md) to remove filler and ambiguous prose.

Run the Eval playbook before promoting a consequential skill change:

```text
$supastack:poteto-mode evaluate this skill change with blind candidates and one neutral rubric.
```

The candidates must not know that they are under evaluation or see the competing version. Read their outputs yourself before accepting the judge's result.

Plugin edits need a cachebuster update and reinstall. Project skill edits need a new Codex session before you judge discovery or invocation behavior. See [Set up Supastack](./01-setup.md) for the install paths.

Next: [Recipes and pitfalls](./10-recipes-and-pitfalls.md).
