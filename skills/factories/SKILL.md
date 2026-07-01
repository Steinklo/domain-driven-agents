---
name: factories
description: A Factory encapsulates the complex creation of an aggregate, entity, or value object so the result is valid and fully formed from birth. Use when construction is nontrivial, must choose a concrete type, or must assemble a whole aggregate atomically.
---

# Factories

A Factory is a dedicated abstraction whose sole job is to build a complex domain object (or whole aggregate) in one atomic step, hiding the assembly and guaranteeing the result satisfies its invariants immediately.

## Why it matters
Complex construction leaks assembly logic and invariant checks into clients, letting objects exist in half-built, invalid states. Shifting creation into a Factory keeps the constructed object's own responsibilities cohesive, makes the creation itself an expressible domain concept, and ensures every instance is valid from the moment it is born.

## Core rules
1. Reach for a Factory only when construction is nontrivial — assembling a whole aggregate, choosing a concrete type polymorphically, or enforcing rules across multiple parts. A simple constructor is fine otherwise.
2. Make creation atomic: either produce a fully valid object or fail; never hand back a partially built one.
3. Enforce all invariants at creation. If the inputs cannot yield a valid object, refuse loudly rather than construct something broken.
4. Use a Factory Method on an existing entity or value object when it creates something within its own responsibility; use a standalone Factory when creation spans several types or belongs to no single object.
5. Place the Factory in the Ubiquitous Language and locate it where creation naturally begins — often on the aggregate root that owns the created part.
6. Separate creation from reconstitution. Creation makes a brand-new object (assign identity, check invariants, may raise creation domain events); reconstitution rebuilds an existing object from storage, reusing its stored identity and skipping invariant checks and events.
7. Take raw inputs or already-valid domain objects as arguments; return the built object by its abstract type, not a storage or infrastructure concern.

## Example
Placing an order requires bundling a customer, line items, and a shipping address, then confirming totals and stock before the order may exist.

- A standalone `OrderFactory` takes the customer, chosen items, and address; it validates that at least one item exists and totals are positive, assigns a new order id, marks status "placed", and returns a valid Order — or refuses.
- A Factory Method on the Customer entity, an operation such as "place order", keeps creation there because a placed order arises from that customer's action.
- Reconstitution: a repository loading yesterday's order calls a rebuild path that restores the stored id and status and does NOT re-run "at least one item" checks or re-raise an "OrderPlaced" event — the order already happened.

| Aspect | Creation | Reconstitution |
|---|---|---|
| Identity | newly assigned | taken from storage |
| Invariants | enforced | assumed already valid |
| Domain events | may raise | never raise |

## Signs you're getting it wrong
- Clients call a constructor then set fields one by one to finish the object.
- Objects can exist in an invalid state and are "validated later".
- The reconstitution path fires domain events or re-runs creation-time checks against stored data.
- The Factory reaches into a database or framework instead of just assembling domain objects.
- A trivial one-argument constructor is wrapped in a Factory for no reason.
- Creation logic for one aggregate is scattered across several unrelated classes.

## Related
[[aggregates]], [[value-objects]], [[repositories]], [[domain-events]], [[domain-services]], [[ubiquitous-language]]
