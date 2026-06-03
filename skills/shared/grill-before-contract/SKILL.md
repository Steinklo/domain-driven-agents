---
name: grill-before-contract
scope: shared
used-by: [planner]
description: Structured interrogation the Planner runs before drafting a contract — surface every ambiguity and resolve each invariant and model boundary through one-question-at-a-time questioning. Use when starting a new task, when a user story is vague, or before filling contract-template.md.
---

# Grill Before Contract

A contract is only as good as the understanding behind it. The Planner's first job
is to **close the alignment gap** — interrogate the human until every invariant and
boundary the contract needs is resolved. Garbage in, garbage contract.

> "No-one knows exactly what they want." Your job is to make them say it out loud.

## Process

1. **Read what exists first.** The existing model, the glossary (`docs/glossary.md`),
   and the task as stated — if it's a user-story reference, get its content (paste,
   file, or configured fetch) before you start. Grill from knowledge, not a blank page.

2. **List the ambiguities before asking anything.** Write down every gap that would
   change the domain model: missing invariants, unclear boundaries, undefined terms,
   unstated failure behavior. This list *is* your interview agenda.

3. **Ask one decision at a time.** Present a single question, get the answer, then
   move on. Do not dump a numbered list of ten questions — the human will answer the
   easy ones and skip the load-bearing ones.

4. **Prioritize by model impact.** Resolve anything that affects an aggregate
   boundary, an invariant, or the ubiquitous language first. Cosmetic choices
   (naming style, formatting) you decide yourself and note as an `Assumption:`.

5. **Capture new terms as you go.** When the human names a concept, record it in
   `docs/glossary.md` immediately (see [`ubiquitous-language`](../ubiquitous-language/SKILL.md)) —
   don't wait for the Documenter. The bounded context may not be settled yet; that's
   fine — record the term and fill the **Bounded Context** column once the boundary
   is confirmed (it's one of the stop criteria below).

## Stop criteria

You are done grilling when **every** item below is true:

- [ ] Every invariant the contract will list has a confirmed, testable definition.
- [ ] Every aggregate/bounded-context boundary is either confirmed or explicitly
      flagged as "requires human approval".
- [ ] Every domain term in scope exists in the glossary with one agreed meaning.
- [ ] Every acceptance criterion can be written as a Gherkin scenario.

If you cannot reach all four, the gap is the human's to fill — ask, don't assume.

## Don't

- Start drafting the contract while ambiguities remain.
- Batch questions — one decision, one answer.
- Invent an answer to keep momentum. A wrong assumption in the domain layer costs
  more than a question.
