#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
PROJECT_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"

# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib-tools.sh"

ensure_managed_tools_path

cd "$PROJECT_ROOT"
load_tools_config

if is_enabled ENABLE_SPARTAN_TEST; then
    require_cmd stest-all
fi

if is_enabled ENABLE_PEST; then
    require_cmd pest
    require_cmd php
fi

quiet="${1:-}"

if [ "$quiet" = "--quiet" ]; then
    stest_cmd="composer stest-q"
    pest_cmd="composer pest-q"
else
    stest_cmd="composer stest"
    pest_cmd="composer pest"
fi

if is_enabled ENABLE_SPARTAN_TEST; then
    run_step "Spartan Test" sh -c "$stest_cmd"
else
    skip_step "Spartan Test"
fi

if is_enabled ENABLE_PEST; then
    run_step "Pest" sh -c "$pest_cmd"
else
    skip_step "Pest"
fi
