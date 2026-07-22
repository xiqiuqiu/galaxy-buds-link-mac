# Issue tracker: GitHub

Issues and PRDs for this repository live in GitHub repository
`xiqiuqiu/galaxy-buds-link-mac`. Use the `gh` CLI for all operations.

## Conventions

- Create: `gh issue create --title "..." --body "..."`
- Read: `gh issue view <number> --comments`
- List: `gh issue list --state open`
- Comment: `gh issue comment <number> --body "..."`
- Apply labels: `gh issue edit <number> --add-label "..."`
- Remove labels: `gh issue edit <number> --remove-label "..."`
- Close: `gh issue close <number> --comment "..."`

## Pull requests as a triage surface

**PRs as a request surface: no.**

## Skill operations

- “Publish to the issue tracker” means creating a GitHub issue.
- “Fetch the relevant ticket” means running
  `gh issue view <number> --comments`.

## Wayfinding

- A map is one issue labelled `wayfinder:map`.
- Child tickets use `wayfinder:research`, `wayfinder:prototype`,
  `wayfinder:grilling`, or `wayfinder:task`.
- Prefer GitHub sub-issues and native issue dependencies.
- Claim work with `gh issue edit <number> --add-assignee @me`.
- Resolve work by commenting with the result, closing the child issue,
  and updating the map’s Decisions-so-far section.
