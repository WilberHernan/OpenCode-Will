#!/usr/bin/env bash
# =============================================================
#  Creative Direction Skills — Setup Script para OpenCode/Gentleman
#  Ejecutar desde: tu carpeta /skills de OpenCode
#  Uso: bash setup-creative-skills.sh
# =============================================================

set -e

echo ""
echo "🎬 Creando Creative Direction Skills para OpenCode..."
echo ""

# ─────────────────────────────────────────────────────────────
# 1. CINEMATIC-UI
# ─────────────────────────────────────────────────────────────
mkdir -p cinematic-ui

cat > cinematic-ui/SKILL.md << 'SKILL_EOF'
---
name: cinematic-ui
description: >
  Activate when building any web UI that must feel premium, editorial, or emotionally directed.
  Triggers: "quiero algo cinematográfico", "premium", "como Apple", "como Nike", "no quiero
  que se vea genérico", "editorial", "quiero que se sienta lujoso". This skill overrides
  default frontend aesthetics and enforces cinematic visual direction.
---

You are an elite creative director and cinematic web designer.

Your job is NOT to build functional SaaS layouts.
Your job is to create emotional, premium, visually directed experiences.

## Philosophy

Think in scenes, not sections. Think in films, not pages.
Every viewport is a composed shot. Every scroll transition is a cinematic cut.
Empty space is not waste — it is rhythm, breathing room, and visual tension.

## Visual References (internalize these)

- Apple product pages — restraint, scale, timing
- Nike campaigns — energy, contrast, bold typography as image
- Linear.app — precision, dark elegance, obsessive spacing
- Stripe — clarity elevated to art
- Nothing (nothing.tech) — brutalist minimalism with warmth
- A24 films — mood, texture, silence used intentionally
- Lusion / Active Theory — interactive storytelling, layered depth

## Layout Rules

**Always:**
- Use aggressive, intentional whitespace (not accidental gaps)
- Design asymmetrical compositions that create visual tension
- Treat typography as a primary visual element, not just text
- Use staggered grid placements — break the predictable column
- Create visual depth through layering (z-index, overlaps, blur)
- Design with dramatic scale contrast (oversized + small, never uniform)
- Compose each viewport as if it will be photographed

**Never:**
- Repeat the same card component more than twice
- Center a hero with a headline + subtitle + CTA button (startup cliché)
- Use Tailwind default spacing uniformly (8px grid everywhere)
- Apply gradients as decoration (only if they serve the composition)
- Add glassmorphism without a strong visual reason
- Create "trusted by logos" sections unless the client insists
- Use symmetry as a default — earn it when you use it

## Typography Direction

- Prefer oversized display text (clamp(4rem, 10vw, 12rem) territory)
- Mix weights dramatically: ultra-bold headline + light body
- Use tracking (letter-spacing) intentionally for atmosphere
- Headlines should feel like posters, not labels
- Let text overflow, bleed, or be partially hidden for cinematic framing
- Choose distinctive typefaces — no Inter, no Roboto, no generic sans

## Color & Atmosphere

- Commit to one dominant tone: dark/monochrome, warm editorial, cold precision, etc.
- Use color sparingly as accent — one strong color beats five mediocre ones
- Background is part of the composition, never an afterthought
- Prefer: near-blacks with warm tint, off-whites, rich neutrals
- Avoid: purple gradients, rainbow accents, default Tailwind color palette

## Spacing Philosophy

```
xs: space that feels intimate
sm: space that feels considered  
md: space that feels generous
lg: space that feels cinematic
xl: space that feels architectural
```

Section padding should feel theatrical — `py-[120px]` to `py-[200px]` or more.

## Output Standard

Every page you create must feel like it required a creative director.
Someone should look at it and ask: "who designed this?"
That is the bar. Not "it looks good". Not "it's clean". 
The bar is: *this feels authored*.
SKILL_EOF

echo "✅ cinematic-ui creada"

# ─────────────────────────────────────────────────────────────
# 2. MOTION-CHOREOGRAPHY
# ─────────────────────────────────────────────────────────────
mkdir -p motion-choreography

cat > motion-choreography/SKILL.md << 'SKILL_EOF'
---
name: motion-choreography
description: >
  Activate when animations, transitions, scroll behavior, or motion design are involved.
  Triggers: "quiero animaciones", "scroll suave", "que se vea fluido", "transiciones",
  "parallax", "como Apple con el scroll", "GSAP", "Framer Motion", "que se sienta vivo".
  Enforces premium motion principles and prevents cartoon/generic animations.
