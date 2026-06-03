---
name: arch-testing-dotnet
scope: csharp
used-by: [executor, reviewer]
description: Enforces layer boundaries mechanically with NetArchTest xUnit tests covering dependency direction, CQRS separation, and absent EF attributes on domain types. Use when adding an architecture rule, writing or running boundary tests, or reviewing that a new contract rule is covered by a test.
---

# Architecture Testing — NetArchTest

Architecture tests run as **xUnit tests** in `MyApp.Architecture.Tests`.
They enforce layer boundaries mechanically — violations fail CI before review.

## Required tests

1. **Domain has no dependencies** on Application, Infrastructure, or Presentation.
2. **Application depends only on Domain.**
3. **Infrastructure does not depend on Presentation.**
4. **Presentation does not use Infrastructure types** — the project reference
   exists only for DI registration (composition root). Test all Presentation
   assemblies (Api, Functions), and exclude only the composition root.
5. **Commands do not appear in query handlers** (and vice versa).
6. **Domain classes have no EF Core attributes.**

## Rules

1. **Architecture tests run in CI alongside unit tests** — same `dotnet test`.
2. **Add a new test for every new architecture rule** in the contract.
3. **Tests assert `IsSuccessful`** — on failure, NetArchTest reports which
   types violated the rule.

## Don't

- Skip arch tests "because the code is correct" — they catch regressions.
- Put arch tests in the same project as unit tests — keep them separate.
