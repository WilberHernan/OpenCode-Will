---
name: cinemorph
description: "Trigger: cinemorph, cinematic launch film, pitch deck, morph transitions, video generation, FLIP animation, product film. Generate cinematic launch videos and pitch decks from a brief — Claude Code plugin."
license: Apache-2.0
metadata:
  author: gentleman-programming, LucasDuys
  version: "1.0"
---

## Activation Contract

Apply this skill when the user wants to:
- Generate a cinematic launch video or product film
- Create an investor pitch deck with morph transitions
- Make a feature walkthrough video
- Export a deck as MP4 or PPTX with morph transitions
- Use FLIP (Framer Motion LayoutGroup + layoutId) animations

## What Is Cinemorph

Cinemorph is a **Claude Code plugin** (NOT an OpenCode MCP) that turns a brief into a cinematic launch video, investor pitch deck, or feature walkthrough. It uses Framer Motion's shared-layout FLIP transitions for smooth morphing between stages.

**Repo**: LucasDuys/cinemorph (⭐ 8, MIT)
**Site**: https://lucasduys.github.io/cinemorph/

## What It Produces

| Output | Description |
|--------|-------------|
| **Live React deck** | Vite dev server, hot reload, `?dev=1` timeline scrubber |
| **MP4 (Playwright + ffmpeg)** | 30s–5min cinematic film, audio bus, voiceover, SFX, smear cuts |
| **PPTX with native Morph** | Editable PowerPoint with Microsoft Morph transitions |

## How to Use (in Claude Code)

```bash
# 1. Install the plugin
git clone https://github.com/LucasDuys/cinemorph.git
cp -r cinemorph/plugin ~/.claude/plugins/cinemorph

# 2. Restart Claude Code, then in a chat:
/cinemorph new --from-example launch-cinematic-30s --out my-launch-video

# 3. Run it
cd my-launch-video
bun install && bun run dev   # → http://localhost:5173
```

### Key Commands

| Command | What it does |
|---------|-------------|
| `/cinemorph new "<brief>"` | Generate a fresh deck from a brief |
| `/cinemorph iterate "<change>"` | Modify active deck |
| `/cinemorph render` | Open live deck |
| `/cinemorph video` | Export to MP4 |
| `/cinemorph pptx` | Export to PPTX with Morph |
| `/cinemorph export --all` | Run all exports |

### Flags for new

- `--from-example <name>` — Start from a bundled example
- `--theme <name>` — stacklink-dark / bunq-mint-light / linear-light / minimal-mono / playful-poster
- `--tokens <path>` — Load custom tokens.json
- `--reference <image>` — Extract palette from screenshot
- `--prompt "<text>"` — Free-form brief
- `--out <path>` — Output directory

### Bundled Examples

| Example | Description |
|---------|-------------|
| `launch-cinematic-30s` | Canonical 30s product film |
| `stacklink-roundone-pitch` | 5-slide investor pitch |
| `pitch-5slide` | Generic investor deck |
| `feature-demo` | Feature walkthrough |
| `kpi-dashboard-tour` | Live-data dashboard |
| `case-study` | Customer success story |
| `manifesto` | Vision statement deck |
| `team-intro` | Team introduction |
| `release-notes` | Release notes deck |
| `roadmap` | Quarterly roadmap |
| `retro-storyboard` | Retrospective storyboard |

## Cinematic Principles

- One master RAF clock, non-overlapping phase windows, 350ms cross-fade smear cuts
- `aeBounce` easing for weighted landings (Dan Ebberts' AE bounce)
- Audio bus: music 0.20-0.25, ducks to 0.05-0.08 under VO
- Volume hierarchy: music < whooshes < POPs < VO
- Dev scrubber on `?dev=1` for timestamp feedback

## Themes

| Theme | Mood |
|-------|------|
| `stacklink-dark` | Near-black, monochromatic, restraint |
| `bunq-mint-light` | Mint + white, fintech, modern |
| `linear-light` | Slate + blue, minimal, technical |
| `minimal-mono` | B&W + grays, typographic, editorial |
| `playful-poster` | Vibrant, creative, event-driven |
