#!/bin/sh

set -eu

PROJECT_ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
TOOLS_CONFIG_FILE="${TOOLS_CONFIG_FILE:-$PROJECT_ROOT/config/tools.conf}"
TOOLS_SETUP_URL="https://github.com/parf/composer-php85-template/blob/main/docs/setup-tools.howto"

ensure_managed_tools_path() {
    if ! command -v php-tools >/dev/null 2>&1; then
        return 0
    fi

    php_tools_path="$(command -v php-tools)"

    if command -v readlink >/dev/null 2>&1; then
        resolved_php_tools_path="$(readlink -f "$php_tools_path" 2>/dev/null || printf '%s\n' "$php_tools_path")"
    else
        resolved_php_tools_path="$php_tools_path"
    fi

    php_tools_root="$(CDPATH= cd -- "$(dirname -- "$resolved_php_tools_path")" && pwd)"
    managed_bin_dir="$php_tools_root/bin"

    if [ -d "$managed_bin_dir" ]; then
        PATH="$managed_bin_dir:$PATH"
        export PATH
    fi
}

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

require_cmd() {
    cmd_name="$1"

    if command -v "$cmd_name" >/dev/null 2>&1; then
        return 0
    fi

    echo "Missing required command: $cmd_name" >&2
    echo "Install shared php-tools and make sure the binaries are on PATH:" >&2
    echo "$TOOLS_SETUP_URL" >&2
    exit 1
}
