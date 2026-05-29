---
name: solution-structure
scope: csharp
used-by: [planner, reviewer]
---

# Solution Structure

Layers are **separate C# projects** — the compiler enforces dependency direction.

## Project layout

```
src/
  MyApp.Domain/              # Zero dependencies
  MyApp.Application/         # -> Domain
  MyApp.Infrastructure/      # -> Domain, Application
  MyApp.Api/                 # -> Application (Presentation)
  MyApp.Functions/           # -> Application (Presentation, optional)
tests/
  MyApp.Domain.Tests/
  MyApp.Application.Tests/
  MyApp.Architecture.Tests/  # NetArchTest rules
```

## Dependency rules

| Project | May reference | Must NOT reference |
|---|---|---|
| Domain | nothing | Application, Infrastructure, Presentation |
| Application | Domain | Infrastructure, Presentation |
| Infrastructure | Domain, Application | Presentation |
| Api / Functions | Application, Infrastructure* | Domain (directly) |

\* **Composition root only.** Presentation references Infrastructure for DI
registration in `Program.cs`. Controllers and endpoints must not use
Infrastructure types — only Application interfaces.

## Rules

1. **One `.sln` file at the repo root.**
2. **Namespace = project name + folder path** (`MyApp.Domain.Orders`).
3. **No shared "Common" project.** If two layers need the same type, it belongs
   in Domain.
4. **Presentation projects are thin** — dependency injection wiring, middleware,
   and command/query dispatch only.

## Naming conventions

| Element | Convention | Example |
|---|---|---|
| Aggregate / Entity | PascalCase noun | `Order`, `LineItem` |
| Value Object | PascalCase noun | `Money`, `Address` |
| Command | Verb + noun | `PlaceOrder`, `CancelShipment` |
| Query | Get/List + noun | `GetOrderById`, `ListActiveOrders` |
| Domain Event | Past-tense verb + noun | `OrderPlaced`, `PaymentReceived` |
| Handler | Command/Query/Event name + `Handler` | `PlaceOrderHandler` |

## Don't

- Put domain types in Application "for convenience".
- Create a `Shared` or `Core` project that everything references.
- Use Infrastructure types in controllers/endpoints — the reference exists
  only for DI wiring in `Program.cs`.
