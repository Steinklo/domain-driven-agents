---
name: event-storming
description: A collaborative sticky-note workshop that maps a domain as a left-to-right timeline of past-tense events to surface boundaries, flows, and shared language; use when kicking off a new domain, untangling a tangled legacy process, or aligning developers and domain experts before modeling.
---

# Event Storming

A fast, low-tech group workshop where a domain is explored by placing colored sticky notes on a long wall, ordering domain events on a timeline and enriching them until structure emerges.

## Why it matters
Modeling in isolation produces guesses dressed as designs. Event Storming puts domain experts and developers at the same wall, exposing the real process, its gaps, and its language in hours instead of weeks. Without it, hidden boundaries and edge cases surface late, as bugs and rework.

## Core rules
1. Start with orange domain events in past tense ("Order Placed", "Payment Captured") and order them left-to-right on a timeline.
2. Add color roles deliberately: blue commands (intent/actions), yellow actors (who triggers), purple/lilac policies (reactive "whenever X then Y" rules), green read models (what a decision looks at).
3. Follow the flow: an actor issues a command, which produces an event, which may trigger a policy, which issues the next command.
4. Mark hotspots (conflict, confusion, unknowns) with a distinct color and keep moving — do not stall the group.
5. Run the right level: big-picture (broad exploration), process (flows and policies), design (aggregates and detail).
6. Cluster related events and commands into candidate aggregates (large yellow); watch where language or ownership changes — those seams are boundaries.
7. Capture the words people actually say; the wall is the source of the ubiquitous language.

## Example
A big-picture wall for online checkout, read left to right:

| Actor | Command | Event (orange) | Policy |
|-------|---------|----------------|--------|
| Customer | Place Order | Order Placed | Whenever Order Placed, request payment |
| Payment gateway | Capture Payment | Payment Captured | Whenever Payment Captured, start fulfillment |
| Warehouse | Ship Order | Order Shipped | — |

A hotspot sits on "Payment Captured": experts disagree on what happens when capture partially fails. That disagreement is a boundary and a rule to model, not a detail to skip.

## Signs you're getting it wrong
- Events written in present or future tense, or phrased as commands.
- One person drives while experts watch; the wall reflects assumptions, not knowledge.
- Jumping to aggregates and database tables before the event flow is agreed.
- Hotspots and open questions get smoothed over instead of made visible.
- Sticky colors used inconsistently, so roles blur and the timeline stops meaning anything.

## Related
[[domain-events]] · [[bounded-contexts]] · [[ubiquitous-language]] · [[domain-storytelling]] · [[example-mapping]]
