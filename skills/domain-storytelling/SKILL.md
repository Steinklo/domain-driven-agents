---
name: domain-storytelling
description: Facilitation technique where domain experts narrate concrete scenarios while a modeler draws them with a pictographic grammar of actors, work objects, and numbered activities; use when onboarding to an unfamiliar domain, harvesting the ubiquitous language, or discovering real workflows and natural boundaries before modeling.
---

# Domain Storytelling

A workshop technique where domain experts tell concrete stories about how work actually happens, while a modeler records each step live as a simple picture: actors acting on work objects, connected by numbered activities that read as a sentence.

## Why it matters
People explain their work best through examples, not definitions. Abstract requirements hide disagreement and invented jargon; a narrated story exposes both instantly. The recorded pictures surface the real ubiquitous language, reveal the true sequence of work, and show where responsibility naturally shifts — the seams that later become subdomains and bounded contexts.

## Core rules
1. Work from one concrete, named scenario ("A customer returns a damaged book"), never a generic "the system shall".
2. Use the fixed grammar: **actors** (who acts) perform **numbered activities** (verbs) on **work objects** (documents, items, information).
3. Number every activity so the diagram reads left-to-right as an ordered sentence the expert can read back aloud.
4. Let the domain expert narrate and correct in real time; the modeler only draws, staying silent on solutions.
5. Capture the words experts actually use as labels — this is the raw ubiquitous language, not your paraphrase.
6. Scope each story: pick a clear beginning and end, one point in time, and one variant (pure happy path first, then exceptions as separate stories).
7. Watch for where an actor hands a work object to another actor with different vocabulary — flag it as a candidate boundary.

## Example
Story: "A member borrows a book that is currently on loan."

```
[Member] --1: requests--> (Book) --2: is checked by--> [Librarian]
[Librarian] --3: places--> (Reservation) --4: notified via--> [Member]
[Librarian] --5: hands over--> (Book) --6: receives--> [Member]
```

Reading it back: "The member requests a book; the librarian checks it, places a reservation, and notifies the member; later the librarian hands over the book, which the member receives." The expert immediately corrects: "We call it a *hold*, not a reservation" — the language is captured on the spot.

## Signs you're getting it wrong
- The diagram describes an abstract capability instead of one specific happy-path scenario.
- Activities are unnumbered, so the story has no readable order.
- The modeler is proposing designs or database tables instead of transcribing the expert's words.
- Labels are your invented terms rather than the domain expert's vocabulary.
- One diagram tries to cram every branch, exception, and edge case together.
- No actor-to-actor handoffs are noticed, so natural boundaries stay invisible.

## Related
Feeds [[ubiquitous-language]] directly and complements event storming and example mapping as a discovery workshop. The handoffs it surfaces inform subdomain and bounded-context boundaries and context mapping; the work objects and activities hint at [[aggregates]], [[value-objects]], and [[domain-events]].
