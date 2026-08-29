# Make Supastack yours

Supastack's router carries one engineering style. You can change model assignments, capture your own working rules, or add focused project skills without editing the router itself.

## Configure model roles

```text
$supastack:setup-supastack
```

[`$supastack:setup-supastack`](../../skills/setup-supastack/SKILL.md) writes `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml`. It validates model slugs against the current session when Codex exposes a catalog. Array values control panel size for Arena, Architect, How critics, and Interrogate.

Keep `inherit-parent` or `auto` when a role should use the parent model. Delete a key to restore Supastack's default.

## Capture your working style

```text
$supastack:automate-me
```

[`$supastack:automate-me`](../../skills/automate-me/SKILL.md) searches Codex sessions for the active workspace, asks which repeated patterns reflect your intent, and uses `skill-creator` to draft a personal mode skill. New project skills go under `.agents/skills/`; personal skills can live under `${CODEX_HOME:-$HOME/.codex}/skills/`.

The generated mode disables implicit invocation by default. Invoke it by name when you want that style. This keeps a broad personal workflow from changing unrelated tasks.

Run Automate Me again to update a mode from sessions created since its last edit.

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

Use `$supastack:create-verification-skill` for a skill that drives a product surface. Its generator includes launch, doctor, evidence, and cleanup requirements that a general skill does not.

## Write and test the instructions

Use [`$supastack:technical-writing`](../../skills/technical-writing/SKILL.md) for documentation, RFCs, readmes, commit bodies, and PR descriptions. Use [`$supastack:unslop`](../../skills/unslop/SKILL.md) to remove filler and ambiguous prose.

Run the Eval playbook before promoting a consequential skill change:

```text
$supastack:poteto-mode evaluate this skill change with blind candidates and one neutral rubric.
```

The candidates must not know that they are under evaluation or see the competing version. Read their outputs yourself before accepting the judge's result.

Plugin edits need a cachebuster update and reinstall. Project skill edits need a new Codex session before you judge discovery or invocation behavior. See [Set up Supastack](./01-setup.md) for the install paths.

Next: [Recipes and pitfalls](./10-recipes-and-pitfalls.md).
