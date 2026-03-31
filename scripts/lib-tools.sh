#!/bin/sh

set -eu

PROJECT_ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
TOOLS_CONFIG_FILE="${TOOLS_CONFIG_FILE:-$PROJECT_ROOT/config/tools.conf}"

load_tools_config() {
    if [ ! -f "$TOOLS_CONFIG_FILE" ]; then
        echo "Missing tools config: $TOOLS_CONFIG_FILE" >&2
        exit 1
    fi

    # shellcheck disable=SC1090
    . "$TOOLS_CONFIG_FILE"
}

is_enabled() {
    var_name="$1"
    eval "var_value=\${$var_name:-0}"
    [ "$var_value" = "1" ]
}

run_step() {
    label="$1"
    shift

    echo "==> $label"
    "$@"
}

skip_step() {
    label="$1"
    echo "==> skip $label"
}
