# Domain Docs

This repository uses a single-context domain documentation layout.

## Before exploring

Read these sources when they exist:

- `CONTEXT.md` at the repository root
- Relevant ADRs under `docs/adr/`

If they do not exist, proceed silently. Domain-modeling skills create them
when domain terminology or architectural decisions are resolved.

## Expected structure

```text
/
├── CONTEXT.md
├── docs/
│   └── adr/
└── src/
```

## Vocabulary

Use domain terms defined in `CONTEXT.md`. Avoid introducing synonyms that
conflict with its glossary.

## ADR conflicts

If proposed work contradicts an existing ADR, report the conflict explicitly
rather than silently overriding the decision.
