#!/bin/sh

set -eu

PROJECT_ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

composer dry
composer test-q

echo
echo "$(tput setab 2)$(tput setaf 7)*** CHECK SUCCESS ***$(tput sgr0)"
echo
