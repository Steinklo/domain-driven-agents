---
name: bounded-contexts
description: A bounded context is an explicit boundary — linguistic, model, and often team and deployment — within which one domain model and its ubiquitous language stay internally consistent so a term means exactly one thing; use when a word shifts meaning across the system, when teams model the same noun differently, or when deciding where to split a monolith or draw service boundaries.
---

# Bounded Contexts

A bounded context is an explicit boundary — linguistic, model, and often team and deployment — within which a single domain model and its ubiquitous language are internally consistent. Inside the boundary, every term means exactly one thing.

## Why it matters
Models don't scale to a whole enterprise; forcing one unified model produces a bloated, contradictory design where "Customer" or "Product" means five things at once. Bounded contexts make each model small, coherent, and independently evolvable. Without them, teams collide over a shared model, translations happen implicitly, and integration bugs multiply.

## Core rules
1. Name the context explicitly and state its purpose; every model element lives inside exactly one context.
2. Keep the ubiquitous language consistent within the boundary — one term, one meaning. Different meaning means different context.
3. Split when the language shifts meaning, when a different team owns the work, or when models start contradicting each other.
4. Do not share the domain model across contexts; integrate through explicit contracts, not shared internal representations (see [[context-mapping]]).
5. Prefer aligning a context with one team and one deployment unit; the boundary is organizational as much as technical.
6. Keep a subdomain (problem space) distinct from the context (solution space) — they often align one-to-one but need not.
7. Translate at the seams: the same real-world thing may be modeled differently in each context, and that is correct.

## Example

The word "Ticket" means different things depending on the boundary:

| Context | "Ticket" means | Owning team |
|---|---|---|
| Support | a customer complaint thread with status and priority | Support Eng |
| Ticketing/Sales | a purchasable seat for an event, with price and holder | Commerce |
| Rail Operations | a boarding entitlement validated at a gate | Ops |

Same word, three models. Each is internally consistent; forcing one shared "Ticket" would satisfy none. Where they must interact, a translation maps one context's concept to another's.

## Signs you're getting it wrong
- One "God" model or shared library of core entities reused by every service.
- The same term carries different meanings inside a single context (leaky boundary).
- You reconcile field-by-field differences at runtime instead of translating at a defined seam.
- Boundaries drawn purely by technical layers (data/api/ui) rather than by language and ownership.
- Two teams constantly renegotiating the shape of one shared model element.

## Related
- [[ubiquitous-language]] — the language a context makes consistent.
- [[subdomains]] — problem space vs. this solution-space boundary.
- [[context-mapping]] — how contexts relate and integrate.
- [[aggregates]] — consistency boundaries living inside a context.
- [[event-storming]] · [[domain-storytelling]] — workshops that surface where boundaries fall.