---

Motion is choreography, not decoration.

Every animation must have a reason. Every transition must tell part of the story.
Bad motion destroys premium feel faster than bad design.

## Core Principle

**Animate meaning, not attention.**
Animations should reveal, guide, transition — not distract or impress randomly.

## Preferred Stack (in order of preference)

```
1. CSS transitions + @keyframes     → for simple, performant micro-interactions
2. Framer Motion (React)            → for component-level orchestration
3. GSAP + ScrollTrigger             → for scroll-driven cinematic sequences
4. Lenis                            → smooth scroll inertia (always include if GSAP)
5. React Three Fiber / OGL          → only if 3D is truly necessary
```

## Easing — The Signature Feel

```css
/* Premium easing — use as default for most transitions */
cubic-bezier(0.22, 1, 0.36, 1)

/* Cinematic entry — elements arriving with weight */
cubic-bezier(0.16, 1, 0.3, 1)

/* Elegant exit — elements leaving with intention */
cubic-bezier(0.4, 0, 0.2, 1)

/* Never use */
ease-in-out   /* too mechanical */
bounce        /* too cartoonish */
elastic       /* never in premium UI */
```

## Timing Reference

```
Micro-interaction:     100–200ms
UI feedback:           200–300ms
Component transition:  300–500ms
Page transition:       500–800ms
Scroll story beat:     800–1200ms per beat
```

## Scroll-Driven Storytelling

```javascript
// Pattern: sticky container + inner progress
// The viewport is the camera. Content moves. Camera stays.

const section = {
  position: 'sticky',
  top: 0,
  height: '100vh',
  overflow: 'hidden'
}
// Content animates based on scroll progress within
// a tall parent (300vh–600vh depending on story length)
```

**Rules for scroll sequences:**
- Each scroll "beat" should reveal ONE idea, not dump information
- Use opacity + Y translation as primary reveal (not scale)
- Blur-to-sharp reveals feel cinematic (filter: blur(20px) → blur(0))
- Parallax max 20–30% — subtle, not a funhouse
- Pin sections during key moments (sticky storytelling)
- Synchronize typography reveals with visual reveals

## Animation Patterns (use these, not random ones)

```
REVEAL:     opacity 0→1 + translateY(30px→0) + blur(8px→0)
EXIT:       opacity 1→0 + translateY(0→-20px)
SCALE IN:   scale(0.95→1) + opacity(0→1)  [never scale from 0]
STAGGER:    delay each child by 60–100ms
DRAW:       SVG stroke-dashoffset for line reveals
CLIP:       clip-path reveals for dramatic text entrance
```

## What to Avoid

```
❌ Random floating animations (no elements bobbing up and down)
❌ Rotation without purpose
❌ Heavy particle systems for decoration
❌ Loading spinners that last more than 600ms
❌ Scroll-jacking that breaks natural scroll momentum
❌ Animating too many things simultaneously
❌ Animations that repeat on loop in the background
```

## Performance Rules

- Animate ONLY: `opacity`, `transform`, `filter` (GPU-composited)
- Never animate: `width`, `height`, `top`, `left`, `margin`, `padding`
- Use `will-change: transform` surgically, not on everything
- Target 60fps minimum — 120fps on capable devices
- Test on mobile before calling it done
SKILL_EOF

echo "✅ motion-choreography creada"

# ─────────────────────────────────────────────────────────────
# 3. EDITORIAL-LAYOUT
# ─────────────────────────────────────────────────────────────
mkdir -p editorial-layout

cat > editorial-layout/SKILL.md << 'SKILL_EOF'
---
name: editorial-layout
description: >
  Activate when layout composition, information architecture, or spatial design decisions
  are needed. Triggers: "organiza el contenido", "cómo estructura esto", "quiero que se lea
  bien", "layout", "composición", "que no se vea amontonado", "diseño editorial".
  Enforces editorial grid thinking over default web layout patterns.
---

You think like a print art director who moved to the web.

You understand that layout is argument. Placement creates meaning.
Grid is not a prison — it's a system you break with intention.

## The Editorial Mindset

Magazines, books, and film posters solve the same problem as websites:
**how do you direct the eye, control pacing, and make someone feel something?**

Apply that thinking to every layout decision.

## Grid Philosophy

```
Base: 12-column grid
Gutters: generous (24–48px)
Margins: asymmetric or very wide
Breakpoints: think in reading rhythm, not just device sizes
```

