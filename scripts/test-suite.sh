#!/bin/sh

set -eu

quiet="${1:-}"

if [ "$quiet" = "--quiet" ]; then
    stest_cmd="composer stest-q"
    pest_cmd="composer pest-q"
else
    stest_cmd="composer stest"
    pest_cmd="composer pest"
fi

# Comment any runner you do not want in this template clone.
$stest_cmd
$pest_cmd
