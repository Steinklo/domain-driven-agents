---
name: solution-structure
scope: csharp
used-by: [planner, executor, reviewer]
description: Lays out layers as separate C# projects with compiler-enforced dependency direction, namespace and naming conventions, and a thin composition-root Presentation. Use when scaffolding the solution, placing a new type in the right project, or reviewing dependency direction and naming conventions.
---

# Solution Structure

Layers are **separate C# projects** — the compiler enforces dependency direction.

## Respect the host project first

If the target project already follows a coherent DDD / Clean Architecture layout,
conform to ITS structure and conventions — do not impose this layout on top of a
working one. Apply the conventions below only when scaffolding fresh, or when the
existing structure has no discernible pattern (genuinely incoherent).

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

## Organize by aggregate, not by type

Within each layer project, organize by aggregate/feature (a vertical slice), not
by technical type. Only the aggregate ROOT sits at the aggregate folder root;
every other type lives in a descriptive sub-folder.

```
MyApp.Domain/
  Common/                         # shared kernel: base types, shared value objects
  Orders/                         # aggregate (plural — matches the namespace MyApp.Domain.Orders)
    Order.cs                      # aggregate root — the ONLY file at the aggregate root
    Entities/        LineItem.cs
    ValueObjects/    Money.cs  ZipCode.cs
    Events/          OrderPlacedEvent.cs
    Repositories/    IOrderRepository.cs
  Customers/
    ...
```

```
MyApp.Application/
  Common/                         # shared behaviors, base handlers
  Orders/                         # feature, matches the Domain aggregate
    Commands/        PlaceOrderCommand.cs  PlaceOrderCommandHandler.cs
    Queries/         GetOrderByIdQuery.cs  GetOrderByIdQueryHandler.cs
    EventHandlers/   OrderPlacedEventHandler.cs
  Customers/
    ...
```

1. **Only the aggregate root at the aggregate folder root.** Entities, value
   objects, events, and the repository interface each go in a descriptive
   PascalCase folder (`Entities/`, `ValueObjects/`, `Events/`, `Repositories/`,
   and `DomainServices/` if needed).
2. **Folders are PascalCase** — never kebab-case. The `Namespace = project +
   folder path` rule means `value-objects` would be an illegal namespace segment
   (`MyApp.Domain.Orders.ValueObjects`).
3. **Command, its handler, and its validator are separate files in the same
   `Commands/` folder.** Same for queries in `Queries/`.
4. **Use the type sub-folders consistently — even when a folder holds a single
   file.** One predictable rule beats "it depends on size".
5. **`Common/` is a FOLDER inside a layer, not a separate project.** A per-layer
   `Common/` for that layer's shared kernel / shared behaviors is fine; a
   standalone `Shared`/`Core` project that every layer references is not (see
   below).

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
3. **No shared cross-layer "Common" project.** A per-layer `Common/` folder for
   that layer's own shared kernel / behaviors is fine; a separate project shared
   across layers is not. If two layers need the same type, it belongs in Domain.
4. **Presentation projects are thin** — dependency injection wiring, middleware,
   and command/query dispatch only.

## Naming conventions

| Element | Convention | Example |
|---|---|---|
| Aggregate / Entity | PascalCase noun | `Order`, `LineItem` |
| Value Object | PascalCase noun | `Money`, `Address` |
| Command | Verb + noun + `Command` | `PlaceOrderCommand`, `CancelShipmentCommand` |
| Query | Get/List + noun + `Query` | `GetOrderByIdQuery`, `ListActiveOrdersQuery` |
| Domain Event | Past-tense verb + noun + `Event` | `OrderPlacedEvent`, `PaymentReceivedEvent` |
| Handler | Class name + `Handler` | `PlaceOrderCommandHandler`, `OrderPlacedEventHandler` |

## Don't

- Put domain types in Application "for convenience".
- Create a separate `Shared` or `Core` project shared across layers (a `Common/`
  folder within a single layer is fine).
- Use Infrastructure types in controllers/endpoints — the reference exists
  only for DI wiring in `Program.cs`.
