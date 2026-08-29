# Set up Supastack

You can install Supastack into your normal Codex home or run the checkout in a temporary home. Start with the temporary path when you are changing the plugin. Use the persistent path when you want Supastack in future sessions.

## Try the checkout in isolation

From the Supastack repository, run:

```bash
./scripts/try-latest.sh
```

The launcher creates a private temporary `CODEX_HOME`, installs the marketplace and plugin from the current working tree, adds the three native agent roles, and launches Codex. It removes the temporary home when Codex exits.

Use another project as the Codex workspace while loading Supastack from this checkout:

```bash
./scripts/try-latest.sh --cwd /absolute/path/to/project -- \
  '$supastack:poteto-mode explain how this project works'
```

The launcher rejects a missing or inaccessible workspace before it installs anything. See the [repository README](../../../../README.md) for authentication, inspection, and no-launch options.

## Install it into your normal Codex home

Add the repository as a personal marketplace, then install its entry:

```bash
codex plugin marketplace add /absolute/path/to/supastack
codex plugin add supastack@personal
```

Install the optional native roles and default model map:

```bash
/absolute/path/to/supastack/plugins/supastack/scripts/install-agent-roles.sh
```

Supastack defines these roles:

| Role | Job |
| --- | --- |
| `supastack_worker` | Implements one owned slice after the parent selects a playbook and defines proof. |
| `supastack_verifier` | Exercises the finished artifact and returns `VERIFIED`, `NOT VERIFIED`, or `INCONCLUSIVE`. |
| `comment_sicko` | Reviews comments under the narrow rules used by `$supastack:no-comments`. |

Skills fall back to built-in Codex roles when the templates are absent. Start a new Codex session after installation. A running session keeps the plugin and skill snapshot it loaded at startup.

## Choose models by role

In the new session, invoke:

```text
$supastack:setup-supastack
```

The skill detects models exposed to the current Codex session, shows the mapping, and writes `${CODEX_HOME:-$HOME/.codex}/supastack/models.toml`. A missing key uses Supastack's default. The values `inherit-parent` and `auto` tell a subagent to inherit the parent model.

Panel keys hold arrays. One entry creates one panel seat, so the array length controls the number of reviewers or candidates. Re-run the setup skill when model access or your preferences change.

The setup flow also checks whether the project has a verification skill or another way to drive its real surface. If it finds none, it can offer `$supastack:create-verification-skill`.

## Run your first task

Choose a small change with a visible finish condition:

```text
$supastack:poteto-mode add a --json flag to this command. Keep text output byte-identical and run both forms against the sample project.
```

Poteto Mode reads its principle index, chooses the Feature playbook, and puts the playbook steps into the Codex plan. A skipped step remains visible with a reason.

Supastack does not rely on a persistent mode flag. Invoke `$supastack:poteto-mode` when you want its router to govern a task or a later turn.

Next: [Route work through Poteto Mode](./02-poteto-mode.md).
