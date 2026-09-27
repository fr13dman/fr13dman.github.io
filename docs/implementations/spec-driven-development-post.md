# Spec-driven development post

Implementation note for the blog post on spec-driven development with GitHub Spec Kit.

## What was added

- Branch: `add-spec-driven-development-post`, created from an up-to-date `main`.
- Post: `_posts/2026-09-26-spec-driven-development-with-github-spec-kit.md`.
- Front matter follows the Writing Posts and Search Metadata sections of `README.md`: `layout`, `title`, `date`, `categories`, `tags`, `keywords`, and `description`.
- The post date is `2026-09-26 14:30:00 -0400`, which is not in the future relative to the day it was added, so Jekyll will publish it on the next build.
- `docs/` and `tests/` are listed in `_config.yml` `exclude` so this note and the front-matter check are not copied into the GitHub Pages site.

## How the post was built

The filename uses the README pattern `YYYY-MM-DD-post-title.md`.

The body matches the voice of the existing posts: first person, a definition, a comparison table, a practical walkthrough, and a short list of failure modes using the existing `note-list` markup.

Technical claims were taken from the Spec Kit repository README and the quickstart at `docs/quickstart.md` on `github/spec-kit` (checked September 26, 2026):

- Install with `uv tool install specify-cli`, then `specify init my-project --integration copilot`.
- Core loop: constitution, specify, plan, tasks, implement, converge.
- Full path adds clarify, checklist, and analyze.
- Active feature state lives in `.specify/feature.json`, not the current Git branch.
- Command spelling differs by agent integration: hyphenated `/speckit-*` skills versus dotted `/speckit.*` commands.

No images or downloadable media were added. The post links to the Spec Kit repo, the Spec Kit docs site, the uv docs, and the quickstart.

## Technologies considered

- **Jekyll Markdown post.** Used. This site already publishes `_posts/` through the Garth remote theme and GitHub Pages. A new page or a separate docs site would not show up on `/blog/`.
- **Embeds or diagrams.** Not used. The workflow fits a table, and there was no source image to commit under `assets/images/`.
- **Pinning a Spec Kit release tag in the post.** Considered and rejected as a hardcoded version. The post tells the reader to pin a release at install time because the CLI moves quickly.
- **Ruby test without a new gem.** Used. The repo has no RSpec or minitest setup. `tests/spec_driven_development_post_test.rb` checks required front matter with the standard library so the post cannot ship without title, date, description, tags, and keywords.

## How to verify

```bash
ruby tests/spec_driven_development_post_test.rb
bundle exec jekyll serve
```

Then open `http://127.0.0.1:4000/blog/` and the post URL. Confirm the title, date, and headings render, and that the post is not hidden as a future-dated draft.
