---
name: setup-supastack
description: Configure which Codex models and reasoning efforts Supastack uses per role. Detects the native Codex options and writes a TOML override file. Use for $supastack:setup-supastack, "configure Supastack models", or changing Supastack's model or reasoning choices.
---

# Setup Supastack

Write `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml`, which sets Supastack's Codex model and reasoning effort per role. The skills read it and fall back to their inline defaults when a key is absent, so this file is optional.

A scalar role uses a selector table:

```toml
bug_fix = { model = "gpt-5.6-sol", reasoning_effort = "max" }
```

A panel role is a list of selector tables. One selector creates one seat. Keep `model` and `reasoning_effort` separate. Cursor-style combined identifiers such as `gpt-5.6-sol-max` are not valid Codex selectors.

## Steps

### 1. Detect available options

Enumerate the model slugs and reasoning efforts the native Codex subagent interface accepts in this session; that is the dependable source. If Codex exposes a model catalog, use it for completeness. Capture model-specific effort support when the interface exposes it. If you cannot detect model slugs, ask the user to paste the slugs they have access to. Never write a real slug you have not confirmed is available.

The aliases `inherit-parent` and `auto` are always valid for either field. They mean to omit only that native override. This permits an inherited model with an explicit reasoning effort, an explicit model with inherited effort, or both inherited.

### 2. Load current state

The default role mapping is the rule shape shown in step 5 below. If `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml` already exists, read it and treat its values as the current choices. Otherwise start from those defaults.

Normalize the legacy shape without breaking it. A string value is a model-only override with inherited reasoning effort. A list of strings is a panel of model-only overrides. Write the normalized selector-table shape after confirmation.

### 3. Map and confirm

Show every role with its current model and reasoning effort. Mark any real model slug outside the detected set and any unsupported model-effort pair as needing a choice. Ask whether to accept as-is or change specific roles. Offer the detected model slugs, their supported reasoning efforts, and the `inherit-parent` and `auto` aliases. Prefer `request_user_input` over free text.

For panel roles (how critics, arena runners, architect runners, interrogate reviewers), the value is a list and one subagent runs per selector, alias entries included, so the list length sets the count. `arena_cross_judge_pool` is also a list, but Arena selects one entry from it whose model family differs from the parent's when possible. `swarm_workers` is the default selector for every worker unless a race or comparison assigns another selector per arm.

### 4. Validate

Every real model slug written must be in the detected set. Validate each explicit reasoning effort against the selected model when Codex exposes model-specific support. `inherit-parent` and `auto` always pass because the corresponding override is omitted. If a chosen real slug or model-effort pair is unavailable, stop and ask again. A selector Codex cannot resolve breaks every delegation that reads it.

### 5. Write the rule

Write `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml` as TOML with one key per role, using the same keys poteto-mode uses. Overwrite the whole file so re-runs stay idempotent. Shape:

```toml
# Supastack per-role Codex choices. Delete a key to use the skill default.
# Model and reasoning effort are separate native Codex overrides.
# "inherit-parent" and "auto" mean to omit only the override where they appear.
feature_refactoring = { model = "gpt-5.6-luna", reasoning_effort = "xhigh" }
bug_fix = { model = "gpt-5.6-sol", reasoning_effort = "max" }
perf_issue = { model = "gpt-5.6-sol", reasoning_effort = "max" }
hillclimb = { model = "gpt-5.6-sol", reasoning_effort = "max" }
judgment_and_prose = { model = "gpt-5.6-sol", reasoning_effort = "max" }
hardest_tasks = { model = "gpt-5.6-sol", reasoning_effort = "max" }
how_explorer = { model = "gpt-5.6-luna", reasoning_effort = "xhigh" }
how_explainer = { model = "gpt-5.6-sol", reasoning_effort = "max" }
how_critics = [
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-luna", reasoning_effort = "xhigh" },
  { model = "gpt-5.6-terra", reasoning_effort = "xhigh" },
]
why_investigators = { model = "gpt-5.6-luna", reasoning_effort = "xhigh" }
why_synthesizer = { model = "gpt-5.6-sol", reasoning_effort = "max" }
reflect_tooling = { model = "gpt-5.6-sol", reasoning_effort = "max" }
reflect_judgment_divergent_synthesizer = { model = "gpt-5.6-sol", reasoning_effort = "max" }
arena_runners = [
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-luna", reasoning_effort = "xhigh" },
  { model = "gpt-5.6-terra", reasoning_effort = "xhigh" },
]
arena_cross_judge_pool = [
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-luna", reasoning_effort = "xhigh" },
  { model = "gpt-5.6-terra", reasoning_effort = "xhigh" },
]
swarm_workers = { model = "gpt-5.6-luna", reasoning_effort = "xhigh" }
architect_runners = [
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-luna", reasoning_effort = "xhigh" },
  { model = "gpt-5.6-terra", reasoning_effort = "xhigh" },
]
interrogate_reviewers = [
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-sol", reasoning_effort = "max" },
  { model = "gpt-5.6-luna", reasoning_effort = "xhigh" },
  { model = "gpt-5.6-terra", reasoning_effort = "xhigh" },
]
```

### 6. Confirm

Tell the user the rule was written and that it applies to new sessions. State that Codex receives `model` and `reasoning_effort` as separate subagent overrides. Re-running this skill updates it.
