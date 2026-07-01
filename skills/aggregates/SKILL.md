---
name: aggregates
description: An aggregate is a consistency boundary clustering entities and value objects under a single root that enforces all invariants; use when modeling a new aggregate, routing mutations through a root, deciding transaction boundaries, or reviewing cross-aggregate references.
---

# Aggregates

An aggregate is a **consistency boundary**: a cluster of entities and value objects treated as a single unit, with one entity designated the **root** that guards all invariants. External code addresses only the root.

## Why it matters
Without a clear boundary, invariants leak across many objects and no one owns them, so concurrent writes and half-applied changes corrupt state. Aggregates give you one place to enforce rules, one unit to load and save, and one thing to lock per transaction. Get them wrong and you either lock too much (contention) or too little (broken invariants).

## Core rules
1. **One root enforces all invariants.** The root is the only member outside code may hold a reference to.
2. **All mutation goes through the root.** External callers never modify child entities or collections directly; they call intention-revealing methods on the root.
3. **Encapsulate internal collections.** Expose read-only views; add and remove only via root methods that check invariants.
4. **Keep aggregates small.** Prefer a root plus a few closely-bound members. If it keeps growing, the boundary is probably wrong.
5. **Reference other aggregates by identity only.** Store their ID, never a direct object reference across the boundary.
6. **One aggregate per transaction.** Change and persist a single aggregate atomically; do not modify two in one transaction.
7. **Consistency across aggregates is eventual.** Coordinate other aggregates asynchronously via [[domain-events]], not inside the same transaction.
8. **Only the root raises domain events** describing what changed.

## Example
Consider an **Order** aggregate (root) that owns its **line items** (child entities).

- To add an item, a caller invokes an intention-revealing command on the root — *add line item*, given a product and quantity. The root checks its invariants (quantity positive, item count under the cap, running total within the credit limit) and only then appends the item to its internal collection. That collection is never handed out in a mutable form.
- The order references its customer by identity — it stores a customer ID, never a direct handle to the Customer aggregate. To reserve stock, the order records a domain event (*item added*); a separate Product aggregate reacts to it later, in its own transaction. The order never reaches into Product to decrement stock within the same transaction.

Invariant guarded here: *the sum of line-item totals must never exceed the credit limit* — it holds after every operation, because every change path runs through the root.

## Signs you're getting it wrong
- External code mutates a child entity or a collection returned from the root.
- A collection is exposed in a form callers can add to or remove from.
- An aggregate holds a direct object reference to another aggregate instead of its ID.
- One transaction updates two or more aggregates to "keep them in sync".
- A "god aggregate" owns half the domain and is loaded for nearly every use case.
- A child entity, not the root, raises domain events.

## Related
[[value-objects]] · [[domain-events]] · [[repositories]] · [[domain-services]]
