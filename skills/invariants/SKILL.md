---
name: invariants
description: An invariant is a business rule that must always hold true for the model to be valid, enforced at the aggregate boundary and at construction; use when a rule "must always" hold, when deciding where validation lives, or when stopping an object from existing in an invalid state.
---

# Invariants

An invariant is a consistency rule that must hold true at all times for the model to be valid — for example, "an order's line totals must equal its header total." The model is responsible for keeping itself correct, so an object should never be observable in a state that breaks its invariants.

## Why it matters
If invalid states are representable, every consumer must re-check the rules, and eventually one forgets. Centralizing invariant enforcement inside the model means a rule is stated and guarded in exactly one place. Without this, corrupt data spreads silently and bugs surface far from their cause.

## Core rules
1. **Enforce at the aggregate boundary.** The aggregate root guards its own invariants; no external caller may leave it inconsistent.
2. **Enforce at construction.** Creation must produce a valid object or fail — never a half-built, invalid instance.
3. **Make invalid states unrepresentable.** Prefer designs where a broken state simply cannot be expressed over designs that detect it after the fact.
4. **Fail fast on violation.** Reject the offending operation immediately with a clear, domain-meaningful outcome; do not defer the check downstream.
5. **Distinguish invariants from process rules.** Invariants are *always* true within one transactional boundary. Rules that hold *eventually*, or span multiple aggregates, are process/policy concerns — coordinate them with domain events or services, not synchronous guards.
6. **Keep the guard in the model, not the caller.** Application handlers and UI must not re-implement rules the aggregate owns; the database is a backstop, never the primary enforcer.
7. **Signal expected rule violations as domain outcomes** — distinct from unexpected technical failures.

## Example
Rule: *a bank account balance must never go below its overdraft limit.*

| Where the rule lives | Result |
| --- | --- |
| Inside the Account aggregate's `withdraw` behavior | A withdrawal that breaches the limit is rejected; the balance is never invalid. |
| In the calling service, checked before calling | Any new caller that forgets the check corrupts the account. |

Pseudocode (neutral):

```
Account.withdraw(amount):
    if balance - amount < overdraftLimit:
        return Rejected("would exceed overdraft limit")   // fail fast, still valid
    balance = balance - amount
```

Contrast with a *process rule*: "flag accounts inactive for 12 months." That is not always-true within one transaction — it is a policy evaluated over time, handled by a domain service or event, not an aggregate guard.

## Signs you're getting it wrong
- Objects can be created via a plain builder/setter sequence and later "validated."
- The same rule is checked in the handler, the UI, and the model.
- Failure is signaled by returning nothing/empty or by raising a technical error for an expected business case.
- Cross-aggregate consistency is enforced synchronously inside one aggregate.
- You rely on a database constraint to catch what the model should have prevented.

## Related
[[aggregates]] · [[value-objects]] · [[domain-events]] · [[domain-services]] · [[ubiquitous-language]]
