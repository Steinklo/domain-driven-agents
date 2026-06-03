---
name: ubiquitous-language
scope: shared
used-by: [planner, executor, reviewer, documenter]
description: Maintains the per-bounded-context glossary that keeps code, tests, and docs on the same domain terms. Use when seeding terms, naming a domain type, or checking a name against the agreed vocabulary.
---

# Ubiquitous Language

Every bounded context maintains a **glossary** — a single source of truth for
domain terms. Code, tests, docs, and conversation use the same words.

## The glossary is a living artifact

`docs/glossary.md` (per bounded context) is built **early and used throughout** —
not written up at the end. Three roles touch it at three moments:

| When | Role | Action |
|---|---|---|
| During grilling | **Planner** | Seeds terms as the human names them — the glossary exists before the contract does |
| During review | **Reviewer** | Rejects any class/method/variable name that doesn't match an entry |
| After approval | **Documenter** | Adds terms introduced in implementation; keeps it current so the next task starts aligned |

A term enters the glossary the moment it's agreed, in the format below — so concise
naming pays off from the first line of code, not the last.

## Entry format

```
| Term | Definition | Bounded Context |
```

One row per term. Definition describes *what*, never *how* — no implementation detail.

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
