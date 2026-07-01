---
name: subdomains
description: Subdomains partition the problem space into Core, Supporting, and Generic to steer where modeling effort and investment go; use when deciding what to build vs. buy, prioritizing modeling depth, or separating strategic differentiators from commodity functionality.
---

# Subdomains

A subdomain is a distinct area of the overall problem space (the business domain). Classifying each subdomain as Core, Supporting, or Generic tells you where to concentrate scarce design and engineering effort.

## Why it matters
Teams have finite modeling energy. Spending it evenly means the parts that actually win business get the same shallow treatment as commodity plumbing. Naming subdomains and their type makes investment decisions explicit: build the differentiator with care, keep the rest cheap. Without this lens, effort scatters and the truly strategic model stays underdeveloped.

## Core rules
1. Identify subdomains in the **problem space** — they describe the business, independent of any software or team structure.
2. Classify each as **Core** (your competitive differentiator — invest heavily, model deeply, keep in-house), **Supporting** (necessary and somewhat custom, but not special — build adequately or outsource), or **Generic** (a solved commodity — buy, adopt off-the-shelf, or use an existing standard).
3. Focus your best people and richest [[ubiquitous-language]] on the Core; deliberately spend less on the rest.
4. Keep the problem-space subdomain distinct from the solution-space [[bounded-contexts]]. Subdomains are discovered; contexts are designed.
5. Aim for one bounded context per subdomain, but do not assume it: a legacy context may span several subdomains, or one subdomain may be served by several contexts.
6. Re-evaluate classification over time — a Generic subdomain can become Core when strategy shifts, and yesterday's Core can commoditize.
7. Do not build custom software for a Generic subdomain when a proven product exists.

## Example
An online bookstore, partitioned by problem area:

| Subdomain | Type | Investment stance |
|---|---|---|
| Personalized recommendations | Core | Best modelers, deep custom model, rich language |
| Order fulfillment & packing rules | Supporting | Custom but modest; adequate is fine |
| Identity / login | Generic | Adopt an existing identity provider |
| Payments | Generic | Integrate a payment gateway; do not build |
| Tax calculation | Generic | Buy a tax-rules service |

The differentiator (recommendations) earns the deep model; login and payments are bought, not crafted.

## Signs you're getting it wrong
- Every subdomain is treated as equally important — no explicit Core.
- Hand-building a Generic subdomain (custom auth, custom payment engine) instead of adopting a solution.
- Labeling something Core because it is technically interesting, not because it differentiates the business.
- Confusing a subdomain (problem) with a bounded context, module, or microservice (solution).
- Classifications set once and never revisited as the market changes.

## Related
- [[bounded-contexts]] — the solution-space partition that realizes a subdomain
- [[context-mapping]] — relating the contexts across subdomains
- [[ubiquitous-language]] — invest the richest language in the Core
- [[event-storming]] — a workshop technique for discovering subdomains and their boundaries