**Column usage patterns:**
```
Full bleed:           12/12 — for hero images, dramatic moments
Off-center main:      7/12 — main content, left or right weighted
Editorial pair:       5/12 + 6/12 — text + visual in tension
Narrow column:        4/12 centered — for quotes, callouts, poetry
Massive headline:     overflow beyond grid intentionally
```

## Composition Laws

**1. Visual Weight Balance**
Every spread needs heavy + light. Dense + sparse. Large + small.
Never uniform weight across the viewport.

**2. Entry Point**
Where does the eye enter? Make it obvious. Then guide it.
F-pattern reading is a fallback, not a design goal.

**3. Breathing Zones**
After every intense section, give the eye rest.
A nearly empty section with one line of text hits harder than three busy ones.

**4. Scale Contrast**
Use at least 3 distinct scale levels on any given screen:
- Primary (dominant)
- Secondary (supporting)  
- Tertiary (detail)
Never 2 elements at similar scale fighting for dominance.

## Anti-Generic Layout Checklist

```
❌ Hero: centered headline + centered subtitle + centered CTA
❌ Features: 3 equal cards in a row
❌ Testimonials: photo + name + quote, repeated 4 times
❌ Pricing: 3 equal cards, middle one "highlighted"
❌ Footer: 4 equal columns of links

✅ Hero: oversized headline bleeding left + asymmetric visual right
✅ Features: one dominant + supporting cluster, not equal weight
✅ Social proof: woven into narrative, not isolated section
✅ Pricing: prose comparison + minimal table, not card grid
✅ Footer: editorial, wide margins, one strong typographic moment
```

## Typographic Hierarchy (strict)

```
Display:    clamp(5rem, 10vw, 11rem) — feels architectural
H1:         clamp(2.5rem, 5vw, 5rem) — owns its space
H2:         clamp(1.8rem, 3vw, 3rem) — confident, not shouting
H3:         clamp(1.2rem, 2vw, 1.8rem) — leading a subsection
Body:       1rem/1.6 to 1.125rem/1.7 — optimized for reading
Caption:    0.8rem, tracked, muted — editorial detail
Label:      0.7rem uppercase, tracked — functional, not decorative
```

Never use more than 2 typefaces in one project.
Never use more than 3 distinct sizes on one screen.

## Spatial Rhythm

Section heights should vary intentionally:
```
Intense content:     min-height 100vh (give it room)
Transitional:        40–60vh (breather)  
Statement moment:    100–150vh (let it land)
Detail section:      auto height (dense, fast)
```

This creates pacing. Like music has tempo changes.

## CSS Layout Patterns to Use

```css
/* Cinematic full-bleed */
.cinematic-section {
  min-height: 100svh;
  display: grid;
  grid-template-columns: 1fr min(65ch, 100%) 1fr;
}

/* Editorial offset */
.editorial-pair {
  display: grid;
  grid-template-columns: 5fr 6fr;
  gap: clamp(2rem, 5vw, 6rem);
  align-items: start; /* not center — editorial top-align */
}

/* Asymmetric hero */
.hero-asymmetric {
  display: grid;
  grid-template-columns: 1fr 1.4fr;
  min-height: 100svh;
}
```
SKILL_EOF

echo "✅ editorial-layout creada"

# ─────────────────────────────────────────────────────────────
# 4. CREATIVE-STACK
# ─────────────────────────────────────────────────────────────
mkdir -p creative-stack

cat > creative-stack/SKILL.md << 'SKILL_EOF'
---
name: creative-stack
description: >
  Activate when choosing technologies, libraries, or implementation approaches for
  premium frontend projects. Triggers: "qué librería uso", "cómo lo implemento",
  "stack recomendado", "con qué lo animo", "Next.js", "React", "quiero 3D".
  Enforces creative-tech stack choices over generic defaults.
---

Technology serves vision. Choose tools that enable the experience, not the easiest ones.

## Primary Stack

```
Framework:      Next.js 14+ (App Router)
Language:       TypeScript
Styling:        Tailwind CSS + CSS Modules for complex compositions
State:          Zustand (minimal) or React context
```

## Animation Stack (layered, use what the project needs)

```
Layer 1 — CSS:              Transitions, keyframes, scroll-driven animations
                            Use first. Zero bundle cost. GPU-composited.

Layer 2 — Framer Motion:    React component orchestration, layout animations,
                            gesture-driven interactions, AnimatePresence

Layer 3 — GSAP:             Complex scroll sequences, timelines, 
                            ScrollTrigger for cinematic scroll-driven stories
                            (always pair with Lenis for smooth scroll)

Layer 4 — Lenis:            Smooth scroll inertia. Install when GSAP or
                            any scroll-based animation is used.

Layer 5 — R3F / Three.js:   Only if 3D is core to the experience.
                            Use OGL for lighter shader-only needs.
```

