#!/usr/bin/env bash
# Guardrail: the skills listed in plugin.json must match the SKILL.md files on disk.
# Run from anywhere; exits non-zero on drift.
set -euo pipefail
cd "$(dirname "$0")/.."

disk=$(find skills -name SKILL.md | sed 's#/SKILL.md##' | sort)
listed=$(grep -oE '"\./skills/[^"]+"' .claude-plugin/plugin.json | tr -d '"' | sed 's#^\./##' | sort)

if diff <(echo "$disk") <(echo "$listed") >/dev/null; then
  echo "OK: plugin.json lists all $(echo "$disk" | wc -l | tr -d ' ') skills on disk."
else
  echo "DRIFT between skills/ and plugin.json:"
  diff <(echo "$disk") <(echo "$listed") || true
  exit 1
fi
