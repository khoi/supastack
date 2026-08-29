#!/bin/sh
set -eu

if [ "${SUPASTACK_FAKE_CODEX:-0}" = 1 ]; then
	{
		printf 'CALL\n'
		printf 'CODEX_HOME=%s\n' "${CODEX_HOME:-}"
		for argument in "$@"; do
			printf 'ARG=%s\n' "$argument"
		done
		printf 'END\n'
	} >> "$SUPASTACK_FAKE_CODEX_LOG"
	exit 0
fi

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
launcher=$script_dir/try-latest.sh
test_script=$script_dir/try-latest.test.sh
test_parent=${TMPDIR:-/tmp}
test_parent=${test_parent%/}
test_root=$(mktemp -d "$test_parent/supastack-try-latest-test.XXXXXX")

cleanup() {
	trap - EXIT HUP INT TERM
	case "$test_root" in
		"$test_parent"/supastack-try-latest-test.*)
			rm -rf -- "$test_root"
			;;
		*)
			printf 'Refusing to remove unexpected test path: %s\n' "$test_root" >&2
			exit 1
			;;
	esac
}

fail() {
	printf 'try-latest test failed: %s\n' "$1" >&2
	exit 1
}

trap cleanup EXIT
trap 'exit 130' HUP INT TERM

mkdir -p "$test_root/bin" "$test_root/project with spaces" "$test_root/source-home" "$test_root/tmp"
ln -s "$test_script" "$test_root/bin/codex"
launch_log=$test_root/launch.log

(
	cd "$test_root"
	SUPASTACK_FAKE_CODEX=1 \
	SUPASTACK_FAKE_CODEX_LOG="$launch_log" \
	CODEX_BIN="$test_root/bin/codex" \
	CODEX_HOME="$test_root/source-home" \
	TMPDIR="$test_root/tmp" \
		"$launcher" --no-auth --cwd "project with spaces" -- 'explain this project'
)

[ "$(grep -c '^ARG=-C$' "$launch_log")" -eq 1 ] || fail 'launcher did not pass exactly one -C option'
awk -v expected="$test_root/project with spaces" '
	previous == "ARG=-C" && $0 == "ARG=" expected { found = 1 }
	{ previous = $0 }
	END { exit !found }
' "$launch_log" || fail 'launcher did not resolve and pass --cwd to Codex'
grep -q '^ARG=explain this project$' "$launch_log" || fail 'launcher did not preserve the prompt argument'

invalid_log=$test_root/invalid.log
invalid_error=$test_root/invalid.err
set +e
SUPASTACK_FAKE_CODEX=1 \
SUPASTACK_FAKE_CODEX_LOG="$invalid_log" \
CODEX_BIN="$test_root/bin/codex" \
CODEX_HOME="$test_root/source-home" \
TMPDIR="$test_root/tmp" \
	"$launcher" --no-auth --cwd "$test_root/missing" > /dev/null 2> "$invalid_error"
invalid_status=$?
set -e

[ "$invalid_status" -eq 2 ] || fail "invalid --cwd exited with status $invalid_status instead of 2"
[ ! -s "$invalid_log" ] || fail 'invalid --cwd invoked Codex'
grep -q '^Codex working directory does not exist or is not a directory:' "$invalid_error" ||
	fail 'invalid --cwd did not report a useful error'

printf 'try-latest launcher tests passed\n'
