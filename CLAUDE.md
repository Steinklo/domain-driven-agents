# CLAUDE.md

This repo is a collection of **language-agnostic Domain-Driven Design skills** — see
[`README.md`](README.md). Each skill lives at `skills/<name>/SKILL.md` with `name` +
`description` frontmatter and is listed in `.claude-plugin/plugin.json`.

When adding or editing a skill:
- Keep it language-agnostic — teach the DDD concept, not code in any specific language.
- Follow the existing shape: definition, why it matters, core rules, a neutral example,
  anti-patterns, and `[[links]]` to related skills (use valid sibling folder names).
- Add the folder to `plugin.json` and run `scripts/check-plugin.sh` to confirm the
  manifest matches the skills on disk.
