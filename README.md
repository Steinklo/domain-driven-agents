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

How much of the pipeline runs **scales with the task**: a scope gate sizes each task
Trivial / Standard / Domain, and only the heavier tiers pull in the full ceremony.
Steps hand off through role-appropriate artifacts (the contract, a delivery-note, a
review verdict) that keep each agent's context isolated — see `AGENTS.md`.

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
- **AGENTS.md** — universal conduct, task sizing, and handoffs all agents follow.

## Scope

The pipeline's guidance centers on the **Domain and Application layers**, where
the durable DDD knowledge lives. Infrastructure and Presentation are largely
project-specific: the pipeline enforces their boundaries (Presentation stays thin,
Infrastructure points inward, the domain never leaks) via architecture tests, but
does not prescribe technology preferences.

## Getting started

1. Open this repo in your AI coding agent.
2. Point it at a unit of work — a user story or task — and the target project.
   It begins as the Planner and asks for the story's content: paste it, point to a
   file, or (if your tracker is wired up) let it fetch.
3. It sizes the task (Trivial / Standard / Domain), grills you to close the gaps,
   then writes the contract into the target project — and the pipeline runs from there.

```
cd domain-driven-agents
your-agent
> "Hi! Let's work on user story 123456 in ~/projects/my-app"
```

The story is raw input; the Planner refines it into the contract through grilling.
It asks before it assumes.
