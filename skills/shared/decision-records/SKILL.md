---
name: decision-records
scope: shared
used-by: [documenter]
description: Format and rules for Architecture Decision Records (docs/adr/) and the out-of-scope log (docs/out-of-scope/) the Documenter writes after approval. Use when a task made a non-obvious architectural choice or deliberately rejected work that should not be re-litigated.
---

# Decision Records

Two complementary records capture *why*, not just *what*:

- **ADR** — a decision that was **made**. Why this aggregate boundary, why this
  interface shape, why `Result<T>` here instead of an exception.
- **Out-of-scope** — work that was deliberately **rejected**, with the reasoning,
  so it isn't proposed again next task. The Planner's "requires human approval"
  suggestions that the human declined land here.

Both are written by the Documenter, after the Reviewer approves — never speculative.

## ADR — `docs/adr/NNNN-short-title.md`

Number sequentially (`0001`, `0002`, …). One decision per file. Keep it to a screen.

```markdown
# 0007 Reference other aggregates by ID only

## Status
Accepted

## Context
The Order aggregate needed to know the customer's tier. Holding a Customer
reference would cross an aggregate boundary and load the whole graph.

## Decision
Order holds a CustomerId. Tier is resolved by the application layer when needed.

## Consequences
- Aggregates stay small and independently loadable.
- A query that needs both must compose them — accepted cost.
```

## Out-of-scope — `docs/out-of-scope/short-title.md`

```markdown
# Multi-currency pricing

This task will not support multiple currencies.

## Why this is out of scope
The contract covers a single-currency domain. Adding currency now would force a
Money value object and FX rules with no current requirement driving them.

## Prior requests
- Planner suggested it under "requires human approval"; human declined for now.
```

## Rules

1. **Record the decision, not the journey.** No discarded attempts or debugging.
2. **One record per decision/rejection.** Don't bundle.
3. **Link, don't duplicate.** Reference the contract or glossary; don't restate them.
4. **Only non-obvious decisions get an ADR.** If the skills already mandate it,
   it's not a decision — it's the standard.

## Don't

- Write an ADR for something the DDD skills already require.
- Use out-of-scope as a TODO list — it records *rejected* work, not deferred work
  that's already planned.
