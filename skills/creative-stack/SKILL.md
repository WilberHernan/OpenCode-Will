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
