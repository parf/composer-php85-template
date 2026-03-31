#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
PROJECT_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"

# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib-tools.sh"

cd "$PROJECT_ROOT"
load_tools_config

if is_enabled ENABLE_PHPDOCUMENTOR; then
    run_step "phpDocumentor" composer phpdoc
else
    skip_step "phpDocumentor"
fi
