---
name: example-mapping
description: A structured, timeboxed conversation that decomposes a user story into rules, concrete examples, and open questions on four colored card types to expose hidden complexity before coding, used when refining a backlog story, discovering acceptance criteria, or deciding whether a story is ready to build.
---

# Example Mapping

A fast, collaborative technique for breaking a single story into four kinds of cards — rules, examples, questions, and the story itself — so ambiguity surfaces at the table instead of in production.

## Why it matters
Stories written as one-liners hide the real complexity; teams discover it mid-implementation, when change is expensive. Example Mapping forces business, dev, and test to reach shared understanding in minutes, converts vague rules into concrete, testable examples, and makes readiness visible. Without it, edge cases become bugs and acceptance criteria arrive as afterthoughts.

## Core rules
1. Use four card colors: **yellow** for the story, **blue** for rules (acceptance criteria), **green** for examples that illustrate a rule, **red** for questions/unknowns.
2. Every green example must sit under exactly one blue rule and be a concrete case with real values, not a restatement of the rule.
3. Every blue rule should be backed by at least one green example; a rule with none is untested or misunderstood.
4. When someone can't answer, park a red card and move on — never block the conversation guessing.
5. Timebox each story to ~25 minutes; if it overflows, the story is too big and should be split.
6. A pile of red cards means the story is NOT ready — resolve or split before it enters a sprint.
7. Phrase examples in the team's [[ubiquitous-language]]; they become the seeds of executable acceptance tests.

## Example
Story (yellow): "Customer redeems a loyalty coupon at checkout."

| Rule (blue) | Example (green) |
|---|---|
| Coupon must be unexpired | Coupon expiring tomorrow → accepted |
| | Coupon expired yesterday → rejected |
| One coupon per order | Second coupon on same order → rejected |
| Discount never exceeds order total | 10-unit coupon on 6-unit order → total becomes 0, not negative |

Questions (red): "Can a coupon stack with a seasonal sale?" · "What happens to a partially-used coupon on refund?"

The red cards block readiness; the green cards become acceptance criteria that later shape [[aggregates]] and their rules.

## Signs you're getting it wrong
- Examples merely paraphrase the rule instead of giving concrete values.
- One person dictates while others stay silent — the point is the three-role conversation.
- Rules multiply endlessly because the story should have been split.
- Red cards are answered on the spot with guesses rather than parked for a decision-maker.
- The map is filed away and never turned into acceptance tests or code.
- Discussion drifts into solution design instead of clarifying behavior.

## Related
[[ubiquitous-language]] · [[aggregates]]
