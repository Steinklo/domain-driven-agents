# AGENTS.md — Universal Agent Behavior

These rules apply to **every** agent in the Domain-Driven Agents pipeline
(Planner, Executor, Reviewer, Documenter). Role-specific behavior lives in
`agents/`. Domain knowledge lives in `skills/`. Task-specific truth lives in
the planner's **contract**. This file is *only* about how an agent conducts itself.

> Conditional beats absolute. "Always ask" becomes noise; "ask when it affects the
> model" stays precise. Prefer positive instructions ("do X") over negations
> ("don't do Y") — reserve negations for the boundaries that truly matter.

## Startup

1. Read this file fully.
2. Ask the user which **agent role** to assume (Planner, Executor, Reviewer, Documenter).
3. Read your agent file in `agents/<role>/AGENT.md`.
4. Read every skill your agent file lists. Skill names map to paths:

   | Skill | Path |
   |---|---|
   | `aggregates` | `skills/csharp/tactical-ddd/aggregates/SKILL.md` |
   | `value-objects` | `skills/csharp/tactical-ddd/value-objects/SKILL.md` |
   | `invariant-protection` | `skills/csharp/tactical-ddd/invariant-protection/SKILL.md` |
   | `domain-events` | `skills/csharp/tactical-ddd/domain-events/SKILL.md` |
   | `domain-services` | `skills/csharp/tactical-ddd/domain-services/SKILL.md` |
   | `repositories` | `skills/csharp/tactical-ddd/repositories/SKILL.md` |
   | `result-type` | `skills/csharp/common/result-type/SKILL.md` |
   | `cqrs` | `skills/csharp/common/cqrs/SKILL.md` |
   | `solution-structure` | `skills/csharp/common/solution-structure/SKILL.md` |
   | `arch-testing-dotnet` | `skills/csharp/common/arch-testing-dotnet/SKILL.md` |
   | `ubiquitous-language` | `skills/shared/ubiquitous-language/SKILL.md` |
   | `spec-before-code` | `skills/shared/spec-before-code/SKILL.md` |
   | `doc-standards` | `skills/shared/doc-standards/SKILL.md` |

5. If Planner: read `contract-template.md`.
6. Ask the user what to build and which project to work in.

Do not start working until all of the above is done.

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
- Use `Result<T>` for business-rule violations; reserve exceptions for unexpected
  technical failures.
- One bounded context per implementation task — never work across context
  boundaries in a single task.
