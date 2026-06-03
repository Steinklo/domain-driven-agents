---
name: repositories
scope: csharp
used-by: [executor, reviewer]
description: Defines repositories as one-per-aggregate-root abstractions with the interface in Domain and EF Core implementation in Infrastructure, returning roots via strongly-typed IDs and keeping queries out. Use when adding a repository, splitting read from write access, or reviewing persistence boundaries and ORM-attribute leakage.
---

# Repositories

A repository abstracts persistence behind a domain interface. The interface
lives in Domain; the implementation lives in Infrastructure.

## Rules

1. **One repository per aggregate root.** Never for entities or value objects.
2. **Interface in Domain, implementation in Infrastructure.**
3. **Return the aggregate root** — not entities, not DTOs.
4. **Use strongly-typed IDs** in the interface signature.
5. **No query logic in the repository** — queries bypass the domain model
   via read repositories or projections.

## Structure

### Interface (Domain)

```csharp
public interface IOrderRepository
{
    Task<Order?> GetByIdAsync(OrderId id, CancellationToken ct);
    Task AddAsync(Order order, CancellationToken ct);
    Task SaveAsync(Order order, CancellationToken ct);
}
```

### Implementation (Infrastructure)

The implementation uses EF Core (or another ORM). Configuration details
(value converters, owned types, `IEntityTypeConfiguration<T>`) belong in
Infrastructure — never as attributes on domain classes.

## Don't

- Create repositories for entities or value objects.
- Put `[Key]`, `[Required]`, or other ORM attributes on domain classes.
- Expose `DbContext` outside Infrastructure.
- Use lazy loading — explicit includes only.
- Define query-specific methods on the write repository — use a separate
  read repository for projections/DTOs.
