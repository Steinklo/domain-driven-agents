# Domain-Driven Design Skills

A collection of **language-agnostic Domain-Driven Design skills** for Claude Code.
Each skill is a self-contained `SKILL.md` that teaches one DDD concept — what it is,
the rules that make it work, a concrete example, and the smells that signal you've
gotten it wrong. No framework, no language lock-in: the concepts, not the code.

The harness surfaces the right skill automatically when your work touches it, or you
can pull one in explicitly with `/skill-name`.

## The skills

**Strategic design** — where the boundaries are
| Skill | Use when |
|---|---|
| `ubiquitous-language` | Naming concepts so code and conversation share one language |
| `bounded-contexts` | Drawing the boundary inside which a model and its language stay consistent |
| `context-mapping` | Defining the relationships and integrations between contexts |
| `subdomains` | Deciding where to invest — core, supporting, or generic |

**Tactical design** — the building blocks
| Skill | Use when |
|---|---|
| `aggregates` | Clustering objects behind one root that guards a consistency boundary |
| `entities` | Modeling something defined by identity and continuity over time |
| `value-objects` | Modeling something defined by its attributes, immutable, no identity |
| `invariants` | Enforcing rules that must always hold, at construction and mutation |
| `domain-events` | Recording that something meaningful happened in the domain |
| `domain-services` | Placing domain logic that belongs to no single entity |
| `repositories` | Abstracting retrieval and persistence of whole aggregates |
| `factories` | Encapsulating complex, invariant-safe creation |
| `specifications` | Capturing a business predicate as a first-class object |

**Discovery** — how the language and boundaries get found
| Skill | Use when |
|---|---|
| `event-storming` | Exploring a domain fast with events, commands, and actors on a wall |
| `domain-storytelling` | Modeling from concrete narrated scenarios |
| `example-mapping` | Breaking a story into rules, examples, and open questions before coding |

## The agents

Three thin roles that *apply* the skills — a role, a skill list, and a short conduct
footer. No contract, no handoff protocol; the harness orchestrates them.

| Agent | Applies | How to run |
|---|---|---|
| `modeler` | discovery + strategic skills | Adopt as the driving role — it interviews you to find the language and boundaries |
| `implementer` | tactical building blocks | Spawn to build a feature inside an established context |
| `reviewer` | tactical rules + invariants | Spawn after implementation to judge it on fresh context |

The `modeler` is interactive (it grills you), so it works best as the primary role
rather than a background subagent; `implementer` and `reviewer` run well autonomously.

## Using it in a prompt

**Skills** carry the *knowledge*. You rarely name them — the harness reads each
skill's description and pulls in the relevant one when your request touches it, but
you can also invoke one explicitly.

```
# Let the harness choose — it surfaces `aggregates` + `invariants` on its own
"Model an Order that can't be confirmed once it has shipped."

# Name a skill explicitly
"Apply the value-objects skill: turn this Money string+decimal pair into a proper type."
```

**Agents** carry the *role*. Adopt one to drive the session, or spawn one for a
self-contained piece of work.

```
# Adopt the modeler as the driving role (interactive)
"Act as the modeler. Interview me about a 'gift card redemption' feature
 until the language and boundaries are clear."

# Spawn the reviewer for an independent pass
"Have the reviewer judge the uncommitted changes against the DDD tactical
 rules and report findings ranked by severity."
```

One prompt can chain all three — drive a feature from a fuzzy idea to reviewed code in
a single session:

```
"Act as the modeler. Interview me about gift-card redemption for our wallet until the
 ubiquitous language, the bounded context, and the redemption rules (as concrete
 examples) are clear — then show me the model and wait for my approval.

 Once I approve, spawn the implementer to build it in ~/projects/wallet, matching the
 existing conventions and covering every rule with a test. Then spawn the reviewer to
 judge it on fresh context, and loop its findings back to the implementer until clean."
```

The human stays in the loop where it counts — approving the boundaries before any code.

## What it produces

The `modeler` turns a fuzzy feature into shared language and rules written as testable
examples — the raw material the `implementer` builds and the `reviewer` checks:

```
Glossary
  Remaining Balance — the part of a gift card's face amount not yet redeemed;
  drops with each redemption, never below zero.

Invariant, as an example
  Given a gift card with remaining balance 30
  When  a redemption of 50 is attempted
  Then  it is rejected ("Insufficient Balance") and the balance stays 30
```

## Install

Add the marketplace, then install the plugin (installs use the `plugin@marketplace`
form):

```
/plugin marketplace add Steinklo/domain-driven-agents
/plugin install domain-driven-agents@steinklo
```

Once installed, the plugin's skills and agents are namespaced under the plugin —
e.g. the modeler is available as `domain-driven-agents:modeler`. You can also run
`/plugin` for the interactive install menu, or point any Claude Code agent at this
repo directly — the skills live under `skills/`.

## Layout

```
skills/<skill-name>/SKILL.md   one skill per folder, discovered by the harness
agents/<role>.md               a thin role that applies the skills
.claude-plugin/plugin.json     plugin manifest (lists every skill and agent)
scripts/check-plugin.sh        guardrail: manifest matches disk, agent skill refs resolve
```

## Contributing a skill

Each `SKILL.md` carries `name` + `description` frontmatter (the description is what
the harness matches to auto-invoke it) and follows a fixed shape: definition, why it
matters, core rules, a language-agnostic example, anti-patterns, and links to related
skills. Add the new folder to `plugin.json` and run `scripts/check-plugin.sh` to
confirm they stay in sync.
