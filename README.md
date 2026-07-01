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
skill's description and pulls in the relevant one when your request touches it. You
can also invoke one explicitly.

```
# Let the harness choose — it surfaces `aggregates` + `invariants` on its own
"Model an Order that can't be confirmed once it has shipped."

# Name a skill explicitly so the harness reaches for it
"Apply the value-objects skill: turn this Money string+decimal pair into a
 proper type."

# Ask a skill to critique existing code
"Use the repositories skill to check whether OrderRepository is a real
 repository or just a table gateway."
```

**Agents** carry the *role*. Adopt one to drive the session, or spawn one to do a
self-contained piece of work.

```
# Adopt the modeler as the driving role (interactive)
"Act as the modeler. Interview me about a 'gift card redemption' feature
 until the language and boundaries are clear."

# Spawn the implementer against an agreed model
"Spawn the implementer to build the GiftCard aggregate we just modeled
 in ~/projects/wallet, matching the existing project conventions."

# Spawn the reviewer for an independent pass
"Have the reviewer judge the uncommitted changes against the DDD tactical
 rules and report findings ranked by severity."
```

## A full run: user story → pull request

One prompt can drive the whole team from a raw story to an open PR. The trick is to
let each role play to its strength — the `modeler` interactively, then the
`implementer` and `reviewer` as a spawn-and-loop.

```
Take user story SHOP-412 — "A customer can apply a discount code at checkout" —
through the full DDD flow in ~/projects/shop:

1. Start as the modeler. Interview me to pin down the ubiquitous language, the
   bounded context this belongs in, and the rules (as concrete examples) before
   any code. Show me the model sketch and wait for my approval.
2. Once I approve, spawn the implementer to build it in the target project,
   conforming to its existing structure. Cover every rule with a test.
3. Spawn the reviewer to judge the result on fresh context. Loop any findings
   back to the implementer until the reviewer is clean.
4. When it passes, open a pull request summarizing the model decisions,
   the invariants enforced, and the tests added.
```

What happens at each step:

| Step | Role | Output |
|---|---|---|
| **1. Model** | `modeler` (drives) | Glossary terms, the context + candidate boundaries (yours to approve), rules written as examples |
| **2. Build** | `implementer` (spawned) | Aggregates/value objects/events with invariants guarded, plus tests for each rule and example |
| **3. Judge** | `reviewer` (spawned, fresh context) | Findings ranked by severity; fixes loop back to the implementer |
| **4. Ship** | main session | Branch + pull request describing the model, invariants, and tests |

The human stays in the loop where it counts — approving the boundaries in step 1
(humans own boundaries) — and the autonomous roles handle the mechanical build-and-check
in steps 2–3. For a larger story you can fan the implementer out per aggregate and run
a reviewer on each.

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
