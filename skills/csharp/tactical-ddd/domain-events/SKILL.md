---
name: domain-events
scope: csharp
used-by: [executor, reviewer]
---

# Domain Events

A domain event represents **something that happened** in the domain. It is a
fact, named in past tense, originating inside an aggregate.

Recommended implementation:
[martinothamar/Mediator](https://github.com/martinothamar/Mediator)
— events as `INotification`, handlers as `INotificationHandler`.

## Rules

1. **Events are raised inside the aggregate** — via a base class method
   like `AddDomainEvent(event)`.
2. **Events are published in the Application layer** — typically by a pipeline
   behavior or the repository on save.
3. **Event handlers live in Application** — they orchestrate side effects
   (send email, update read model, trigger another command).
4. **Handlers contain no business logic that belongs in an aggregate.**
   If the logic enforces an invariant, it belongs in the aggregate.
5. **Events are immutable records.**

## Structure

### Event (Domain)

```csharp
public record OrderPlacedEvent(OrderId OrderId, CustomerId CustomerId, DateTime OccurredAt)
    : INotification;
```

### Handler (Application)

```csharp
public class OrderPlacedHandler(IEmailService emailService)
    : INotificationHandler<OrderPlacedEvent>
{
    public async ValueTask Handle(OrderPlacedEvent e, CancellationToken ct)
    {
        await emailService.SendOrderConfirmation(e.OrderId, e.CustomerId, ct);
    }
}
```

### Raising (inside aggregate)

```csharp
public static Result<Order> Create(CustomerId customerId, /* ... */)
{
    var order = new Order(/* ... */);
    order.AddDomainEvent(new OrderPlacedEvent(order.Id, customerId, DateTime.UtcNow));
    return Result.Success(order);
}
```

## Don't

- Raise events outside the aggregate.
- Put invariant-enforcing logic in an event handler.
- Use events for synchronous, in-process method calls (just call the method).
- Forget to make events immutable.
