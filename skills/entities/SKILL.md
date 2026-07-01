---
name: entities
description: Models a domain object defined by a continuous thread of identity over time rather than its attributes; use when modeling something that must be tracked and distinguished across changes, deciding entity vs. value object, or assigning a stable identifier.
---

# Entities

An entity is a domain object defined by a thread of identity and continuity that persists over time, not by its attributes. Two entities are the same if and only if they share the same identity, even when every attribute differs.

## Why it matters
Some concepts must be tracked as the same thing across time and state changes: a customer, an order, an account. Without a distinct identity you cannot answer "is this the same one?" — you conflate different things or lose track of one as its data changes. Getting identity wrong corrupts history, auditing, and referential integrity throughout the model.

## Core rules
1. Give each entity a stable, unique identifier that never changes for its whole lifetime.
2. Define equality by identity alone — never by comparing attributes.
3. Let attributes change freely; identity and continuity must survive those changes.
4. Model the lifecycle explicitly (created, active states, archived/ended) — an entity has a story over time.
5. Assign identity at creation and keep it immutable; prefer identifiers the domain controls, not accidental storage keys.
6. Only make something an entity if the domain genuinely cares about tracking it individually; otherwise reach for a [[value-objects]] instead.
7. Reference other entities by their identity, not by holding a copy of their attributes.

## Example
Consider a person:

| Time  | Name     | Address    | Identity |
|-------|----------|------------|----------|
| birth | Jae Kim  | 4 Elm St   | #77123   |
| later | Jae Park | 9 Oak Ave  | #77123   |

Every attribute changed, yet it is the same person — identity #77123 is the thread of continuity. Contrast: a mailing address with the same street and city as another is interchangeable with it; no one tracks "which address" — that is a value object.

## Signs you're getting it wrong
- You compare two objects field-by-field to decide if they are "the same one."
- The identifier is derived from mutable attributes (e.g. name + birthdate), so it drifts.
- Everything in the model is an entity, including quantities, amounts, and descriptors.
- You reassign or regenerate an entity's identifier during its life.
- You duplicate another entity's attributes instead of referencing its identity.

## Related
- [[value-objects]] — the counterpart defined by attributes, not identity.
- [[aggregates]] — clusters of entities and value objects with one entity as root.
- [[invariants]] — rules an entity must keep true across its lifecycle.
- [[repositories]] — retrieve and persist entities by identity.
- [[factories]] — assign identity when creating complex entities.
- [[domain-events]] — record meaningful changes in an entity's life.
