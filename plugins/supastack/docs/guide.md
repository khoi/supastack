# Supastack guide

Supastack groups its skills into workflow families. Invoke a focused skill directly or use `$supastack:poteto-mode` to select the matching playbook.

## Setup

Follow the repository `README.md` to install Supastack. Plugin skills use `$supastack:<skill>`. The main router is `$supastack:poteto-mode`.

## Understand

- `$supastack:how` explains runtime flow, ownership, placement, and architecture.
- `$supastack:why` investigates historical intent across available evidence systems.
- `$supastack:teach` combines how and why into a plain explanation.
- `$supastack:recall` reconstructs recent workspace context from Codex sessions and shared evidence.

## Design

- `$supastack:architect` grounds the subsystem, generates distinct sketches, selects a shape, and implements against it.
- `$supastack:arena` runs isolated candidates, judges them, selects a base, grafts coherent improvements, and verifies the synthesis.
- `$supastack:interrogate` sends one intent and diff to independent reviewers and returns a categorized verdict without applying it.
- Prototype requests route through `$supastack:poteto-mode` to the Prototype playbook.

## Build and clean

Feature, bug-fix, performance, refactoring, visual-parity, and hillclimb work routes through `$supastack:poteto-mode`. Use `$supastack:tdd` when its trigger applies. Use `$supastack:no-comments` for Comment Sicko review and `$supastack:unslop` for prose.

## Verify and ship

Supastack selects the installed Codex control skill that matches the real product surface. The Babysit, Opening a PR, and Shipping playbooks preserve their authorization gates. Ask for the PR, landing, or merge action explicitly.

## Long and unattended work

Autonomous and program playbooks use `create_goal` only when the user explicitly requests a persistent objective. Continuation uses Codex event waiting, monitoring, or Automations. Use `$supastack:show-me-your-work` for an auditable TSV trail.

## Principles

Supastack registers every leaf as an explicit skill, for example `$supastack:principle-prove-it-works`. Poteto Mode reads the leaf whenever a principle changes a concrete decision and names that decision in its final reply.

## Make it yours

- `$supastack:setup-supastack` writes model-role choices to `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml`.
- `$supastack:automate-me` creates or updates a Codex mode skill under `.agents/skills/` or `$CODEX_HOME/skills/`.
- `$supastack:create-verification-skill` creates a project control skill under `.agents/skills/verify-<app>/`.
- `$supastack:maintain-verification-skill` audits that skill against source and the live product.
