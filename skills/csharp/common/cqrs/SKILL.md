---
name: cqrs
scope: csharp
used-by: [executor, reviewer]
description: Separates command and query pipelines via Mediator — commands mutate through aggregates returning Result<T>, queries read projections, with cross-cutting concerns in Application. Use when adding a command or query handler, placing validation/transaction/logging behaviors, or reviewing for mixed read/write or handler-to-handler calls.
---

# CQRS

Commands and queries are **separate pipelines**. Commands mutate state; queries
read it. Never mix.

Recommended implementation:
[martinothamar/Mediator](https://github.com/martinothamar/Mediator)
— source-generated, with built-in `ICommand`, `IQuery`, and `INotification` types.

## Rules

1. **Commands return `Result<T>`** (or `Result` for void). Queries return data.
2. **One handler per command/query.** No shared handlers.
3. **Commands go through aggregates.** The handler loads the aggregate, calls a
   method, saves.
4. **Queries may bypass the domain model** — read from projections, views, or
   raw SQL.
5. **A query that mutates state is a violation.** Review must catch this.
6. **Handlers live in the Application project.**

## Structure

### Command

```csharp
public record PlaceOrderCommand(CustomerId CustomerId, List<LineItemDto> Items)
    : ICommand<Result<OrderId>>;

public class PlaceOrderCommandHandler(IOrderRepository repo)
    : ICommandHandler<PlaceOrderCommand, Result<OrderId>>
{
    public async ValueTask<Result<OrderId>> Handle(PlaceOrderCommand cmd, CancellationToken ct)
    {
        var result = Order.Create(cmd.CustomerId, cmd.Items);
        if (result.IsFailure) return Result.Failure<OrderId>(result.Error);

        await repo.AddAsync(result.Value, ct);
        return Result.Success(result.Value.Id);
    }
}
```

### Query

```csharp
public record GetOrderByIdQuery(OrderId Id) : IQuery<OrderDto?>;

public class GetOrderByIdQueryHandler(IOrderReadRepository repo)
    : IQueryHandler<GetOrderByIdQuery, OrderDto?>
{
    public async ValueTask<OrderDto?> Handle(GetOrderByIdQuery query, CancellationToken ct)
        => await repo.GetDtoByIdAsync(query.Id, ct);
}
```

## Cross-cutting concerns

Logging, validation, transactions, and retry live in the Application layer —
never in the domain.

1. **Validation returns `Result.Failure`** — does not throw.
2. **Transactions apply to commands only** — queries are read-only.
3. **No domain logic** in cross-cutting concerns — that's the aggregate's job.
4. **Order matters** — validation before transaction before retry.

Consider also: **Performance** — log warnings for slow requests (e.g. > 500 ms).

## Don't

- Put business logic in the handler — delegate to the aggregate.
- Share a handler between a command and a query.
- Return an aggregate from a query handler — return a DTO/projection.
- Call other handlers from a handler — use domain events instead.
