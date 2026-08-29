#!/bin/sh
set -eu

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
plugin_root=$(CDPATH='' cd -- "$script_dir/.." && pwd)
codex_home=${CODEX_HOME:-"$HOME/.codex"}
plugin_validator=$codex_home/skills/.system/plugin-creator/scripts/validate_plugin.py
skill_validator=$codex_home/skills/.system/skill-creator/scripts/quick_validate.py

if [ "$#" -ne 0 ]; then
	printf 'usage: %s\n' "$0" >&2
	exit 2
fi

"$script_dir/check-skills.rb"
"$script_dir/check-links.rb" "$plugin_root"

if [ ! -f "$plugin_validator" ] || [ ! -f "$skill_validator" ]; then
	printf 'Codex plugin and skill validators are not installed under %s\n' "$codex_home" >&2
	exit 1
fi

uv run --with pyyaml python "$plugin_validator" "$plugin_root"
find "$plugin_root/skills" -mindepth 2 -maxdepth 2 -name SKILL.md -print | sort | while IFS= read -r skill; do
	uv run --with pyyaml python "$skill_validator" "$(dirname "$skill")" >/dev/null
done

find "$script_dir" -maxdepth 1 -type f -perm -u+x -print | sort | while IFS= read -r executable; do
	case "$executable" in
		*.rb) ruby -c "$executable" >/dev/null ;;
		*) head -1 "$executable" | grep -q 'sh\|bash' && sh -n "$executable" || true ;;
	esac
done

ruby -rjson -e 'ARGV.each { |path| JSON.parse(File.read(path)) }' \
	"$plugin_root/.codex-plugin/plugin.json" \
	"$plugin_root/tools/poteto-mode/package.json"

uv run --python 3.12 python -c 'import pathlib, tomllib, sys; [tomllib.loads(pathlib.Path(p).read_text()) for p in sys.argv[1:]]' \
	"$plugin_root/assets/models.toml" \
	"$plugin_root/assets/agent-roles/comment-sicko.toml" \
	"$plugin_root/assets/agent-roles/supastack-worker.toml" \
	"$plugin_root/assets/agent-roles/supastack-verifier.toml"

printf 'Supastack plugin audit passed\n'
