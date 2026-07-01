---
name: domain-services
description: A domain service is stateless domain logic that models an operation spanning several domain objects and belonging to no single entity; use when logic spans two or more aggregates, when deciding between a domain service and an application service, or when naming a cross-object operation in the ubiquitous language.
---

# Domain Services

A domain service captures **stateless domain logic** that expresses an operation over multiple domain objects and does not naturally belong to any single entity or value object.

## Why it matters
Some domain operations are genuine concepts in their own right but have no obvious home on one object — forcing them onto an entity distorts that entity, and pushing them into the application layer scatters domain rules where they can't be found or reused. A domain service gives such an operation a named, first-class place inside the domain layer, keeping the model expressive and the ubiquitous language intact.

## Core rules
1. **Live in the domain layer.** A domain service holds domain rules, not orchestration or infrastructure.
2. **Stay stateless.** It has no identity and no mutable state; all data comes in through its parameters.
3. **Name it after a domain activity** in the ubiquitous language — usually a verb-like concept (transfer, allocation, pricing), not a technical noun.
4. **Take domain objects as inputs and return domain objects or results** — operate on entities and value objects, never on persistence, messaging, or external systems.
5. **Reach for it only when the operation truly spans objects.** If the logic fits naturally on one entity or value object, put it there instead.
6. **Keep it a thin expression of a rule**, not a home for every stray operation; a service that just shuffles data between anemic objects is a smell.

## Example
Transferring money between two accounts is not owned by either account — debiting one and crediting the other, checking they share a currency, is one indivisible domain rule over two aggregates.

```
service MoneyTransfer:
  transfer(source, destination, amount):
    require source.currency == destination.currency
    require source.canWithdraw(amount)
    source.withdraw(amount)
    destination.deposit(amount)
    return TransferReceipt(...)
```

The service coordinates the rule; the accounts still enforce their own invariants.

## Signs you're getting it wrong
- It holds fields or remembers things between calls — that's an entity or a session, not a domain service.
- It loads or saves data, sends messages, or calls external systems — that's an application service or infrastructure.
- Its name is a technical label (Manager, Helper, Processor, Util) rather than a concept from the domain.
- It became a dumping ground for logic that really belongs on an entity, leaving those entities anemic.
- You created one for an operation that touches only a single object.

## Related
[[entities]] · [[value-objects]] · [[aggregates]] · [[invariants]] · [[ubiquitous-language]] · [[domain-events]] · [[repositories]] · [[factories]] · [[specifications]]
