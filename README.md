<p align="center">
  <img src="assets/images/logo.png" alt="fr13dman.github.io logo" width="240">
</p>

# fr13dman.github.io

Personal GitHub Pages site built with Jekyll and the
[Garth](https://github.com/daviddarnes/garth) remote theme.

## Local Development

This site uses the GitHub Pages gem so local builds stay close to the
production GitHub Pages environment.

```bash
bundle install
bundle exec jekyll serve
```

Then open:

```text
http://127.0.0.1:4000/
```

## Project Structure

- `_config.yml` controls site metadata, theme settings, plugins, and logo paths.
- `index.md`, `about.md`, and `blog.md` are the base pages.
- `_posts/` contains blog posts.
- `_includes/site-header.html` customizes the Garth header.
- `_layouts/default.html` loads the theme CSS and local responsive overrides.
- `assets/logo.css` contains local responsive styling.
- `assets/images/logo.png` is the site logo and favicon.
- `assets/images/` stores images used by pages and posts.
- `assets/media/` stores downloadable media files such as PDFs, audio, video,
  and slide decks.

## Writing Posts

Yes: add new blog posts or pages on a new branch, test locally, commit the
change, push the branch, and open a pull request. That keeps `main` stable and
matches the same workflow used for site changes.

Start from an updated `main` branch:

```bash
git switch main
git pull --ff-only origin main
git switch -c add-my-new-post
```

Create new posts in `_posts/` using this filename format:

```text
YYYY-MM-DD-post-title.md
```

For example:

```text
_posts/2026-06-30-my-first-topic.md
```

Each post needs front matter at the top of the file:

```markdown
---
layout: post
title: "Post Title"
date: 2026-06-30 09:00:00 -0400
categories: blog
tags:
  - jekyll
  - github-pages
keywords:
  - Jekyll blog
  - GitHub Pages
  - static site
description: "A short search-friendly summary of this post."
---

Write the post content here.
```

The date should not be in the future unless you intentionally want Jekyll to
hide the post until that date.

Run the site locally before committing:

```bash
bundle exec jekyll serve
```

Then check:

```text
http://127.0.0.1:4000/
http://127.0.0.1:4000/blog/
```

When the post looks right, commit it:

```bash
git add _posts/YYYY-MM-DD-post-title.md
git commit -m "Add post title"
git push -u origin add-my-new-post
```

Open a pull request into `main`, review the preview/build status, and merge it
when ready.

## Adding Images and Media

Keep source files in the repo so GitHub Pages can publish them with the site.

Use these folders:

```text
assets/images/
assets/media/
```

Recommended organization:

```text
assets/images/2026/my-first-topic/diagram.png
assets/images/2026/my-first-topic/screenshot.jpg
assets/media/2026/my-first-topic/report.pdf
```

Add an image to a post or page with Markdown:

```markdown
![Diagram showing the topic](/assets/images/2026/my-first-topic/diagram.png)
```

Add a linked file:

```markdown
[Download the report](/assets/media/2026/my-first-topic/report.pdf)
```

Embed audio:

```html
<audio controls>
  <source src="/assets/media/2026/my-first-topic/audio.mp3" type="audio/mpeg">
</audio>
```

Embed video:

```html
<video controls width="100%">
  <source src="/assets/media/2026/my-first-topic/demo.mp4" type="video/mp4">
</video>
```

Use descriptive filenames and alt text. Search engines, screen readers, and
chat agents use nearby text, headings, captions, file names, and alt text to
understand media.

When committing a post with media:

```bash
git add _posts/YYYY-MM-DD-post-title.md assets/images/ assets/media/
git commit -m "Add post title"
git push -u origin add-my-new-post
```

## Search Metadata

Each post should include clear metadata in its front matter:

```yaml
title: "Readable Post Title"
description: "One or two sentences that summarize the post for search results."
categories: blog
tags:
  - topic-one
  - topic-two
keywords:
  - primary search phrase
  - related search phrase
```

Use `title` for the human-readable headline, `description` for the search result
summary, `tags` for site organization, and `keywords` for important phrases
people or chat agents may use when looking for the content.

Good post content also helps search:

- Use one clear `#` title or rely on the post title from front matter.
- Use descriptive `##` headings.
- Write useful link text instead of "click here".
- Add alt text for images.
- Include transcripts or summaries for audio and video.
- Keep URLs stable after publishing.

## Robots and Sitemap

GitHub Pages can expose `robots.txt` from the site root. Add or update
`robots.txt` when you want to tell search engines and chat agents what they may
crawl.

Example:

```text
User-agent: *
Allow: /

Sitemap: https://fr13dman.github.io/sitemap.xml
```

The `jekyll-sitemap` plugin can generate `sitemap.xml`. To enable it, add the
plugin in `_config.yml`:

```yaml
plugins:
  - jekyll-feed
  - jekyll-remote-theme
  - jekyll-seo-tag
  - jekyll-sitemap
```

Then build locally:

```bash
bundle exec jekyll build
```

Make sure `_config.yml` has the production URL before publishing:

```yaml
url: "https://fr13dman.github.io"
baseurl: ""
```

Commit metadata and crawler changes the same way as posts:

```bash
git add _config.yml robots.txt README.md
git commit -m "Update search metadata guidance"
git push
```

## Adding Pages

Use a new branch for pages too:

```bash
git switch main
git pull --ff-only origin main
git switch -c add-new-page
```

Create a Markdown file at the site root, such as `projects.md`:

```markdown
---
layout: page
title: Projects
permalink: /projects/
---

Page content goes here.
```

If the page should appear in the navigation, add it to `_config.yml`:

```yaml
navigation:
  - title: Home
    url: /
  - title: About
    url: /about/
  - title: Blog
    url: /blog/
  - title: Projects
    url: /projects/
```

Then build, commit, push, and open a pull request:

```bash
bundle exec jekyll build
git add projects.md _config.yml
git commit -m "Add projects page"
git push -u origin add-new-page
```

## Publishing

The site publishes from the `main` branch through GitHub Pages.
