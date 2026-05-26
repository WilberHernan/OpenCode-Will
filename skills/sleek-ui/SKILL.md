---
name: sleek-ui
description: "Trigger: sleek-ui, design system catalog, apply design, re-skin, premium theme, editorial dark, brand design, apple theme, stripe theme, linear theme. 55+ brand design systems as JSON — apply any with one prompt."
license: Apache-2.0
metadata:
  author: gentleman-programming, luongnv89
  version: "1.0"
---

## Activation Contract

Apply this skill when the user wants to:
- Re-skin or apply a premium design system to a project
- Use a design inspired by Stripe, Linear, Apple, Vercel, Notion, etc.
- Get an "Editorial Dark" cinematic look
- See what design systems are available as JSON
- Apply a brand's design language (colors, typography, spacing, components)

## What Is Sleek UI

Sleek UI is a catalog of 55+ brand-quality UI design systems packaged as JSON files. Each JSON contains colors (light + dark), typography, spacing, border radius, component styles (button, card, input), accessibility rules, font loading URLs, and agent instructions.

**Repo**: luongnv89/sleek-ui (⭐ 124)
**Base URL**: https://luongnv.com/sleek-ui/designs/{slug}.json

## How to Use

Pick a slug from the catalog below and tell the AI:

```
Fetch https://luongnv.com/sleek-ui/designs/{slug}.json
and apply this design system to my project.
```

The agent reads the JSON and applies:
1. CSS custom properties on `:root` (light) and `.dark` (dark mode)
2. `--radius` from tokens
3. Google Fonts via `<link>` tag
4. Font families, component styles for Tailwind + shadcn/ui
5. Focus states and accessibility rules

## Full Design Catalog (57 designs)

### Dev Tools
- `vercel` — Vercel dark minimal
- `linear.app` — Linear clean minimal
- `cursor` — Cursor editor
- `raycast` — Raycast productivity
- `warp` — Warp terminal
- `expo` — Expo mobile
- `sentry` — Sentry monitoring
- `supabase` — Supabase database
- `posthog` — PostHog analytics
- `sanity` — Sanity CMS
- `clickhouse` — Clickhouse database
- `opencode.ai` — OpenCode AI

### AI Products
- `claude` — Claude AI (Anthropic)
- `cohere` — Cohere AI
- `mistral.ai` — Mistral AI
- `ollama` — Ollama local AI
- `replicate` — Replicate
- `minimax` — MiniMax AI
- `elevenlabs` — ElevenLabs voice
- `runwayml` — Runway ML video
- `together.ai` — Together AI
- `lovable` — Lovable AI dev
- `composio` — Composio tooling
- `voltagent` — Voltagent AI
- `x.ai` — xAI Grok

### SaaS & Productivity
- `stripe` — Stripe payments
- `notion` — Notion workspace
- `intercom` — Intercom support
- `resend` — Resend email
- `webflow` — Webflow design
- `figma` — Figma design tool
- `framer` — Framer websites
- `miro` — Miro whiteboard
- `airtable` — Airtable database
- `cal` — Cal scheduling
- `mintlify` — Mintlify docs
- `zapier` — Zapier automation
- `superhuman` — Superhuman email
- `clay` — Clay data enrichment

### Enterprise & Fintech
- `apple` — Apple design language
- `ibm` — IBM Carbon
- `bmw` — BMW automotive
- `coinbase` — Coinbase crypto
- `kraken` — Kraken exchange
- `revolut` — Revolut fintech
- `wise` — Wise transfers
- `mongodb` — MongoDB database
- `hashicorp` — HashiCorp cloud
- `nvidia` — NVIDIA AI
- `uber` — Uber mobility
- `spacex` — SpaceX aerospace
- `spotify` — Spotify music
- `pinterest` — Pinterest discovery
- `airbnb` — Airbnb travel

### Original Designs
- `editorial-dark` — **Cinematic, dark editorial** (matches the cinematic taste)
- `deep-ocean` — Deep ocean blue
- `neo-brutalist` — Bold neo-brutalist
- `swiss-clean` — Swiss International Typographic Style
- `warm-saas` — Warm SaaS light

## Recommended for Cinematic Taste

**`editorial-dark`** is the closest to the cinematic/A24 editorial aesthetic. Dark background, restrained palette, typography-driven.

**`apple`** gives the Apple clean premium look.

**`linear.app`** gives the dark minimal developer tool aesthetic.

**`swiss-clean`** gives the Swiss typographic editorial style.
