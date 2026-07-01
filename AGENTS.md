# Agent Guide

## Project Shape
- Jekyll personal portfolio deployed through GitHub Pages.
- Main content lives in `_includes/landing.html`, `_posts/`, `_projects/`, `pages/`, and `_data/`.
- Styling lives in `_sass/`; the compiled entrypoint is `assets/css/style.scss`.
- Contact form behavior lives in `_includes/contact.html` and `assets/js/contact.js`.

## Local Commands
- Build: `bundle exec jekyll build`
- Serve: `bundle exec jekyll serve`
- On the local Ruby 4 Windows setup, prefer:
  `ruby scripts/jekyll_local.rb build`
  `ruby scripts/jekyll_local.rb serve`
- If Git refuses to run because of ownership, use:
  `git config --global --add safe.directory C:/Users/aleso/alesordo.github.io`

## Editing Rules
- Keep changes small and commit by topic.
- Use public, non-confidential professional details only.
- Prefer existing Bootstrap/Jekyll patterns over new dependencies.
- Keep copy concise, concrete, and aligned with Alessio's current Backend + AI positioning.
- Do not commit generated `_site/`, caches, logs, or local bundle files.

## Content Direction
- Primary profile: backend/payment systems engineer with applied AI/RAG experience.
- Secondary profile: research-oriented builder of practical LLM evaluation and retrieval systems.
- Older IoT, thesis, course, and hackathon work should remain available but not dominate the first impression.
- STELLAR-E is public research and may be linked through arXiv.

## Contact Form Notes
- The form uses Google Apps Script as its backend.
- Keep the honeypot field named `address`.
- Preserve redirects to `/thanks` and `/failed`.
- Check dark-theme input and textarea readability whenever editing form styles.
