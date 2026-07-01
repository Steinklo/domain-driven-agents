#!/usr/bin/env bash
# Guardrail: plugin.json must match what's on disk, and every skill an agent
# references must exist. Run from anywhere; exits non-zero on drift.
set -euo pipefail
cd "$(dirname "$0")/.."

fail=0

# 1. Skills listed in plugin.json == SKILL.md folders on disk
disk_skills=$(find skills -name SKILL.md | sed 's#/SKILL.md##' | sort)
listed_skills=$(grep -oE '"\./skills/[^"]+"' .claude-plugin/plugin.json | tr -d '"' | sed 's#^\./##' | sort)
if diff <(echo "$disk_skills") <(echo "$listed_skills") >/dev/null; then
  echo "OK: plugin.json lists all $(echo "$disk_skills" | wc -l | tr -d ' ') skills on disk."
else
  echo "DRIFT between skills/ and plugin.json:"; diff <(echo "$disk_skills") <(echo "$listed_skills") || true; fail=1
fi

# 2. Agents listed in plugin.json == agent .md files on disk
disk_agents=$(find agents -name '*.md' | sed 's#^\./##' | sort)
listed_agents=$(grep -oE '"\./agents/[^"]+"' .claude-plugin/plugin.json | tr -d '"' | sed 's#^\./##' | sort)
if diff <(echo "$disk_agents") <(echo "$listed_agents") >/dev/null; then
  echo "OK: plugin.json lists all $(echo "$disk_agents" | wc -l | tr -d ' ') agents on disk."
else
  echo "DRIFT between agents/ and plugin.json:"; diff <(echo "$disk_agents") <(echo "$listed_agents") || true; fail=1
fi

# 3. Every skill named in an agent's `skills:` frontmatter must exist as a folder
valid=$(echo "$disk_skills" | sed 's#^skills/##')
for a in agents/*.md; do
  refs=$(sed -n 's/^skills: \[\(.*\)\]/\1/p' "$a" | tr ',' '\n' | tr -d ' ')
  for r in $refs; do
    if ! echo "$valid" | grep -qx "$r"; then
      echo "BROKEN: $a references unknown skill '$r'"; fail=1
    fi
  done
done
[ "$fail" -eq 0 ] && echo "OK: every agent skill reference resolves."

exit "$fail"
