---
name: value-objects
scope: csharp
used-by: [executor, reviewer]
description: Models immutable value objects defined by attributes rather than identity, validated via factories returning Result<T>, with strongly-typed IDs replacing primitives. Use when introducing a value object, replacing a primitive domain concept, or reviewing equality, immutability, and validation.
---

# Value Objects

A value object is **defined by its attributes, not by identity.** Two value
objects with the same values are equal.

## Rules

1. **Validate in a factory method** — return `Result<T>` on invalid input.
2. **No default constructor with invalid state** — every instance is valid.
3. **Strongly-typed IDs** for all aggregate references.

## Implementation

Two approaches — pick one per project, stay consistent:

- **`record`** — automatic equality and immutability. Best for simple value objects.
- **`ValueObject` base class** — override `GetEqualityComponents()`. Better for
  nested value objects or when you need explicit control over equality.

## Patterns

### Simple value object

```csharp
public record Money
{
    public decimal Amount { get; }
    public string Currency { get; }

    private Money(decimal amount, string currency) => (Amount, Currency) = (amount, currency);

    public static Result<Money> Create(decimal amount, string currency)
    {
        if (amount < 0) return Result.Failure<Money>("Amount cannot be negative");
        if (string.IsNullOrWhiteSpace(currency)) return Result.Failure<Money>("Currency required");
        return Result.Success(new Money(amount, currency));
    }
}
```

### Strongly-typed ID

IDs are the exception to the private-constructor rule — they carry no invariants
beyond type safety, so a public constructor is fine.

```csharp
public record OrderId(Guid Value)
{
    public static OrderId New() => new(Guid.NewGuid());
}
```

## Don't

- Use primitive types (`string`, `Guid`, `int`) for domain concepts.
- Add mutable state to a value object.
- Skip validation — "I know it'll be valid" is how bugs happen.
