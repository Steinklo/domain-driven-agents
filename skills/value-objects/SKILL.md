---
name: value-objects
description: Models a domain concept defined entirely by its attributes with no identity, immutable and compared by value. Use when modeling a descriptive concept like money or a date range, replacing a bare primitive with meaning, or reviewing equality, immutability, and validation.
---

# Value Objects

A value object is a domain concept defined **entirely by its attributes**, with no identity of its own. Two value objects holding the same attribute values are interchangeable and considered equal.

## Why it matters
Most of a model is descriptive, not identified: an amount of money, a date range, a color, an address. Modeling these as value objects packages related attributes into a single meaningful whole, attaches invariants and behavior to them, and removes the identity-tracking overhead that entities carry. Skip them and the domain drowns in loose, unnamed primitives (a raw number here, a raw text field there) with rules smeared across the codebase.

## Core rules
1. **No identity.** Equality is by attribute value, not by a reference or id. If two instances need to be told apart despite equal attributes, you want an entity (modeled inside an [[aggregates]]), not a value object.
2. **Immutable.** Never mutate an existing instance; to "change" it, construct a new one. This makes value objects safe to share and pass freely.
3. **Self-validating at construction.** An instance can only come into existence in a valid state; reject invalid input before an object exists. See [[invariants]].
4. **Whole-value replacement.** Assign a fresh value object in place of the old one rather than reaching in to edit an attribute.
5. **Side-effect-free behavior.** Methods answer questions or return new value objects; they never alter the receiver or the outside world.
6. **Prefer value objects.** When a concept has no meaningful identity, model it as a value object first. Wrap primitives that carry domain rules into named value objects.

## Example
A `Money` value object holds `amount` and `currency`. It is created only through a construction step that rejects a negative amount or a missing currency, so an invalid `Money` cannot exist.

- Equality: `Money(10, "USD")` equals another `Money(10, "USD")` — they are the same value.
- Immutability: adding two `Money` values returns a **new** `Money`; the originals are untouched. Adding across currencies is refused.
- Whole replacement: an order's total is not edited in place; a new `Money` is computed and assigned.

Contrast with `Product`, which has an identity (a product number): two products with identical names are still different products — that is an entity, not a value object.

## Signs you're getting it wrong
- Passing bare primitives (raw text, a number, a raw id) where a named concept with rules belongs.
- Setters or mutation methods that change an existing instance's attributes.
- Comparing value objects by reference/identity instead of by their attributes.
- Constructors that permit invalid states, deferring validation to later checks.
- Behavior on the value object that reaches out and causes side effects.
- Bolting a database-generated id onto something that has no true identity.

## Related
[[aggregates]] · [[ubiquitous-language]] · [[domain-events]]
