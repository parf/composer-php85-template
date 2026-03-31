#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
PROJECT_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"

# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib-tools.sh"

cd "$PROJECT_ROOT"
load_tools_config

if is_enabled ENABLE_LINT; then
    run_step "PHP lint" composer lint
else
    skip_step "PHP lint"
fi

if is_enabled ENABLE_MAGO; then
    echo "==> Mago"
    composer mago-lint
    composer mago-analyze
    composer mago-format-check
else
    skip_step "Mago"
fi

if is_enabled ENABLE_CS_FIXER; then
    run_step "php-cs-fixer dry run" composer cs-dry
else
    skip_step "php-cs-fixer"
fi

parallel_tmp="$(mktemp -d)"
trap 'rm -rf "$parallel_tmp"' EXIT INT TERM

parallel_status=0

if is_enabled ENABLE_PHPSTAN; then
    (
        composer stan
    ) >"$parallel_tmp/phpstan.log" 2>&1 &
    phpstan_pid="$!"
else
    skip_step "PHPStan"
    phpstan_pid=""
fi

if is_enabled ENABLE_PSALM; then
    (
        composer psalm
    ) >"$parallel_tmp/psalm.log" 2>&1 &
    psalm_pid="$!"
else
    skip_step "Psalm"
    psalm_pid=""
fi

if is_enabled ENABLE_RECTOR; then
    (
        composer rector-dry
    ) >"$parallel_tmp/rector.log" 2>&1 &
    rector_pid="$!"
else
    skip_step "Rector"
    rector_pid=""
fi

if [ -n "$phpstan_pid" ]; then
    echo "==> PHPStan"
    if wait "$phpstan_pid"; then
        cat "$parallel_tmp/phpstan.log"
    else
        parallel_status=1
        cat "$parallel_tmp/phpstan.log"
    fi
fi

if [ -n "$psalm_pid" ]; then
    echo "==> Psalm"
    if wait "$psalm_pid"; then
        cat "$parallel_tmp/psalm.log"
    else
        parallel_status=1
        cat "$parallel_tmp/psalm.log"
    fi
fi

if [ -n "$rector_pid" ]; then
    echo "==> Rector dry run"
    if wait "$rector_pid"; then
        cat "$parallel_tmp/rector.log"
    else
        parallel_status=1
        cat "$parallel_tmp/rector.log"
    fi
fi

if [ "$parallel_status" -ne 0 ]; then
    exit "$parallel_status"
fi
