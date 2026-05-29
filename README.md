# Domain-Driven Agents

AI agent pipeline for building C# software following Domain-Driven Design.

**Skills** define the coding standards. **Agents** are the roles that apply them.
Because every agent reads the same skills, they cannot disagree on what "good code" is.

> Humans own the domain boundaries.
> AI accelerates implementation *within* clearly defined bounded contexts.

## What it does

Four agents run in sequence — **Planner**, **Executor**, **Reviewer**, **Documenter** —
connected by a structured **contract** that carries context between them.
The Planner designs, the Executor implements code and tests, the Reviewer judges
independently, and the Documenter records what was approved.

## How it works

This repo is a collection of markdown files — no runtime, no dependencies.
The target project it produces will have its own dependencies (e.g. Mediator,
NetArchTest, FluentValidation).

- **Skills** (`skills/`) — coding rules, patterns, and examples. The durable
  knowledge base that agents reference.
- **Agents** (`agents/`) — role definitions with behavior, skills to read,
  and what to produce.
- **Contract** (`contract-template.md`) — structured handoff format between
  agents. The Planner produces a filled contract per task; store it in the
  target project (e.g. `docs/contracts/`) so downstream agents can read it.
- **AGENTS.md** — universal conduct rules all agents follow.

## Scope

The pipeline's guidance centers on the **Domain and Application layers**, where
the durable DDD knowledge lives. Infrastructure and Presentation are largely
project-specific: the pipeline enforces their boundaries (Presentation stays thin,
Infrastructure points inward, the domain never leaks) via architecture tests, but
does not prescribe technology preferences.

## Getting started

1. Open this repo in your AI coding agent.
2. The agent reads `AGENTS.md`, asks which role to assume, loads the relevant
   skills, and asks what to build.
3. Tell it what project to work on.

```
cd domain-driven-agents
your-agent
> "I want to add an Order aggregate to ~/projects/my-app"
```

The agent will ask you to pick a role (e.g. Planner to design the contract,
Executor to implement) before starting work.
