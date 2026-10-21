#!/usr/bin/env bash
set -euo pipefail

: "${REPO_NAME:?REPO_NAME is required}"
: "${TAG:?TAG is required}"
release_url=${RELEASE_URL:-"https://github.com/${REPO_NAME}/releases/tag/${TAG}"}
title=${TITLE:-"${REPO_NAME} ${TAG}"}
notes=${NOTES:-}
notes=${notes:0:1000}

jq -n \
  --arg title "$title" \
  --arg url "$release_url" \
  --arg description "$notes" \
  '{embeds: [{title: $title, url: $url, description: $description, color: 5814783}]}'
