---
name: aggregates
scope: csharp
used-by: [executor, reviewer]
---

# Aggregates

An aggregate is a **consistency boundary** — a cluster of entities and value
objects with one root that enforces all invariants.

## Base types

| Type | Contract |
|---|---|
| `AggregateRoot` | Inherits `Entity`. Has `DomainEvents`, `AddDomainEvent()`, `ClearDomainEvents()` |
| `Entity` | `Id` (strongly-typed). Equality based on `Id`. Override `Equals`/`GetHashCode` |

## Rules

1. **One aggregate root per file** (plus its child entities in the same folder).
2. **All mutation goes through the root.** External code never modifies child
   entities directly.
3. **Encapsulate collections** — expose `IReadOnlyCollection<T>`, not `List<T>`.
4. **Small aggregates.** If it grows beyond ~5 entities, reconsider the boundary.
5. **Reference other aggregates by ID only** — never hold object references
   across aggregate boundaries.
6. **Only the root raises domain events.**

## Factory + Reconstitute

Two paths for object construction:

- **`Create()`** — new instances. Validates invariants, returns `Result<T>`,
  raises domain events.
- **`Reconstitute()`** — hydration from persistence. Skips validation (data was
  valid when stored). Internal access only.

## Structure

```csharp
public class Order : AggregateRoot
{
    private readonly List<LineItem> _lineItems = [];

    private Order() { }

    public static Result<Order> Create(CustomerId customerId, /* ... */)
    {
        // validate invariants
        var order = new Order(/* ... */);
        order.AddDomainEvent(new OrderPlacedEvent(order.Id, customerId, DateTime.UtcNow));
        return Result.Success(order);
    }

    internal static Order Reconstitute(OrderId id, CustomerId customerId, /* ... */)
    {
        // no validation, no events — hydration from persistence
        return new Order { Id = id, /* ... */ };
    }

    public Result AddLineItem(ProductId productId, int quantity)
    {
        if (quantity <= 0)
            return Result.Failure("Quantity must be positive");

        if (_lineItems.Count >= MaxLineItems)
            return Result.Failure("Maximum line items reached");

        _lineItems.Add(new LineItem(productId, quantity));
        return Result.Success();
    }

    public IReadOnlyCollection<LineItem> LineItems => _lineItems.AsReadOnly();
}
```

## Don't

- Expose `List<T>` — use `IReadOnlyCollection<T>`.
- Let child entities raise domain events — only the root raises them.
- Create "god aggregates" that own half the domain.
- Use public setters or `init` on domain properties.
