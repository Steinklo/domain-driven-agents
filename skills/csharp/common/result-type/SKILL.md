---
name: result-type
scope: csharp
used-by: [executor, reviewer]
---

# Result\<T\>

Represents the outcome of an operation that can fail on business rules.
This defines the **contract** — not the implementation. Projects choose
their own (custom or package).

## Contract

| Member | Purpose |
|---|---|
| `IsSuccess` / `IsFailure` | Boolean status |
| `Value` | Success value (accessing on failure is an error) |
| `Error` | Failure reason (accessing on success is an error) |
| `Result.Success(value)` | Factory for success |
| `Result.Failure(error)` | Factory for failure |

## Usage by layer

| Layer | How it uses Result |
|---|---|
| **Domain** | Returns `Result<T>` from factory methods and operations on business rule violations |
| **Application** | Handlers receive and propagate `Result`; pipeline behaviors (validation) return `Result.Failure` |
| **Presentation** | Maps `Result` to HTTP status codes or error responses |

## Don't

- Throw exceptions for expected business rule violations — use `Result.Failure`.
- Return `null` to signal failure.
- Ignore `IsFailure` — always check before accessing `Value`.
