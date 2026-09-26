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

Coding agents are happy to start typing the moment you describe a feature. That speed is the trap. The agent fills in product decisions you never made, then you spend the review arguing with code that should have been a spec. Spec-driven development flips that order: write down what you are building and why, then let the agent implement against those artifacts.

[GitHub Spec Kit](https://github.com/github/spec-kit) is the toolkit I have been using to do that. It is an open-source harness around a coding agent. You still pick the agent. Spec Kit gives that agent a repeatable process and Markdown files that carry the intent from one step to the next.

## What spec-driven development is asking for

For a long time the spec was scaffolding. You wrote it so people could align, then the code became the source of truth and the doc went stale. Spec-driven development treats the specification as the thing you keep. The spec says what the user can do and why it matters. The plan says how you will build it. Tasks break that plan into ordered work. Implementation is supposed to follow those files, not invent a parallel product in the chat window.

Spec Kit's own framing is that specifications become executable: they generate the implementation instead of only guiding it. I would soften that. The spec does not compile. An agent reads it, writes code, and you still review the diff. The win is that the agent has a stable brief, and you have something to check the code against when the brief and the diff disagree.

## The Spec Kit loop

Install the CLI with [uv](https://docs.astral.sh/uv/), then initialize a project for your agent. Copilot is the usual example. The same init flow supports other integrations, and `generic` is the escape hatch when yours is not listed.

```bash
uv tool install specify-cli
specify init my-project --integration copilot
cd my-project
```

`specify init` writes the command files and directory layout your agent expects. After that, the work happens in the agent chat, one step at a time. The current quickstart uses hyphenated skill names. Some agents, including VS Code Copilot Chat, surface the same steps as dotted `/speckit.*` commands. The sequence is the same either way.

| Step | Command | What you hand it | What you should get back |
| --- | --- | --- | --- |
| Constitution | `/speckit-constitution` | Principles for quality, testing, UX, performance, security | Project rules later steps are judged against. Once per project, then only when the rules change. |
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

`/speckit-implement` also reads checklist state. If items are still open it should ask before it builds, and it should not silently check them off for you.

There is a separate bug path (`/speckit-bug-assess`, `/speckit-bug-fix`, `/speckit-bug-test`) and an idea-assessment path that ends in go, needs-clarification, or kill. Those are optional extensions (`specify extension add bug` and `specify extension add assess`). They are not prerequisites for building a feature. A "go" from assessment can be handed to `/speckit-specify`.

## How I would actually run a feature

Keep specify boring and concrete. Name the users, the actions, and the boundaries. "Albums are never nested" is a spec. "Use Vite and SQLite" is a plan. Mixing them makes the agent treat a library choice as a product requirement, or a product rule as an implementation detail it can trade away.

A specify prompt I would trust looks like this:

```text
/speckit-specify Build a photo organizer. People create albums, group them by date, and reorder albums by dragging on the main page. Albums are never nested. Inside an album, photos show as tiles. This phase is local only: no accounts and no sharing.
```

The plan comes after, and it is allowed to be technical:

```text
/speckit-plan Use Vite with as few libraries as possible. Vanilla HTML, CSS, and JavaScript. Photos stay on disk. Album and photo metadata live in a local SQLite database.
```

Then clarify if the drag behavior, empty states, or delete rules are fuzzy. Checklist and analyze if more than one person will live with the result. Tasks, implement, converge.

Review the Markdown before you let the next command run. Spec Kit is a sequence of artifacts. If specify wrote the wrong behavior, plan and tasks will faithfully build the wrong behavior.

## Where this goes wrong

<div class="note-list" markdown="1">
- Spec theater. A long spec that restates the prompt, with no decisions, does not constrain the agent. If two reasonable engineers would still build different products, specify is not done.
- Constitution as wallpaper. Principles only matter if later steps can violate them and you notice. "Code must be tested" is useless if implement is allowed to skip tests and converge never looks.
- Treating converge as a green check you do not read. The useful output is the gap list. Closing the loop means new tasks, another implementation pass, or an honest spec change when you meant to drop a requirement.
- Agent-specific command names. Hyphenated `/speckit-specify` skills, dotted `/speckit.specify` commands, and Copilot CLI's agent picker are the same workflow with different invocation. If a slash command is missing, check the integration mode before assuming Spec Kit did not install.
</div>

## What I am taking from it

Spec Kit does not remove the need for taste. It moves taste earlier, into the spec and the plan, where a bad sentence is cheaper than a bad pull request. The agent still writes the code. You still own the merge. The artifacts give you a place to point when the code drifted, and a loop that keeps going until the drift is either fixed or written back into the spec on purpose.

The project lives at [github/spec-kit](https://github.com/github/spec-kit), with the walkthrough on the [Spec Kit site](https://github.github.io/spec-kit/) and the command-by-command quickstart in the repo docs. Pin a release when you install if you want the commands in this post to match the CLI you actually run. The workflow is moving quickly, and the invocation syntax depends on which agent integration you initialized.
