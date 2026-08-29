#!/bin/sh
set -eu

usage() {
	cat <<'EOF'
Usage: scripts/try-latest.sh [options] [--] [codex arguments...]

Install the current Supastack checkout into a fresh temporary CODEX_HOME and
start Codex there.

Options:
  --cwd DIR    Start Codex in DIR instead of the Supastack checkout.
  --keep-home  Keep the temporary CODEX_HOME after Codex exits.
  --no-auth    Do not copy or import existing Codex authentication.
  --no-launch  Install and validate the plugin without starting Codex.
  -h, --help   Show this help.

Environment:
  CODEX_BIN                    Codex executable. Default: codex
  SUPASTACK_KEEP_CODEX_HOME    Set to 1 to keep the temporary home.
  SUPASTACK_REUSE_AUTH         Set to 0 to disable authentication reuse.
EOF
}

keep_home=${SUPASTACK_KEEP_CODEX_HOME:-0}
reuse_auth=${SUPASTACK_REUSE_AUTH:-1}
launch=1
launch_cwd=
launch_cwd_set=0

while [ "$#" -gt 0 ]; do
	case "$1" in
		--cwd)
			if [ "$#" -lt 2 ]; then
				printf 'Option --cwd requires a directory.\n' >&2
				exit 2
			fi
			launch_cwd=$2
			launch_cwd_set=1
			shift 2
			;;
		--keep-home)
			keep_home=1
			shift
			;;
		--no-auth)
			reuse_auth=0
			shift
			;;
		--no-launch)
			launch=0
			shift
			;;
		-h|--help)
			usage
			exit 0
			;;
		--)
			shift
			break
			;;
		*)
			break
			;;
	esac
done

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(CDPATH='' cd -- "$script_dir/.." && pwd)
plugin_root=$repo_root/plugins/supastack
role_templates=$plugin_root/assets/agent-roles
codex_bin=${CODEX_BIN:-codex}
source_codex_home=${CODEX_HOME:-"$HOME/.codex"}

if [ "$launch_cwd_set" = 0 ]; then
	launch_cwd=$repo_root
elif [ ! -d "$launch_cwd" ]; then
	printf 'Codex working directory does not exist or is not a directory: %s\n' "$launch_cwd" >&2
	exit 2
elif ! launch_cwd=$(CDPATH='' cd -- "$launch_cwd" && pwd); then
	printf 'Codex working directory is not accessible: %s\n' "$launch_cwd" >&2
	exit 2
fi

trial_parent=${TMPDIR:-/tmp}
trial_parent=${trial_parent%/}
trial_codex_home=$(mktemp -d "$trial_parent/supastack-codex.XXXXXX")
chmod 700 "$trial_codex_home"

cleanup() {
	exit_status=$?
	trap - EXIT HUP INT TERM
	if [ "$keep_home" = 1 ]; then
		printf 'Kept temporary CODEX_HOME at %s\n' "$trial_codex_home"
	else
		case "$trial_codex_home" in
			"$trial_parent"/supastack-codex.*)
				rm -rf -- "$trial_codex_home"
				;;
			*)
				printf 'Refusing to remove unexpected path: %s\n' "$trial_codex_home" >&2
				exit_status=1
				;;
		esac
	fi
	exit "$exit_status"
}

trap cleanup EXIT
trap 'exit 130' HUP INT TERM

if ! command -v "$codex_bin" >/dev/null 2>&1; then
	printf 'Codex executable not found: %s\n' "$codex_bin" >&2
	exit 1
fi

if [ ! -f "$repo_root/.agents/plugins/marketplace.json" ] || [ ! -f "$plugin_root/.codex-plugin/plugin.json" ]; then
	printf 'Run this script from a complete Supastack checkout.\n' >&2
	exit 1
fi

mkdir -p "$trial_codex_home/agents" "$trial_codex_home/supastack"
for role_template in "$role_templates"/*.toml; do
	cp "$role_template" "$trial_codex_home/agents/"
done
cp "$plugin_root/assets/models.toml" "$trial_codex_home/supastack/models.toml"

if [ "$reuse_auth" = 1 ]; then
	if [ -n "${CODEX_ACCESS_TOKEN:-}" ]; then
		printf '%s' "$CODEX_ACCESS_TOKEN" |
			CODEX_HOME="$trial_codex_home" "$codex_bin" login --with-access-token >/dev/null
		printf 'Imported CODEX_ACCESS_TOKEN into the temporary home.\n'
	elif [ -f "$source_codex_home/auth.json" ]; then
		cp "$source_codex_home/auth.json" "$trial_codex_home/auth.json"
		chmod 600 "$trial_codex_home/auth.json"
		printf 'Copied an authentication snapshot into the temporary home.\n'
	elif [ -n "${OPENAI_API_KEY:-}" ]; then
		printf '%s' "$OPENAI_API_KEY" |
			CODEX_HOME="$trial_codex_home" "$codex_bin" login --with-api-key >/dev/null
		printf 'Imported OPENAI_API_KEY into the temporary home.\n'
	else
		printf 'No reusable authentication found. Codex may ask you to sign in.\n'
	fi
fi

CODEX_HOME="$trial_codex_home" "$codex_bin" plugin marketplace add "$repo_root" --json >/dev/null
CODEX_HOME="$trial_codex_home" "$codex_bin" plugin add supastack@personal --json >/dev/null

printf 'Installed the current checkout into %s\n' "$trial_codex_home"
printf 'Loaded agent roles: supastack_worker, supastack_verifier, comment_sicko\n'

if [ "$launch" = 0 ]; then
	CODEX_HOME="$trial_codex_home" "$codex_bin" plugin list
	exit 0
fi

CODEX_HOME="$trial_codex_home" "$codex_bin" --enable multi_agent_v2 -C "$launch_cwd" "$@"
