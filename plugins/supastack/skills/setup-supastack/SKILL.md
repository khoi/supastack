---
name: setup-supastack
description: Configure which models Supastack uses per role. Detects your available Codex models and writes a TOML file that overrides the skill defaults. Use for $supastack:setup-supastack, "configure Supastack models", or changing Supastack's model choices.
---

# Setup Supastack

Write `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml`, which sets Supastack's Codex model per role. The skills read it and fall back to their inline defaults when a key is absent, so this file is optional.

## Steps

### 1. Detect available models

Enumerate the model slugs the native Codex subagent interface accepts in this session; that is the dependable source. If Codex exposes a model catalog, use it for completeness. If you cannot detect any, ask the user to paste the slugs they have access to. Never write a real slug you have not confirmed is available. The aliases `inherit-parent` and `auto` are always valid even though they are not detected slugs.

### 2. Load current state

The default role-to-model mapping is the rule shape shown in step 5 below. If `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml` already exists, read it and treat its values as the current choices. Otherwise start from those defaults.

### 3. Map and confirm

Show every role with its current model, marking any real slug not in the detected set as needing a choice. Ask whether to accept as-is or change specific roles, offering the detected models plus `inherit-parent` and `auto` (both mean: this role runs on the parent chat model, which is how Auto users stay on Auto) as the options. Prefer `request_user_input` over free text. For panel roles (how critics, arena runners, architect runners, interrogate reviewers) the value is a list, and one subagent runs per entry, alias entries included, so the list length sets the count. `arena_cross_judge_pool` is also a list, but Arena selects one value from it whose model family differs from the parent's when possible. `swarm_workers` is the default model for every worker unless a race or comparison assigns another model per arm.

### 4. Validate

Every real slug written must be in the detected set; `inherit-parent` and `auto` always pass. If a chosen real slug is not available, stop and ask again. A rule pointing at a model the user cannot use breaks every delegation that reads it.

### 5. Write the rule

Write `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml` as TOML with one key per role, using the same keys poteto-mode uses. Overwrite the whole file so re-runs stay idempotent. Shape:

```toml
# Supastack per-role model choices. Delete a key to use the skill default.
# "inherit-parent" and "auto" mean to omit the subagent model override.
feature_refactoring = "gpt-5.6-luna"
bug_fix = "gpt-5.6-sol"
perf_issue = "gpt-5.6-sol"
hillclimb = "gpt-5.6-sol"
judgment_and_prose = "gpt-5.6-sol"
hardest_tasks = "gpt-5.6-sol"
how_explorer = "gpt-5.6-luna"
how_explainer = "gpt-5.6-sol"
how_critics = ["gpt-5.6-sol", "gpt-5.6-sol", "gpt-5.6-luna", "gpt-5.6-terra"]
why_investigators = "gpt-5.6-luna"
why_synthesizer = "gpt-5.6-sol"
reflect_tooling = "gpt-5.6-sol"
reflect_judgment_divergent_synthesizer = "gpt-5.6-sol"
arena_runners = ["gpt-5.6-sol", "gpt-5.6-sol", "gpt-5.6-luna", "gpt-5.6-terra"]
arena_cross_judge_pool = ["gpt-5.6-sol", "gpt-5.6-luna", "gpt-5.6-terra"]
swarm_workers = "gpt-5.6-luna"
architect_runners = ["gpt-5.6-sol", "gpt-5.6-sol", "gpt-5.6-luna", "gpt-5.6-terra"]
interrogate_reviewers = ["gpt-5.6-sol", "gpt-5.6-sol", "gpt-5.6-luna", "gpt-5.6-terra"]
```

### 6. Confirm

Tell the user the rule was written and that it applies to new sessions. Re-running this skill updates it.

### 7. Offer a verification skill (optional)

Check whether the project has a way to drive the real app for proof (a `verify-*` skill, or an existing harness). If not, offer once: "want a project-local verification skill, so agents can drive the app the way a user does and prove changes work? I can generate one with $supastack:create-verification-skill." On yes, invoke `$supastack:create-verification-skill`. On no, move on without pushing.
