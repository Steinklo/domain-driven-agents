# Contract Template

The contract is the structured handoff between Planner and downstream agents.
Every field is mandatory — if a section doesn't apply, state "N/A" with a reason.

---

```markdown
## Bounded Context

- **Name:**
- **Purpose (one sentence):**

## Aggregates

| Aggregate | Root entity | Key invariants |
|---|---|---|

## Value Objects

| Name | Purpose | Constraints |
|---|---|---|

## Commands

| Command | Handler | Aggregate | Success result | Failure result |
|---|---|---|---|---|

## Queries

| Query | Handler | Read model / projection |
|---|---|---|

## Domain Events

| Event | Raised by | Handled by | Side effects |
|---|---|---|---|

## Cross-Cutting Concerns

- [ ] Logging
- [ ] Validation
- [ ] Transaction / Unit of Work
- [ ] Retry
- [ ] Other: ___

## Infrastructure Interfaces

| Interface (defined in) | Implementation (in Infrastructure) | Purpose |
|---|---|---|

## Presentation Entry Points

| Type (API / Function) | Route / Trigger | Command / Query |
|---|---|---|

## Invariants & Result Contract

List every business rule that must return `Result<T>` on violation:

1.
2.

## Acceptance Criteria (Gherkin)

```gherkin
Feature:

  Scenario:
    Given
    When
    Then
```

## Architecture Rules

- [ ] Domain references no other project
- [ ] Application depends on Domain only
- [ ] No cross-layer violations
- [ ] Command/Query purity (no query mutates)
```
