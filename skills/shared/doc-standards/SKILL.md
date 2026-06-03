---
name: doc-standards
scope: shared
used-by: [documenter]
description: Defines which docs (README, glossary, ADRs, out-of-scope, agents) exist, who updates them after approval, and how to write tight SKILL.md reference files. Use when documenting approved work, updating the glossary or ADRs post-review, or authoring/splitting a SKILL.md.
---

# Documentation Standards

Docs describe **what was approved** — never speculative or aspirational.

## Required files

These live in the **target project**, not this pipeline repo.

| File | Purpose | Updated by |
|---|---|---|
| `docs/contracts/<task>.md` | The Planner's contract per task (immutable spec) | Planner |
| `README.md` (root) | Project overview, setup, architecture | Documenter |
| `docs/glossary.md` | Ubiquitous language per bounded context | Planner seeds during grilling; Documenter keeps current |
| `docs/adr/NNNN-*.md` | Architecture Decision Records — non-obvious choices | Documenter (see `decision-records`) |
| `docs/out-of-scope/*.md` | Deliberately rejected work, with reasoning | Documenter (see `decision-records`) |
| `docs/agents.md` | Agent roles, skills, pipeline description | Documenter |

## Rules

1. **Update after approval, never during development.** The Documenter runs
   after the Reviewer approves.
2. **Keep it short.** If it takes more than 2 minutes to read, it's too long.
3. **Use tables and diagrams over prose** where possible.
4. **Glossary entries follow the format:**
   `| Term | Definition | Bounded Context |`
5. **No implementation details in the glossary** — describe *what*, not *how*.

## Writing skills

These standards govern the skills in this repo too — a `SKILL.md` is reference
documentation an agent reads under context pressure.

1. **Frontmatter carries `name`, `scope`, `used-by`, and `description`.** The
   `description` is one line: *what it does* + *"Use when …"* with concrete triggers.
   It's the only thing a scanning reader (or a model deciding to load it) sees.
2. **Keep `SKILL.md` tight — aim under ~100 lines.** It's read every task; every
   line costs context.
3. **Split when it grows or splits in topic.** When a skill exceeds the budget or
   covers distinct sub-domains, move detail into sibling files
   (`EXAMPLES.md`, `<topic>.md`) and link to them.
4. **Link one level deep only.** A reader should never have to chase a chain of
   references to understand the core rule.

## Don't

- Document code that might change in the next review round.
- Duplicate information that lives in the code (e.g., listing every field of a class).
- Write tutorials — this is reference documentation.
