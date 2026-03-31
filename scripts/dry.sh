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
    run_step "Mago lint" composer mago-lint
    run_step "Mago analyze" composer mago-analyze
    run_step "Mago format check" composer mago-format-check
else
    skip_step "Mago"
fi

if is_enabled ENABLE_CS_FIXER; then
    run_step "php-cs-fixer dry run" composer cs-dry
else
    skip_step "php-cs-fixer"
fi

if is_enabled ENABLE_PHPSTAN; then
    run_step "PHPStan" composer stan
else
    skip_step "PHPStan"
fi

if is_enabled ENABLE_PSALM; then
    run_step "Psalm" composer psalm
else
    skip_step "Psalm"
fi

if is_enabled ENABLE_RECTOR; then
    run_step "Rector dry run" composer rector-dry
else
    skip_step "Rector"
fi