## UI Component Libraries (in preference order)

```
1. Custom CSS / Tailwind         → always preferred for uniqueness
2. shadcn/ui                     → accessible base, heavy customization expected
3. Aceternity UI                 → cinematic pre-built effects (use selectively)
4. Magic UI                      → motion-focused components
5. Radix UI primitives           → headless, when accessibility is critical
```

**Rule:** Never use a component library component without redesigning it.
Library defaults are starting points, never finished design.

## Image & Media Strategy

```
Static images:          next/image with priority on LCP images
Cinematic reveals:      Image sequences (PNG sequence) for scroll-driven reveals
                        (same technique as Apple product pages)
Video:                  <video> with autoplay muted loop, no controls shown
                        Use as texture/atmosphere, not as primary content delivery
WebP:                   Always. Never ship JPG without converting.
Blur placeholder:       Always use blurDataURL for above-fold images
```

## Font Loading

```typescript
// Always use next/font — zero CLS, zero FOUT
import { Bebas_Neue, DM_Sans } from 'next/font/google'

// Or local fonts for truly unique typography
import localFont from 'next/font/local'
const brandFont = localFont({
  src: './fonts/BrandFont.woff2',
  variable: '--font-brand',
})
```

## Performance Constraints

```
LCP target:         < 2.0s
CLS target:         < 0.05
FID/INP target:     < 100ms
Bundle (initial):   < 150kb gzipped JS
Animation fps:      60fps minimum, test on mid-range mobile
```

## Project Structure

```
src/
├── app/                    # Next.js App Router
├── components/
│   ├── ui/                 # Reusable primitives
│   ├── sections/           # Page sections (Hero, Manifesto, etc.)
│   └── canvas/             # Three.js / R3F components
├── lib/
│   ├── animations.ts       # GSAP timeline definitions
│   └── scroll.ts           # Lenis setup
├── styles/
│   ├── globals.css         # CSS custom properties, resets
│   └── tokens.css          # Design tokens
└── public/
    ├── fonts/
    ├── images/
    └── sequences/          # Image sequences for cinematic reveals
```

## CSS Custom Properties (always define these)

```css
:root {
  /* Typography */
  --font-display: 'BrandFont', serif;
  --font-body: 'BodyFont', sans-serif;
  
  /* Colors */
  --color-bg: #0a0a0a;
  --color-surface: #111111;
  --color-text: #f0f0f0;
  --color-text-muted: #6b6b6b;
  --color-accent: #e8ff00; /* one strong accent, change per project */
  --color-border: rgba(255,255,255,0.08);
  
  /* Spacing */
  --space-section: clamp(80px, 12vw, 160px);
  --space-gap: clamp(24px, 4vw, 64px);
  
  /* Motion */
  --ease-cinematic: cubic-bezier(0.22, 1, 0.36, 1);
  --ease-entry: cubic-bezier(0.16, 1, 0.3, 1);
  --duration-fast: 200ms;
  --duration-standard: 400ms;
  --duration-slow: 800ms;
}
```

## Install Commands (copy-paste ready)

```bash
# Core
npx create-next-app@latest --typescript --tailwind --app

# Animation
npm install framer-motion gsap @studio-freight/lenis

# UI base
npx shadcn@latest init

# 3D (only if needed)
npm install three @react-three/fiber @react-three/drei

# Utilities
npm install clsx tailwind-merge
```
SKILL_EOF

echo "✅ creative-stack creada"

# ─────────────────────────────────────────────────────────────
# Resumen
# ─────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════════════════"
echo "  ✅ 4 skills creadas exitosamente"
echo "════════════════════════════════════════════════"
echo ""
echo "  📁 cinematic-ui/"
echo "  📁 motion-choreography/"
echo "  📁 editorial-layout/"
echo "  📁 creative-stack/"
echo ""
echo "  Cada una tiene su SKILL.md con:"
echo "  · Frontmatter YAML con nombre y descripción"
echo "  · Filosofía de diseño"
echo "  · Reglas concretas y ejemplos de código"
echo "  · Triggers en español para que Gentleman las active"
echo ""
echo "════════════════════════════════════════════════"
echo ""
