---
name: specifications
description: Models a business rule as a first-class predicate object that answers whether a candidate satisfies it, reusable for validation, selection, and construction; use when validating a candidate against a rule, selecting or querying objects from a collection by a rule, building an object to satisfy a rule, or when the same conditional logic keeps reappearing across the codebase.
---

# Specifications

A Specification encapsulates a business rule or predicate as a standalone object that judges whether a candidate object satisfies it. It turns a scattered boolean test into a named, reusable, combinable concept.

## Why it matters
Business rules like "is this customer delinquent?" tend to leak into if-statements across services, UI, and repositories, drifting out of sync. A Specification gives the rule one authoritative home, names it in the domain vocabulary, and lets the same rule serve validation, querying, and construction. Without it, rules duplicate, contradict, and become invisible to domain experts.

## Core rules
1. Model the rule as an object with a single question: `isSatisfiedBy(candidate) -> yes/no`.
2. Name it in the ubiquitous language ("OverdueInvoiceSpecification"), not by mechanism.
3. Keep specifications side-effect free and stateless — they judge, they never mutate.
4. Compose complex rules from simple ones with `and`, `or`, `not` rather than one giant predicate.
5. Reuse the same specification for three jobs: validation (is this valid?), selection (which of these match?), and construction to spec (make one that matches).
6. Put the specification where the rule belongs — usually the domain layer near the aggregate it concerns.
7. For querying, let a specification translate into a repository query rather than loading everything and filtering in memory.
8. Keep the rule's meaning explicit; if a rule needs parameters (e.g. a threshold), pass them when creating the specification.

## Example
Rule: an invoice is a collection candidate when it is overdue AND unpaid AND not disputed.

```
OverdueSpec:      isSatisfiedBy(invoice) = invoice.dueDate < today
UnpaidSpec:       isSatisfiedBy(invoice) = invoice.balance > 0
DisputedSpec:     isSatisfiedBy(invoice) = invoice.hasOpenDispute

CollectionCandidate = OverdueSpec AND UnpaidSpec AND (NOT DisputedSpec)
```

Same object, three uses:
- Validation: `CollectionCandidate.isSatisfiedBy(thisInvoice)` before dunning.
- Selection: ask the repository for all invoices matching `CollectionCandidate`.
- Construction: build a test invoice that satisfies `CollectionCandidate`.

## Signs you're getting it wrong
- The rule reappears as a copy-pasted `if` in three places.
- The specification mutates the candidate or calls out to send emails / save data.
- One monolithic predicate with nested booleans instead of composed small specs.
- The name describes code ("InvoiceChecker") rather than a domain concept experts recognize.
- Selection loads the whole collection into memory just to filter it.

## Related
- [[ubiquitous-language]] — the specification's name must come from here.
- [[aggregates]] — the candidates a specification typically judges, along with their value objects, and where construction-to-spec belongs.
- [[value-objects]] — a specification is itself a value object.
- [[repositories]] — accept specifications to drive queries.
- [[domain-services]] — where a specification spanning several aggregates may live.
