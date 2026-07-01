---
name: domain-events
description: An immutable, past-tense record that something meaningful happened in the domain, raised by an aggregate root to signal change without coupling to its consequences — use when an aggregate must announce a change, when decoupling side effects from core logic, or when achieving eventual consistency across aggregates.
---

# Domain Events

A domain event is an immutable fact stating that something meaningful happened in the domain, named in the past tense (OrderPlaced, PaymentReceived, ShipmentDispatched). It captures what occurred — never a command to do something.

## Why it matters
Events let one aggregate announce a change without knowing who cares, decoupling the model from its consequences. They drive side effects (notifications, read models, downstream workflows) and enable eventual consistency between aggregates that must not be updated in the same transaction. Without them, aggregates grow tangled dependencies and every new side effect forces edits to core logic.

## Core rules
1. **Name in the past tense** — the event records a completed fact (OrderPlaced), not an intention or instruction.
2. **Raise it inside the aggregate root** — the aggregate that enforces the invariant is the authority that decides the event happened.
3. **Make it immutable** — once created, an event never changes; it is a historical record.
4. **Carry what happened, not commands** — include the relevant facts (identifiers, values, when it occurred), not directives to other components.
5. **Publish after the change is committed** — handlers react to a fact that is already true, typically when the aggregate is saved.
6. **Keep invariant logic out of handlers** — if the rule protects an aggregate's consistency, it belongs inside that aggregate, not in a reaction to the event.
7. **Model one aggregate per transaction; use events for the rest** — react to an event to update other aggregates via eventual consistency.

## Example
Placing an order emits a fact and reactions handle the consequences:

```
Aggregate: Order
  action: place(customer, lines)
    -> enforce invariants (non-empty, within credit limit)
    -> record fact: OrderPlaced { orderId, customerId, total, occurredAt }

Fact OrderPlaced is published after the order is saved.
  Reaction A -> send confirmation to the customer
  Reaction B -> reserve stock in the Inventory aggregate (eventual consistency)
  Reaction C -> update the sales read model
```

Note the event says *OrderPlaced* (a fact), not *SendConfirmation* (a command). Each reaction is independent and can be added without touching the Order aggregate.

## Signs you're getting it wrong
- Event names read as commands or present tense (SendEmail, ReserveStock) instead of facts.
- Events raised from a service or the application layer rather than the aggregate root.
- Handlers enforce business rules that should protect an aggregate's invariants.
- Event payloads carry mutable references or instructions instead of a snapshot of what happened.
- Using an event as a synchronous in-process method call — if you just want to call a method, call it.
- Updating multiple aggregates in one transaction instead of letting an event drive the others.

## Related
[[aggregates]] are the unit of consistency and the only place events are raised — enforcing [[invariants]] stays inside the aggregate, never in handlers. Events are expressed in the [[ubiquitous-language]]. [[domain-services]] and [[repositories]] may publish them once the change is committed; downstream reactions often feed read models.
