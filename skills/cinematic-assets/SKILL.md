---
name: cinematic-assets
description: "Trigger: assets, imágenes, fuentes, tipografía, video, motion background, hero image, textura, PNG sequence, WebP, font loading, blur placeholder, cinematic reveal. Cinematic asset pipeline — images, fonts, video, SVG for premium editorial sites."
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Activation Contract

Apply this skill when building any premium/cinematic page that needs:
- Hero images, background textures, atmospheric visuals
- Typography with personality (variable fonts, local fonts, font-display)
- Background video loops with cinematic fade-in
- SVG icons with consistent style and accessibility
- Image sequences for scroll-driven reveals (Apple-style)

Do NOT apply for functional/data apps (dashboards, admin panels, tools).

## Hard Rules

1. **Never ship unoptimized images.** Every `img`/`next/image` MUST specify format, size, and loading strategy.
2. **Never load fonts without `font-display`.** Blocking fonts = broken UX for 3+ seconds.
3. **Never autoplay video with audio.** Background video is `muted`, `loop`, `playsinline`. No exceptions.
4. **Never inline SVGs without `viewBox` and `aria-label`.** Missing viewBox breaks layout; missing label breaks a11y.
5. **Never use JPG/PNG directly.** Always convert to WebP (AVIF for hero images when supported).

## Decision Gates

| Asset type | Action |
|---|---|
| Hero / full-bleed image | `next/image` with `priority`, blurDataURL, WebP, overlay gradient |
| Decorative background texture | CSS background-image, WebP, preload via `<link rel=preload>` |
| Body / content image | `next/image` with `loading="lazy"`, WebP, responsive sizes |
| Heading font with personality | `next/font/google` or `next/font/local` with `display: swap`, `preload: true` |
| UI / body font | `next/font/google`, `variable: true` if available, `display: swap` |
| Background video loop | `<video>` with `muted loop playsinline poster`, CSS fade-in, lazy load |
| Icon / illustration | Inline SVG (not `<img>`), `viewBox`, `aria-label`, Lucide/Heroicons outline |
| Image sequence (scroll reveal) | PNG sequence in `/public/sequences/`, JS preload + IntersectionObserver |

## Execution Steps

1. **Classify the asset** using the Decision Gates table above.
2. **Open the matching reference** in `assets/` for exact code patterns.
3. **If generating new assets** (AI images, video), use `mcpollinations` MCP tools (`generateImage` / `generateImageUrl` / `editImage`) and follow `references/mcp-integration.md`.
4. **Always post-process** generated images: convert to WebP, create blur placeholder, resize.
5. **Verify** against the Output Contract before marking done.

## Output Contract

Every page MUST pass these checks before delivery:

- [ ] Hero images: `next/image`, `priority`, `blurDataURL`, WebP
- [ ] Decorative images: `loading="lazy"`, WebP, responsive sizes
- [ ] All images have explicit `width` and `height` (or `fill`)
- [ ] Fonts loaded via `next/font`, never via CSS `@import` or `<link>` (exception: Google Fonts CSS2 for variable axes)
- [ ] Every font has `display: swap` (exception: display fonts can use `display: block` if above-fold)
- [ ] Background video: `muted loop playsinline poster`, CSS fade-in on load
- [ ] Inline SVGs: `viewBox`, `aria-label`, currentColor for stroke/fill
- [ ] No JPG/PNG in final markup — all WebP or AVIF

## References

- `assets/image-pipeline.md` — next/image, blur, WebP, responsive images, overlay gradients
- `assets/font-loading.md` — next/font, variable fonts, local fonts, preload, size-adjust
- `assets/video-cinematic.md` — background loops, poster, lazy, fade-in, HLS
- `references/mcp-integration.md` — how to generate images/video with available MCPs

## Related Skills

When loaded alongside `cinema-web` or `creative-stack`, the asset pipeline feeds into those design systems:
- `cinema-web` provides the monochrome color tokens and typography scale
- `cinematic-assets` provides the optimized images, fonts, and video that use those tokens
