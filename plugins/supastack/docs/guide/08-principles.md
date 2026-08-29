# Steer with principles

Supastack ships 21 principle skills. Poteto Mode reads their index at the start of a multi-step workflow and loads a leaf when that principle changes a decision. You can invoke any leaf yourself or use its name as a correction.

```text
$supastack:principle-prove-it-works run the real import flow and show the records it wrote.
```

A final report should name the choice that each applied principle changed. A bare principle citation does not show application.

## Scope and design

- [Laziness Protocol](../../skills/principle-laziness-protocol/SKILL.md) favors deletion and the smallest complete change.
- [Foundational Thinking](../../skills/principle-foundational-thinking/SKILL.md) chooses core types and shared state before writing logic.
- [Redesign from First Principles](../../skills/principle-redesign-from-first-principles/SKILL.md) incorporates a requirement as if it had existed from the start.
- [Subtract Before You Add](../../skills/principle-subtract-before-you-add/SKILL.md) removes obsolete structure before building its replacement.
- [Minimize Reader Load](../../skills/principle-minimize-reader-load/SKILL.md) reduces layers and hidden state that a reader must retain.
- [Outcome-Oriented Execution](../../skills/principle-outcome-oriented-execution/SKILL.md) drives a migration toward its target instead of preserving throwaway intermediate APIs.
- [Experience First](../../skills/principle-experience-first/SKILL.md) chooses the user's result over implementation convenience.
- [Exhaust the Design Space](../../skills/principle-exhaust-the-design-space/SKILL.md) compares competing prototypes when precedent cannot settle the choice.
- [Build the Lever](../../skills/principle-build-the-lever/SKILL.md) creates the script, generator, or check that performs or proves repeatable work.

## Architecture

- [Model the Domain](../../skills/principle-model-the-domain/SKILL.md) encodes domain rules in one structure instead of scattered conditions.
- [Boundary Discipline](../../skills/principle-boundary-discipline/SKILL.md) validates external input at the boundary and keeps internal logic clean.
- [Type System Discipline](../../skills/principle-type-system-discipline/SKILL.md) models variants and rejects invalid states before runtime.
- [Make Operations Idempotent](../../skills/principle-make-operations-idempotent/SKILL.md) makes retries converge on the same result.
- [Migrate Callers Then Delete Legacy APIs](../../skills/principle-migrate-callers-then-delete-legacy-apis/SKILL.md) moves callers and removes the old API in one wave.
- [Separate Before Serializing Shared State](../../skills/principle-separate-before-serializing-shared-state/SKILL.md) removes unnecessary sharing before adding locks or queues.

## Verification and delivery

- [Prove It Works](../../skills/principle-prove-it-works/SKILL.md) exercises the artifact the user depends on.
- [Fix Root Causes](../../skills/principle-fix-root-causes/SKILL.md) reproduces the symptom and traces it to the cause before editing.
- [Sequence Verifiable Units](../../skills/principle-sequence-verifiable-units/SKILL.md) ends each small unit with evidence before starting the next.

## Delegation and learning

- [Guard the Context Window](../../skills/principle-guard-the-context-window/SKILL.md) moves bulk reading into bounded subagents and returns summaries to the parent.
- [Never Block on the Human](../../skills/principle-never-block-on-the-human/SKILL.md) proceeds on reversible work inside the authorized scope. It does not grant permission for external or destructive actions.
- [Encode Lessons in Structure](../../skills/principle-encode-lessons-in-structure/SKILL.md) turns repeated advice into a test, lint, type, script, or metadata rule.

## Correct a run with one name

```text
Apply subtract before you add. Remove obsolete adapters before designing the replacement.
```

```text
Apply separate before serializing shared state. Give each writer its own worktree instead of adding a lock.
```

```text
Apply encode lessons in structure. Add a check that prevents this regression instead of adding another warning paragraph.
```

Use the full skill invocation when you want a principle to be the task. Use the short name when Poteto Mode has already loaded the workflow and needs a course correction.

Next: [Make it yours](./09-make-it-yours.md).
