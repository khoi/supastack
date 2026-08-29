#!/bin/sh
set -eu

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
plugin_root=$(CDPATH='' cd -- "$script_dir/.." && pwd)
target_home=${1:-${CODEX_HOME:-"$HOME/.codex"}}

mkdir -p "$target_home/agents" "$target_home/supastack"
for role_template in "$plugin_root/assets/agent-roles"/*.toml; do
	cp "$role_template" "$target_home/agents/"
done
cp "$plugin_root/assets/models.toml" "$target_home/supastack/models.toml"

printf 'Installed Supastack agent roles and model defaults into %s\n' "$target_home"
