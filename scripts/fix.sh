#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
PROJECT_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"

# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib-tools.sh"

ensure_managed_tools_path

cd "$PROJECT_ROOT"
load_tools_config

if is_enabled ENABLE_MAGO; then
    require_cmd mago
fi

if is_enabled ENABLE_CS_FIXER; then
    require_cmd php-cs-fixer
fi

if is_enabled ENABLE_PSALM; then
    require_cmd psalm.phar
fi

if is_enabled ENABLE_RECTOR; then
    require_cmd rector
fi

if is_enabled ENABLE_PSALM; then
    run_step "Psalm fix" composer psalm-fix
else
    skip_step "Psalm"
fi

if is_enabled ENABLE_RECTOR; then
    run_step "Rector" composer rector
else
    skip_step "Rector"
fi

if is_enabled ENABLE_MAGO; then
    run_step "Mago format" composer mago-format
else
    skip_step "Mago"
fi

if is_enabled ENABLE_CS_FIXER; then
    run_step "php-cs-fixer fix" composer cs-fix
else
    skip_step "php-cs-fixer"
fi
