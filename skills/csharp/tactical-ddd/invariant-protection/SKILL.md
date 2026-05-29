---
name: invariant-protection
scope: csharp
used-by: [executor, reviewer]
---

# Invariant Protection

Cross-cutting C# mechanisms for protecting business rules. Used by both
aggregates and value objects. See `result-type` for the `Result<T>` contract.

## Rules

1. **Private setters** on all aggregate/entity properties.
2. **Factory methods for creation** — constructors are private/internal.
   Return `Result<T>` when creation can fail.
3. **Return `Result<T>`** from any operation that can violate a business rule.
4. **Never throw exceptions for expected business rule violations.**
   Exceptions = unexpected/technical failures only.
5. **Guard at the boundary** — the aggregate/value object method, not the caller.

## Don't

- Throw `ArgumentException` for business rule violations.
- Validate in the handler what the aggregate should enforce.
- Return `null` to signal failure.
- Rely on database constraints as the primary invariant enforcement.
