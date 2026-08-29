# Supastack

Supastack is a standalone Codex plugin for rigorous, verifiable engineering workflows. It combines a workflow router, focused skills, engineering principles, native subagent roles, and runtime verification tools.

It includes 37 skills, all 21 principle leaves, 22 routable Poteto playbooks, the Opening a PR delivery helper, three optional native agent roles, and the Poteto helper tools.

Start with the [Supastack guide](plugins/supastack/docs/guide.md) for the workflow families and invocation map.

## How it works

Codex namespaces plugin skills. The main entry point is:

```text
$supastack:poteto-mode
```

The alias is `$supastack:supastack`. Every skill is available as `$supastack:<skill-name>`, for example:

```text
$supastack:how explain how this subsystem works
$supastack:why find the evidence behind this design
$supastack:architect design this before implementing it
$supastack:interrogate review this diff adversarially
$supastack:principle-model-the-domain apply this to the new state shape
```

Each skill contains its complete `SKILL.md` and required references. It does not load a wrapper or compatibility layer.

Poteto Mode selects one of 22 routable playbooks. Opening a PR is a delivery helper invoked by those workflows when the user requests a PR or an authorized workflow includes one. Multi-step workflows use `update_plan`, preference gates use `request_user_input`, and persistent goals requested by the user use `create_goal`. Lower-level agent mechanics use native Codex subagents without naming low-level tool calls.

## Try the latest checkout in isolation

An installed plugin is a cached snapshot. Editing this repository does not update an installed copy or an existing Codex thread on its own.

Run the development launcher to install the current working tree into a fresh temporary `CODEX_HOME`:

```bash
./scripts/try-latest.sh
```

Start with a prompt:

```bash
./scripts/try-latest.sh -- '$supastack:poteto-mode explain how this subsystem works'
```

Start Codex in another project while loading Supastack from this checkout:

```bash
./scripts/try-latest.sh --cwd /absolute/path/to/project -- '$supastack:poteto-mode explain how this subsystem works'
```

The launcher creates a private temporary home, reuses an authentication snapshot when available, installs the repository marketplace and plugin, installs all three native agent roles and model defaults, enables multi-agent support, starts Codex in the Supastack checkout by default, and deletes the home after Codex exits. `--cwd` accepts an existing directory and changes only the launched Codex workspace.

Useful options:

```bash
./scripts/try-latest.sh --no-launch
./scripts/try-latest.sh --no-auth
./scripts/try-latest.sh --keep-home
./scripts/try-latest.sh --cwd /absolute/path/to/project
```

A fresh home has no stale plugin snapshot, so this path always tests the latest checkout without a cachebuster. `--keep-home` retains the isolated installation for inspection.

## Install persistently

Add this repository as a local marketplace and install the plugin:

```bash
codex plugin marketplace add /absolute/path/to/supastack
codex plugin add supastack@personal
```

Install the optional native roles and default model map:

```bash
/absolute/path/to/supastack/plugins/supastack/scripts/install-agent-roles.sh
```

The roles are `supastack_worker`, `supastack_verifier`, and `comment_sicko`. Codex plugins cannot install role TOMLs themselves, so persistent use requires the separate installer. Skills fall back to built-in Codex roles when these templates are absent.

After changing the plugin, update its cachebuster and reinstall the snapshot:

```bash
python3 "${CODEX_HOME:-$HOME/.codex}/skills/.system/plugin-creator/scripts/update_plugin_cachebuster.py" \
  /absolute/path/to/supastack/plugins/supastack

codex plugin add supastack@personal
```

Start a new Codex thread after reinstalling. Existing threads keep the skill and tool snapshot they loaded at startup.

## Development and verification

Check every skill, policy file, and playbook:

```bash
plugins/supastack/scripts/check-skills.rb
```

Audit the package, every skill, local links, scripts, JSON, and TOML:

```bash
plugins/supastack/scripts/audit-plugin.sh
```

Test the isolated development launcher:

```bash
scripts/try-latest.test.sh
```

The `orch` and `watch-pr` TypeScript tools live under `plugins/supastack/tools/poteto-mode/` and run through small launchers. The launchers install dependencies into a versioned cache under `${CODEX_HOME:-$HOME/.codex}/supastack/tool-cache/`, outside the plugin source:

```bash
plugins/supastack/scripts/orch --help
plugins/supastack/scripts/watch-pr --help
plugins/supastack/scripts/worktree-audit .
```

## Capability limits

External workflows depend on the active capabilities. Slack, tracker, observability, analytics, browser, GitHub, Graphite, and app-control steps require a matching installed tool and authorization for the action. Missing runtime control stays a verification gap; a build does not replace real-surface proof.

Workflow autonomy changes engineering method, not authorization. Codex system, developer, user, sandbox, and approval rules always win.
