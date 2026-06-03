---
name: domain-services
scope: csharp
used-by: [executor, reviewer]
description: Defines stateless domain services in the Domain project for logic spanning multiple aggregates, taking aggregates/value objects as parameters and returning Result<T> without repositories. Use when logic spans two or more aggregates, deciding between a domain service and an Application handler, or reviewing for infrastructure leakage.
---

# Domain Services

A domain service encapsulates **stateless domain logic** that doesn't naturally
belong to a single aggregate.

## When to use

- Logic spans **two or more aggregates** in the same bounded context.
- The operation is a **domain concept** (not infrastructure, not orchestration).
- It has no state of its own.

## Rules

1. **Lives in the Domain project.**
2. **Stateless** — no fields, no side effects beyond returning a result.
3. **Named after the domain concept** it represents (`PricingService`,
   `InventoryAllocationService`).
4. **Takes aggregates or value objects as parameters** — never repositories
   or infrastructure services.
5. **Returns `Result<T>`** when the operation can fail on business rules.

## Structure

```csharp
public class PricingService
{
    public Result<Money> CalculateDiscount(Order order, CustomerTier tier)
    {
        // domain logic across order + customer tier
    }
}
```

## Don't

- Put orchestration here — that's an Application handler.
- Inject repositories — that's Infrastructure leaking into Domain.
- Create a domain service for logic that fits in one aggregate.
