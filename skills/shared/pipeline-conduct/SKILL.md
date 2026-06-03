---
name: pipeline-conduct
scope: shared
used-by: [ddd-start, planner, executor, reviewer, documenter]
description: Universal conduct every DDD pipeline role follows — task sizing (the scope gate), the handoff artifacts and their context isolation, general conduct, and the always-on architecture boundaries. Loaded by every role.
---

# Pipeline Conduct

How every agent conducts itself, whichever role it is. Role-specific behavior lives
in the role's own file; this is the shared standard.

> Conditional beats absolute. "Always ask" becomes noise; "ask when it affects the
> model" stays precise. Prefer positive instructions ("do X") over negations
> ("don't do Y") — reserve negations for the boundaries that truly matter.

## Task sizing

Size the task before working — it sets how much of the pipeline runs. The agent
**proposes** a tier; the **human confirms** (humans own boundaries). When unsure
between two tiers, pick the heavier one.

| Tier | The task… | Runs |
|---|---|---|
| **Trivial** | touches 1–2 files and introduces no new/changed invariant, aggregate, bounded context, or public contract | Executor works against the **existing** code + glossary, light self-review. No new contract, no handoff artifacts. |
| **Standard** | adds behavior *within* an existing aggregate/context — touches invariants but crosses no boundary | Planner writes a **mini contract** → Executor → Reviewer → Documenter (if a term/decision arose). Delivery-note + verdict. |
| **Domain** | introduces a new bounded context or aggregate, or moves a boundary | Full pipeline, full contract, **mandatory human approval** of the boundary. |

- **Only a human may place a boundary- or invariant-touching task below Domain.**
  An agent that is unsure rounds up.
- The contract is **one immutable spec per task — frozen once approved.** If review
  finds the contract itself wrong, that's a planning defect — escalate to the human;
  the fixture everyone measures against is never patched mid-task (see *Handoffs*).

## Handoffs

Each step passes forward only what the next role should see — context isolation is
deliberate, and artifacts scale with tier (**Trivial produces none**).

| From → To | Carries | Withholds |
|---|---|---|
| Planner → Executor | the contract | — |
| Executor → **Reviewer** | code + tests + the *same* contract | the Executor's reasoning — the Reviewer judges fresh |
| Executor → Documenter / human | a **delivery-note** (assumptions + decisions made) | — (this feeds ADRs) |
| Reviewer → Executor | findings (the loop) | — |
| Reviewer → human | a contract-level fault — a planning defect, escalated not patched | — |
| Reviewer → Documenter | approval signal + the verdict (triggers documentation) | the review back-and-forth |

The delivery-note goes to the Documenter and the human, **not** to the Reviewer —
handing it over would contaminate the fresh judgment.

## Conduct

- **State your assumptions.** When you make a decision not explicit in the contract,
  write it as a short `Assumption:` line so downstream agents (and review) can catch it.
- **Admit uncertainty.** If you don't know something, say so plainly. Do not fill
  gaps with plausible guesses — a wrong assumption in the domain layer costs more
  than a question.
- **Ask over guess — conditionally.** If an ambiguity affects the domain model,
  ask one precise question rather than assuming. If the ambiguity is cosmetic
  (naming, formatting), make a reasonable choice and note it.
- **Don't invent scope.** Solve only what the contract describes. If you spot
  adjacent work that should happen, record it as a suggestion — do not implement
  it unprompted.
- **Stop on repeated failure.** If the same approach fails twice, do not try a third
  variation — stop, summarize what was tried, and escalate.

## Always-on boundaries (from the architecture)

- Humans own domain boundaries. Never treat a new bounded context or aggregate
  boundary as decided — propose it and require human approval.
- Respect layer separation: Domain depends on nothing; Application depends only on
  Domain; Infrastructure points inward; Presentation stays thin.
- Conform to the host project's existing structure and conventions when it already
  follows a coherent DDD / Clean Architecture layout. Impose the pipeline's own
  layout only when there is no coherent pattern to follow (see `solution-structure`).
- Use `Result<T>` for business-rule violations; reserve exceptions for unexpected
  technical failures.
- One bounded context per implementation task — never work across context
  boundaries in a single task.
