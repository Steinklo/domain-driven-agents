---
name: spec-before-code
scope: shared
used-by: [planner]
---

# Spec Before Code

Write **Gherkin acceptance criteria** before any implementation begins.
The spec is the contract — code is the fulfillment.

## Rules

1. **Every task gets at least one `Feature` with scenarios** before coding starts.
2. **Scenarios test behavior, not implementation.** Use domain language, not
   technical details (`"the order is placed"`, not `"a row is inserted"`).
3. **Cover the happy path AND key failure paths** — especially business rule
   violations that return `Result<T>`.
4. **One scenario per invariant.** If an aggregate protects three invariants,
   write at least three scenarios.
5. **Gherkin lives in the contract**, not in a separate file at this stage.

## Format

```gherkin
Feature: <domain capability>

  Scenario: <happy path>
    Given <precondition in domain language>
    When <action>
    Then <expected outcome>

  Scenario: <business rule violation>
    Given <precondition>
    When <action that violates invariant>
    Then <Result failure with specific error>
```

## Don't

- Write scenarios after the code (confirmation bias).
- Use technical language (`"the database returns..."`, `"the API responds..."`).
- Skip failure scenarios — they are where `Result<T>` earns its keep.
