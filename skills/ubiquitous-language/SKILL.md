---
name: ubiquitous-language
description: Maintains a rigorous shared vocabulary used identically by domain experts and developers in speech, docs, and code. Use when naming a domain concept, seeding or updating a glossary, or resolving a term that means different things in different contexts.
---

# Ubiquitous Language

A shared, precise language between developers and domain experts, spoken in conversation, written in docs, and expressed directly in code. Within a bounded context, one term has exactly one meaning.

## Why it matters
Translation between "business words" and "developer words" leaks meaning and hides bugs. When the model, the code, and the conversation use the same terms, misunderstandings surface early and the code becomes a faithful, readable expression of the domain. Without it, experts and engineers drift into parallel vocabularies that no longer describe the same system.

## Core rules
1. **One term, one meaning per bounded context.** No synonyms, no overloading a word with two ideas.
2. **The same word may mean different things across contexts** — that is expected; make each meaning explicit and bound to its own context, never blur them into one.
3. **Domain experts name things.** If the business says "Policy", the code says Policy — not Rule, Contract, or Plan.
4. **Code mirrors the language.** Types, operations, and variables carry glossary terms, adjusted only for the programming language's casing conventions.
5. **Maintain a glossary** as a living artifact in the repo, one per bounded context, seeded early and kept current — not written up at the end.
6. **Let the model and language evolve together.** When a conversation reveals a sharper term, update the glossary and the model at once.
7. **Rename in code when the language shifts.** A stale name is a defect; fix it the moment the term changes.

## Example
A term enters the glossary the moment it is agreed:

| Term | Definition (the *what*, never the *how*) | Context |
|---|---|---|
| Policy | A customer's active insurance agreement | Underwriting |
| Policy | A rule governing access permissions | Access Control |

Conversation: "When a **Policy** lapses, notify the holder." The code names the operation *lapse* on *Policy* and raises a *Policy Lapsed* event — the same words, no translation layer, and never a disguised name such as *record status flag*.

## Signs you're getting it wrong
- Inventing abbreviations (*Ord* for Order) or technical jargon as domain names (*Entity*, *Record*, *DataObject*).
- Developers and experts using different words for the same concept in the same meeting.
- The same term meaning two things inside one context, disambiguated only by tribal knowledge.
- Code names that require a mental "that really means..." translation.
- A glossary that is stale, absent, or spans all contexts as one flat list.

## Related
[[aggregates]] · [[value-objects]] · [[domain-events]] · [[domain-services]]
