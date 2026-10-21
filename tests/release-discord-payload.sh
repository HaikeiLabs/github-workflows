#!/usr/bin/env bash
set -euo pipefail

script="$(dirname "$0")/../.github/scripts/render-payload.sh"
notes=$'Quoted "text", backticks `here`, and\na newline.'
output="$(REPO_NAME='HaikeiLabs/example' TAG='v1.2.3' NOTES="$notes" "$script")"
printf '%s' "$output" | jq -e . >/dev/null
actual_notes="$(printf '%s' "$output" | jq -r '.embeds[0].description')"
[[ "$actual_notes" == "$notes" ]]
long_notes="$(printf '%1100s' '' | tr ' ' x)"
truncated="$(REPO_NAME=example TAG=v1 NOTES="$long_notes" "$script" | jq -r '.embeds[0].description')"
[[ ${#truncated} -eq 1000 ]]
[[ "$(REPO_NAME=HaikeiLabs/example TAG='v1.2.3' "$script" | jq -r '.embeds[0].url')" == 'https://github.com/HaikeiLabs/example/releases/tag/v1.2.3' ]]
printf '%s\n' 'Payload rendering checks passed.'
