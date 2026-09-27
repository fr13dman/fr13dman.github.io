---
layout: post
title: "Spec-driven development with GitHub Spec Kit"
date: 2026-09-26 14:30:00 -0400
categories: [blog, software-engineering, ai]
tags:
  - spec-driven-development
  - spec-kit
  - ai-coding-agents
keywords:
  - spec-driven development
  - GitHub Spec Kit
  - specify CLI
  - speckit specify plan tasks implement
description: "How spec-driven development works with GitHub Spec Kit, from constitution and spec through plan, tasks, implementation, and converge."
---

Coding agents are happy to start typing the moment you describe a feature. That speed can be a trap. The agent fills in product decisions you never made, then you spend the review arguing with code that should have been a spec. Spec-driven development flips that order: write down what you are building and why, then let the agent implement against those artifacts.

[GitHub Spec Kit](https://github.com/github/spec-kit) is the toolkit I have been using to do that. It is an open-source harness around a coding agent. Spec Kit gives that agent a repeatable process and Markdown files that carry the intent from one step to the next. This post follows Spec Kit 1.0.12. Later releases may change the commands.

## The philosophy behind spec-driven development

For a long time the spec was scaffolding. You wrote it so people could align, then the code became the source of truth and the doc went stale. Spec-driven development treats the specification as the thing you keep.

GitHub describes SDD as a change in which specifications become executable and generate implementations rather than merely guiding them. I would soften that. The spec does not compile. An agent reads it, writes code, and you still review the diff. The win is that the agent has a stable brief, and you have something to check the code against when the brief and the diff disagree.

SDD deliberately separates problem definition and implementation:

| Artifact | Primary question | Contains | Avoids |
| --- | --- | --- | --- |
| `spec.md` | What behavior and outcome are required? | Users, scenarios, requirements, acceptance criteria, edge cases, success measures | Framework and database choices unless they are true constraints |
| `plan.md` | How will the system meet the specification? | Architecture, technology, data model, APIs, risks, rollout, observability | Reinterpreting product requirements without approval |
| `tasks.md` | What work must be completed, in what order? | Small actions, dependencies, file paths, test work, checkpoints | New requirements that do not exist in the spec |
| Code and tests | Does the implementation satisfy the artifacts? | Production behavior and executable evidence | Silent changes to intended behavior |

## Getting Started

The official distribution channels are the `github/spec-kit` repository and the `specify-cli` package on PyPI. I pin a release tag so these commands stay attached to a version I actually read.

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@v1.0.12

# Initialize a new project for GitHub Copilot.
specify init taskflow --integration copilot

# Or initialize an existing repository.
cd taskflow
specify init --here --integration copilot

specify version
```

For Codex, use `--integration codex`. Other agents are listed in the [agent integrations](https://github.github.io/spec-kit/reference/integrations.html) reference. With `--integration copilot`, the steps show up as `/speckit-specify`. Codex often uses `$speckit-specify`. Some Copilot surfaces still use `/speckit.specify`. Same stages, different spelling.

A typical repository evolves toward:

```text
taskflow/
├── .specify/
│   ├── memory/constitution.md
│   ├── templates/
│   ├── scripts/
│   ├── feature.json
│   └── bugs/<bug-slug>/
├── specs/
│   └── 001-due-dates/
│       ├── spec.md
│       ├── plan.md
│       ├── tasks.md
│       ├── research.md
│       ├── data-model.md
│       ├── contracts/
│       └── checklists/
├── frontend/
├── backend/
├── tests/
└── .github/workflows/
```

## Hail the "Constitution"

`/speckit-constitution` writes `.specify/memory/constitution.md`. It is the constraint system later artifacts have to pass. Run it once per project, and again only when the rules change. Examples of what I would hand it:

- Security rules: authenticate every write, validate all external input, do not log secrets.
- Quality rules: regression tests are mandatory for bugs; contract tests protect public APIs.
- Architecture rules: business logic stays out of transport handlers; database changes require reversible migrations.
- Operational rules: user-visible flows require logs, metrics, and error handling; risky releases require a rollback plan.
- Delivery rules: small commits, required CI, human review, and no direct production deployment from an unreviewed branch.

## The Spec Kit loop

`specify init` writes the command files and directory layout your agent expects. After that, the work happens in the agent chat, one step at a time.

| Step | Command | What you hand it | What you should get back |
| --- | --- | --- | --- |
| Constitution | `/speckit-constitution` | Principles for security, quality, architecture, operations, and delivery | `.specify/memory/constitution.md`. Once per project, then only when the rules change. |
| Specify | `/speckit-specify` | What to build and why, in user-facing language | A feature spec. No tech stack here. |
| Plan | `/speckit-plan` | Stack, architecture, and technical constraints | Design artifacts, including the plan |
| Tasks | `/speckit-tasks` | Usually nothing extra if the plan is solid | A dependency-ordered `tasks.md` |
| Implement | `/speckit-implement` | Optional phase scope for large features | Code that follows the task list |
| Converge | `/speckit-converge` | The repo as it is | A gap check against spec, plan, and tasks |

Converge is the step I do not skip. If the codebase does not match the spec, it appends remaining work onto `tasks.md`. You implement again and converge again until it reports **Converged**. That loop is the difference between "the agent said it was done" and "the artifacts and the code agree."

Spec Kit tracks the active feature in `.specify/feature.json`, not by whichever Git branch you have checked out. Changing branches does not change which spec the commands read. If you want version-control branches per feature, the opt-in git extension can add numbered branches such as `001-feature-name`, but the active feature is still whatever that state file points at.

## The longer path, when the feature is not small

The short loop is enough for a tight change. For anything with real ambiguity, the [quickstart](https://github.com/github/spec-kit/blob/main/docs/quickstart.md) adds three quality gates:

1. `/speckit-clarify` before planning, so underspecified behavior gets questions and the answers land back in the spec.
2. `/speckit-checklist` after the plan, as a requirements-quality review. Checking an item means a reviewer accepted that the requirement is clear, not that the code is finished.
3. `/speckit-analyze` after tasks and before implementation. It is read-only. It looks for conflicts across `spec.md`, `plan.md`, and `tasks.md`. Fix the source artifact and run it again.

In order, that is constitution, specify, clarify, plan, checklist, tasks, analyze, implement, converge.

`/speckit-implement` also reads checklist state. If items are still open it should ask before it builds, and it should not silently check them off for you.

There is a separate bug path (`/speckit-bug-assess`, `/speckit-bug-fix`, `/speckit-bug-test`) and an idea-assessment path that ends in go, needs-clarification, or kill. Those are optional extensions (`specify extension add bug` and `specify extension add assess`). They are not prerequisites for building a feature. A "go" from assessment can be handed to `/speckit-specify`.

## How I would actually run a feature

Keep specify boring and concrete. Name the users, the actions, and the boundaries. "A member can clear a due date" is a spec. "Store the date as a nullable column" is a plan. Mixing them makes the agent treat a library choice as a product requirement, or a product rule as an implementation detail it can trade away.

A specify prompt I would trust looks like this:

```text
/speckit-specify Add due dates to Taskflow. A project member can set, change, or clear a due date on a task. A due date is a calendar date in the viewer's timezone, with no time of day. Overdue tasks stay in their column and show as overdue. This phase has no reminders and no recurring tasks.
```

The plan comes after, and it is allowed to be technical:

```text
/speckit-plan Keep the existing Taskflow API and database. Due dates are a nullable date column on tasks. The board shows the date on the card. No new services, and no reminder worker.
```

If the overdue rule or the timezone is still ambiguous, run the longer path before building: clarify, checklist, and analyze. Then tasks, implement, and converge.

Converge is where I check the claim that a member can clear a date. If the board can set a date and has no way to clear it, converge should append that gap to `tasks.md` instead of reporting **Converged**.

Review the Markdown before you let the next command run. Spec Kit is a sequence of artifacts. If specify wrote the wrong behavior, plan and tasks will faithfully build the wrong behavior.

## Where this goes wrong

<div class="note-list" markdown="1">
- Spec theater. A long spec that restates the prompt, with no decisions, does not constrain the agent. If two reasonable engineers would still build different products, specify is not done.
- Constitution as wallpaper. Principles only matter if later steps can violate them and you notice. "Code must be tested" is useless if implement is allowed to skip tests and converge never looks.
- Treating converge as a green check you do not read. The useful output is the gap list. Closing the loop means new tasks, another implementation pass, or an honest spec change when you meant to drop a requirement.
</div>

## What I am taking from it

Spec Kit does not remove the need for taste. It moves taste earlier, into the spec and the plan, where a bad sentence is cheaper than a bad pull request. The agent still writes the code. You still own the merge. The artifacts give you a place to point when the code drifted, and a loop that keeps going until the drift is either fixed or written back into the spec on purpose.

The project lives at [github/spec-kit](https://github.com/github/spec-kit), with the walkthrough on the [Spec Kit site](https://github.github.io/spec-kit/) and the command-by-command quickstart in the repo docs.
