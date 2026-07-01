---
name: context-mapping
description: Documents the relationships and integration patterns between bounded contexts and their upstream/downstream power dynamics; use when integrating multiple teams or systems, choosing how two contexts should depend on each other, or diagnosing why cross-context integration keeps breaking.
---

# Context Mapping

A context map is a living diagram of the bounded contexts in a system and the relationships between them, naming the integration pattern and the direction of influence for each connection.

## Why it matters
Bounded contexts never live in isolation; they must exchange data and behavior. Without an explicit map, teams make silent, incompatible assumptions about who owns what and who adapts to whom. The map surfaces organizational power dynamics, translation costs, and coupling risks before they harden into a Big Ball of Mud.

## Core rules
1. Label every relationship with its direction: **upstream** (U) influences, **downstream** (D) is affected. Upstream's choices flow downhill whether or not downstream consents.
2. Pick one named pattern per edge: **Partnership** (mutual success or failure), **Shared Kernel** (a small shared model both own), **Customer-Supplier** (downstream needs are prioritized upstream), **Conformist** (downstream adopts upstream's model wholesale), **Anticorruption Layer** (downstream translates to protect its model), **Open Host Service** + **Published Language** (upstream offers a stable, documented protocol), **Separate Ways** (deliberately no integration).
3. Use an **Anticorruption Layer** whenever an upstream model would corrupt yours and you cannot negotiate change.
4. Publish an **Open Host Service** with a **Published Language** when many downstreams consume you; do not bespoke-integrate each one.
5. Treat **Conformist** and **Big Ball of Mud** as warnings, not designs — enter them knowingly, mark them, and plan an exit.
6. Map relationships between teams, not just code; the pattern often reflects who can say no to whom.
7. Keep the map current — revisit it as teams, ownership, and integrations shift.

## Example
A retail platform, three contexts:

| Upstream (U) | Downstream (D) | Pattern | Why |
|---|---|---|---|
| Payments | Orders | Open Host Service + Published Language | Many consumers; stable documented protocol |
| Legacy Pricing | Catalog | Anticorruption Layer | Legacy model is messy; Catalog translates at the boundary |
| Orders | Shipping | Customer-Supplier | Shipping's needs shape Orders' outputs; both plan together |

Reading the first row: Orders consumes Payments through its Published Language over a stable, versioned interface rather than ad hoc calls. Payments owns the protocol and every downstream uses the same one — this is Open Host Service, not Conformist, because the boundary is an explicit published contract.

## Signs you're getting it wrong
- Contexts integrate but no one can state who is upstream and who is downstream.
- A downstream context absorbs an upstream's model unchanged and its own [[ubiquitous-language]] rots (unintentional Conformist).
- Every consumer integrates differently instead of through one Open Host Service.
- Shared Kernel keeps growing until both teams are coupled on everything.
- The map was drawn once and never updated; reality has drifted.
- Everything is "Partnership" — a sign real power dynamics are being avoided.

## Related
[[bounded-contexts]], [[ubiquitous-language]], [[subdomains]], [[domain-events]], [[event-storming]]
