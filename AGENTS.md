# AGENTS.md — Universal Agent Behavior

These rules apply to **every** agent in the Domain-Driven Agents pipeline
(Planner, Executor, Reviewer, Documenter). Role-specific behavior lives in
`agents/`. Domain knowledge lives in `skills/`. Task-specific truth lives in
the planner's **contract** — produced per task in the target project, never stored
in this repo. This file boots each role; the universal conduct lives in the
**`pipeline-conduct`** skill.

> Conditional beats absolute. "Always ask" becomes noise; "ask when it affects the
> model" stays precise. Prefer positive instructions ("do X") over negations
> ("don't do Y") — reserve negations for the boundaries that truly matter.

## Startup

1. Read this file fully.
2. Ask the user which **agent role** to assume — default to **Planner** for a new
   story or task (Executor for a Trivial change against an existing contract).
3. Read your agent file in `agents/<role>.md`.
4. Read the **`pipeline-conduct`** skill — the universal conduct, task sizing, and
   handoffs every role follows.
5. Read every skill your agent file lists. Skill names map to paths:

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
   | `grill-before-contract` | `skills/shared/grill-before-contract/SKILL.md` |
   | `spec-before-code` | `skills/shared/spec-before-code/SKILL.md` |
   | `decision-records` | `skills/shared/decision-records/SKILL.md` |
   | `doc-standards` | `skills/shared/doc-standards/SKILL.md` |
   | `pipeline-conduct` | `skills/shared/pipeline-conduct/SKILL.md` |
   | `contract-template` | `skills/shared/contract-template/SKILL.md` |
   | `ddd-start` | `skills/shared/ddd-start/SKILL.md` |

6. If Planner: read the **`contract-template`** skill.
7. Ask the user what to build — a user story or task — and which project to work in.
8. **Size the task** (see `pipeline-conduct`) and confirm the tier with the human —
   it decides which agents run and how heavy the contract is.

Do not start working until all of the above is done.

## Conduct, sizing & boundaries

The universal standard every role follows — task sizing (the scope gate), the
handoff artifacts and their context isolation, general conduct, and the always-on
architecture boundaries — lives in the **`pipeline-conduct`** skill
(`skills/shared/pipeline-conduct/SKILL.md`), so the same rules travel with the plugin.
The Startup sequence loads it for every role.
