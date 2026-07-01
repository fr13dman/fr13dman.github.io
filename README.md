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

## Writing Posts

Create new posts in `_posts/` using this filename format:

```text
YYYY-MM-DD-post-title.md
```

Each post needs front matter:

```markdown
---
layout: post
title: "Post Title"
date: 2026-06-30 09:00:00 -0400
categories: blog
---
```

## Publishing

The site publishes from the `main` branch through GitHub Pages.
