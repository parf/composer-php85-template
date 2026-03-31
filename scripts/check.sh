#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
PROJECT_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"

# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib-tools.sh"

ensure_managed_tools_path

cd "$PROJECT_ROOT"
load_tools_config
require_cmd php

if is_enabled ENABLE_LINT; then
    require_cmd find
    require_cmd xargs
fi

if is_enabled ENABLE_MAGO; then
    require_cmd mago
fi

if is_enabled ENABLE_CS_FIXER; then
    require_cmd php-cs-fixer
fi

if is_enabled ENABLE_PHPSTAN; then
    require_cmd phpstan
fi

if is_enabled ENABLE_PSALM; then
    require_cmd psalm.phar
fi

if is_enabled ENABLE_RECTOR; then
    require_cmd rector
fi

if is_enabled ENABLE_SPARTAN_TEST; then
    require_cmd stest-all
fi

if is_enabled ENABLE_PEST; then
    require_cmd pest
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT INT TERM

if [ -n "${TERM:-}" ] && tput sgr0 >/dev/null 2>&1; then
    ok_mark="$(tput setaf 2)[OK]$(tput sgr0)"
    skip_mark="$(tput setaf 3)[SKIP]$(tput sgr0)"
    fail_mark="$(tput setaf 1)[FAIL]$(tput sgr0)"
    success_banner="$(tput setab 2)$(tput setaf 7)*** CHECK SUCCESS ***$(tput sgr0)"
else
    ok_mark="[OK]"
    skip_mark="[SKIP]"
    fail_mark="[FAIL]"
    success_banner="*** CHECK SUCCESS ***"
fi

run_check_step() {
    label="$1"
    log_file="$2"
    shift 2

    if "$@" >"$log_file" 2>&1; then
        printf '==> %s: %s\n' "$label" "$ok_mark"
    else
        printf '==> %s: %s\n' "$label" "$fail_mark"
        cat "$log_file"
        exit 1
    fi
}

skip_check_step() {
    label="$1"
    printf '==> %s: %s\n' "$label" "$skip_mark"
}

if is_enabled ENABLE_LINT; then
    run_check_step "PHP lint" "$tmp_dir/lint.log" composer lint
else
    skip_check_step "PHP lint"
fi

if is_enabled ENABLE_MAGO; then
    run_check_step "Mago" "$tmp_dir/mago.log" sh -c '
        composer mago-lint &&
        composer mago-analyze &&
        composer mago-format-check
    '
else
    skip_check_step "Mago"
fi

if is_enabled ENABLE_CS_FIXER; then
    run_check_step "php-cs-fixer dry run" "$tmp_dir/cs.log" composer cs-dry
else
    skip_check_step "php-cs-fixer dry run"
fi

if is_enabled ENABLE_PHPSTAN; then
    run_check_step "PHPStan" "$tmp_dir/phpstan.log" composer stan
else
    skip_check_step "PHPStan"
fi

if is_enabled ENABLE_PSALM; then
    run_check_step "Psalm" "$tmp_dir/psalm.log" composer psalm
else
    skip_check_step "Psalm"
fi

if is_enabled ENABLE_RECTOR; then
    run_check_step "Rector dry run" "$tmp_dir/rector.log" composer rector-dry
else
    skip_check_step "Rector dry run"
fi

if is_enabled ENABLE_SPARTAN_TEST; then
    run_check_step "Spartan Test" "$tmp_dir/stest.log" composer stest-q
else
    skip_check_step "Spartan Test"
fi

if is_enabled ENABLE_PEST; then
    run_check_step "Pest" "$tmp_dir/pest.log" composer pest-q
else
    skip_check_step "Pest"
fi

echo
echo "$success_banner"
echo
