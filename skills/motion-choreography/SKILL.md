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
