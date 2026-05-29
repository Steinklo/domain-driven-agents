---
name: ubiquitous-language
scope: shared
used-by: [planner, reviewer]
---

# Ubiquitous Language

Every bounded context maintains a **glossary** — a single source of truth for
domain terms. Code, tests, docs, and conversation use the same words.

## Rules

1. **One term, one meaning.** No synonyms within a bounded context.
2. **Domain experts name things.** If the business calls it "Policy", the code
   calls it `Policy` — not `Rule`, `Contract`, or `Plan`.
3. **Glossary lives in the repo** (`docs/glossary.md` per bounded context).
4. **Class/method/variable names match glossary entries** — adjusted only for
   the language's casing conventions.
5. **Rename in code when the glossary changes.** Stale names are bugs.

## Don't

- Invent abbreviations (`Ord` instead of `Order`).
- Use technical jargon as domain names (`Entity`, `Record`, `DataObject`).
- Let two bounded contexts share the same term with different meanings without
  an explicit context map.
