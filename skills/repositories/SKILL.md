---
name: repositories
description: A repository is a collection-like abstraction that retrieves and persists whole aggregates while hiding the storage mechanism; use when adding a way to load or save an aggregate, defining a persistence boundary, or reviewing whether data access speaks the domain language.
---

# Repositories

A repository is a collection-like abstraction for retrieving and persisting aggregates, hiding the storage mechanism behind a domain-facing interface. It behaves as if all aggregates of a type live in an in-memory collection.

## Why it matters
Aggregates need to be reconstituted from and written back to storage without the domain model knowing about databases, ORMs, or files. A repository draws a clean line: the domain asks for aggregates by identity and hands them back, while the messy persistence details stay on the other side. Without it, storage concerns bleed into the model, invariants get bypassed by ad-hoc queries, and the ubiquitous language dissolves into table rows.

## Core rules
1. **One repository per aggregate root.** Never define repositories for internal entities or value objects — access those through their root.
2. **Deal in whole aggregates.** Retrieve and store the complete root with its contents, not fragments, rows, or data-transfer records. This is not a generic data-access object or table gateway.
3. **Interface belongs to the domain; implementation belongs to infrastructure.** The abstraction is expressed in domain terms; the storage technology is a hidden detail.
4. **Speak the ubiquitous language.** Method names reflect domain intent (find the order awaiting shipment), not query mechanics.
5. **Identify aggregates by identity.** The primary lookup is by the aggregate root's identity; encapsulate any richer selection behind specification objects or intention-revealing methods.
6. **Keep reporting queries out of the write model.** Complex read and reporting needs bypass the model via separate read paths or projections, not by bloating the aggregate repository.
7. **Delegate complex reconstitution.** Hydrate aggregates through their own reconstitution path (see [[aggregates]]) so the repository stays focused on retrieval and storage.

## Example
A shipping context needs to work with `Cargo` aggregates. The domain defines an abstraction, described in prose:

> **CargoRepository** — a collection of all cargoes.
> - *add(cargo)* — place a new cargo in the collection.
> - *find(trackingId)* — return the cargo with this tracking identity, or nothing.
> - *findRoutedTo(destination)* — return cargoes routed to a destination.

The domain depends only on this abstraction. In the infrastructure layer, a concrete implementation fulfills it — perhaps backed by a relational database, a document store, or an in-memory list for tests. Callers cannot tell which; they simply ask the collection for a `Cargo` and get a fully reconstituted aggregate back.

## Signs you're getting it wrong
- A repository per entity or value object instead of per aggregate root.
- Methods that return rows, columns, or data-transfer records rather than whole aggregates.
- Persistence details (connections, ORM types, query strings) leaking into domain interfaces or aggregate classes.
- A single generic repository parameterized over every type — that's a data-access object, not a domain repository.
- Callers loading partial aggregates and mutating them, silently bypassing the root's [[invariants]].
- Reporting and screen queries piled onto the aggregate's write repository.

## Related
[[aggregates]] · [[value-objects]] · [[domain-services]] · [[domain-events]]
