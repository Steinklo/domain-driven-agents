---
name: ddd-start
scope: shared
used-by: []
description: Entry point for the Domain-Driven Agents pipeline. Use when the user brings a user story or task plus a target project — it acquires the story, sizes the task, and hands off to the Planner. Start here for new DDD work.
---

# Start a DDD task

Kick off the pipeline for a unit of work. You orchestrate the sequence; the role
agents do the work, each in its own fresh context.

## Steps

1. **Get the work and the project.** The user names a unit of work — a user story or
   task, often just a reference — and the target project path. Confirm both.
2. **Acquire the story content.** A reference (an ID, a title) isn't enough to plan
   from. Ask the human to paste the story, point you to a file, or — if a tracker is
   configured — fetch it. The story is raw input; the Planner refines it.
3. **Load the conduct.** Read the `pipeline-conduct` skill — task sizing, handoffs,
   and the always-on boundaries every role follows.
4. **Size the task.** Propose a tier (Trivial / Standard / Domain) and confirm it
   with the human. Only a human may place boundary- or invariant-touching work below
   Domain; when unsure, round up.
5. **Hand off by tier.**
   - **Standard / Domain** → the **planner** agent. It grills the story, seeds the
     glossary, and writes the contract into `docs/contracts/` in the target project.
     The pipeline then runs Planner → Executor → Reviewer → Documenter, each a fresh
     subagent with isolated context.
   - **Trivial** → the **executor** agent directly, against the existing code and
     glossary — no contract, no handoff artifacts.
