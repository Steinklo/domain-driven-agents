---
name: doc-standards
scope: shared
used-by: [documenter]
---

# Documentation Standards

Docs describe **what was approved** — never speculative or aspirational.

## Required files

| File | Purpose | Updated by |
|---|---|---|
| `README.md` (root) | Project overview, setup, architecture | Documenter |
| `docs/glossary.md` | Ubiquitous language per bounded context | Documenter |
| `docs/agents.md` | Agent roles, skills, pipeline description | Documenter |

## Rules

1. **Update after approval, never during development.** The Documenter runs
   after the Reviewer approves.
2. **Keep it short.** If it takes more than 2 minutes to read, it's too long.
3. **Use tables and diagrams over prose** where possible.
4. **Glossary entries follow the format:**
   `| Term | Definition | Bounded Context |`
5. **No implementation details in the glossary** — describe *what*, not *how*.

## Don't

- Document code that might change in the next review round.
- Duplicate information that lives in the code (e.g., listing every field of a class).
- Write tutorials — this is reference documentation.
