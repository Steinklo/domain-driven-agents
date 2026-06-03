# Contract Template

The contract is the structured handoff between Planner and downstream agents — **one
immutable spec per task, never one per step.** Everyone measures against the same
fixture; that shared yardstick is what lets the Reviewer catch the Executor's drift.

- **One template, sized by tier** (see *Task sizing* in `AGENTS.md`). Fill the
  **[core]** sections for a **Standard** task (a *mini* contract); add the **[full]**
  sections for a **Domain** task (the *full* contract). A **Trivial** task writes no
  contract — it runs against the existing code + glossary.
- **Fill only what the task reaches.** Every `[core]` section is required. A `[full]`
  section the task never touches (e.g. a layer it doesn't enter) is omitted — not
  padded with "N/A".
- **The contract is frozen once approved — never edited mid-task.** If review finds
  the *contract* wrong (a missing invariant, a bad boundary), that's a planning
  defect: escalate to the human, don't patch the fixture everyone measures against.

~~~markdown
# Contract: <task name>

## Bounded Context                                              [core]
- **Name:**
- **Aggregate(s) touched:**
- **Purpose (one sentence):**

## Touchpoints                                                  [core]
- **Commands / Queries:**
- **Domain events raised / handled:**

## Invariants & Result Contract                                 [core]
Every business rule that must return `Result<T>` on violation:
1.
2.

## Acceptance Criteria (Gherkin)                                [core]
```gherkin
Feature:

  Scenario:
    Given
    When
    Then
```

## Architecture Rules                                          [core]
- [ ] No cross-layer violations
- [ ] Command/Query purity (no query mutates)
- [ ] Names match the glossary

## Aggregates                                                   [full]
| Aggregate | Root entity | Key invariants |
|---|---|---|

## Value Objects                                               [full]
| Name | Purpose | Constraints |
|---|---|---|

## Commands & Queries                                          [full]
| Command / Query | Handler | Aggregate | Success result | Failure result |
|---|---|---|---|---|

## Domain Events                                               [full]
| Event | Raised by | Handled by | Side effects |
|---|---|---|---|

## Touched layers — fill only those this task enters           [full]
- **Cross-cutting:** which of logging / validation / transaction / retry apply
- **Infrastructure interface(s):** interface (in Domain/Application) → impl (in Infrastructure)
- **Presentation entry point(s):** API route / function trigger → command/query
- **Domain-layer arch rules:** Domain references no other project; Application depends on Domain only
~~~
