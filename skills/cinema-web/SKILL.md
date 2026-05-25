---
name: cinema-web
description: "Trigger: cinematic web, cinema, cine, A24, editorial, matte black, noir, película, negro mate, elegante. Cinematic editorial design system — monochrome, typography-driven, premium. Filters other MCPs to this aesthetic."
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "2.1"
---

## Activation Contract

Apply this skill when the user asks for:
- "cinematográfico", "cinematic", "película", "film-like"
- "negro mate", "matte black", "elegante", "sobrio", "no color"
- "estilo Apple", "estilo Nike", "editorial", "de revista", "premium"
- "que se vea caro", "menos ruido", "minimalista con presencia"
- Typography-driven, monochrome, high-end fashion / brand feel

Do NOT apply when the user wants colorful, playful, cyberpunk, brand-colored, or casual designs.

## Hard Rules

### Color — cero color
- `--bg: #000` (fondo) | `--surface: #111` (cards/modales) | `--text: #fff` | `--text-secondary: rgba(255,255,255,0.3)` | `--text-dim: rgba(255,255,255,0.12)` | `--border: rgba(255,255,255,0.04-0.06)` | `--accent: #fff`
- Cero acentos de color. Nada de azul, rojo, dorado, verde, violeta.
- Sin gradientes de color. Fondo negro sólido. Texto blanco. That's it.
- Imágenes: blanco y negro o muy desaturadas, o con overlay negro.

### Tipografía — sagrada
- **Headings**: Playfair Display (serif, emocional, cinematográfica)
- **Body / UI**: Inter (limpia, profesional, neutra)
- No mezcles con otras fuentes. No system-ui. No sans-serif genéricas.
- Escala: títulos GRANDES (`clamp(3rem, 8vw, 5rem)+`), body chico (0.85–0.95rem), labels chicos (0.65–0.75rem).
- Uppercase SOLO en labels, nav links, metadata. Nunca en body ni títulos largos.
- Letter-spacing suelto en labels (`0.08-0.15em`), tight en títulos grandes (`-0.02-0.03em`).

### Espacio — respirar
- Padding generoso en todo. Sections: `4-6rem` vertical, `2rem` horizontal.
- Line-height: body `1.7-1.9`, headings `0.95-1.05`.
- Si dudás entre dos espaciados, usá el más grande. El lujo es espacio.
- Gap entre elementos: mínimo `1rem`, ideal `1.5-2rem`.

### Animaciones — lentas, serias, con propósito
- Timing: 400–600ms (más lento que el default de 300ms)
- Curva: `cubic-bezier(0.22, 1, 0.36, 1)` — elegante, sin bounce
- Solo animar `opacity` y `transform`. NUNCA `width/height/top/left`.
- Scroll: IntersectionObserver con `threshold: 0.15`, fade + translateY(20–30px)
- Stagger entre items: 100–200ms
- Hover: 300–400ms, solo opacity/transform, nada de escalados exagerados
- No bounce, no elastic, no "divertido". Las transiciones son serias.

### Bordes y formas
- Border-radius: 0 (ideal) o máximo 4px. Nada de 8px+ ni pill shapes.
- Sin sombras (`box-shadow: none`). Profundidad con bordes sutiles.
- Border: `1px solid rgba(255,255,255,0.04)` a `0.06`.

### Íconos
- SVG outline de un solo set: Lucide, Heroicons Outline, o Phosphor (duotone desactivado).
- Sin emoji como íconos. Sin filled icons. Sin multi-color.
- Tamaño: 16–20px para UI, 24–32px para secciones hero.

## Component Patterns

### Navbar
```
Position: fixed, top 0, z-index 100
Background: rgba(0,0,0,0.6) + backdrop-filter blur(12px)
Border-bottom: 1px solid rgba(255,255,255,0.04)
Padding: 1.2rem 2.5rem
Layout: logo (left) → spacer → nav links (right) → CTA button
Logo: Playfair Display 700, 1.3rem, color #fff
Links: Inter 500, 0.8rem, uppercase, letter-spacing 0.08em, color rgba(255,255,255,0.35)
CTA: border 1px solid rgba(255,255,255,0.15), bg transparent, color #fff, border-radius 0
Hidden on scroll down, shows on scroll up (transform translateY)
```

### Hero
```
Full viewport, centered, flex column
Label (opcional): 0.65-0.7rem, uppercase, letter-spacing 0.2-0.3em, rgba(255,255,255,0.2)
Title: Playfair Display 900, clamp(3.5rem, 10vw, 8rem), line-height 0.95, #fff
  Opcional: italic variant (font-weight 400, opacity 0.5)
Subtitle: Inter 300, 0.9-1rem, rgba(255,255,255,0.3), max-width 400-500px, line-height 1.8
Actions: flex, gap 1.2rem
  Primary CTA: bg #fff, color #000, border none, padding 1rem 3rem, uppercase, 0.8rem
  Secondary CTA: border 1px solid rgba(255,255,255,0.15), bg transparent, color rgba(255,255,255,0.6)
Scroll indicator: thin line (1px, 40px, gradient fade out), label above, centered bottom
```

### Buttons
```
Primary: bg #fff, color #000, border-radius 0, padding 1rem 3rem, font Inter 600, 
  letter-spacing 0.12em, uppercase, transition 0.4s, hover: opacity 0.85
Secondary/Outline: bg transparent, color rgba(255,255,255,0.6), border 1px solid rgba(255,255,255,0.15),
  border-radius 0, padding 1rem 3rem, font Inter 600, letter-spacing 0.12em, uppercase,
  hover: border-color rgba(255,255,255,0.4), color #fff
Text/ghost: no border, color rgba(255,255,255,0.5), hover color #fff
Nav button: smaller padding (0.5rem 1.8rem), border, same style as outline
Disabled: opacity 0.3, cursor not-allowed, no hover effects
```

### Cards
```
Surface grid: 1px gap grid (background: rgba(255,255,255,0.04) as grid lines)
Card: bg #000, padding 2.5rem 2rem
  Numbered header: 0.7rem, Playfair o Inter, rgba(255,255,255,0.15)
  Title: 1.1rem, Inter 600, #fff
  Body: 0.85rem, Inter 300, rgba(255,255,255,0.25), line-height 1.7
Hover: background rgba(255,255,255,0.02) (casi imperceptible)
No border-radius. No shadow.
```

### Forms / Inputs
```
Label: 0.7rem, Inter 500, rgba(255,255,255,0.25), uppercase, letter-spacing 0.1em
Input: bg rgba(255,255,255,0.03), border 1px solid rgba(255,255,255,0.06), 
  color #fff, padding 0.9rem 1.2rem, border-radius 0 (o 4px max)
Focus: border-color rgba(255,255,255,0.2)
Placeholder: rgba(255,255,255,0.1)
Submit: same as Primary button style
Error: rgba(255,100,100,0.7), sin background de error
```

### Modals
```
Overlay: rgba(0,0,0,0.7), backdrop-filter blur(8px)
Container: bg #111, border 1px solid rgba(255,255,255,0.06), padding 3rem 2.5rem
  Transform: scale(0.92) translateY(30px) → scale(1) translateY(0), 0.45s
Close btn: absolute top/right, color rgba(255,255,255,0.15), no border, font-size 1.2rem
Title: Playfair Display 700, 1.8rem, #fff
Tabs: border-bottom 1px solid rgba(255,255,255,0.06), active tab has border-bottom #fff
```

### Footer
```
Padding: 3rem 2rem
Text: 0.7-0.75rem, rgba(255,255,255,0.08-0.12), uppercase, letter-spacing 0.1em
Border-top: 1px solid rgba(255,255,255,0.03)
Centered. Simple. Una línea. Nada de links múltiples.
```

## Layout Patterns (no mandatory — apply as needed)

| Sección | Sugerencia |
|---------|-----------|
| Hero | Full viewport, centrado. Label + Title + Sub + CTAs + Scroll indicator |
| About/Journey | 2-col grid (desktop), 1-col (mobile). Label → Title → Body → Stats |
| Grid/Features | 1px gap grid, numbered cards, clean editorial |
| Showcase/Gallery | Full-bleed images B/W, overlay text, slide/scroll |
| CTA/Join | Centrado, título corto, subtítulo, un botón |
| Contact | Minimal form, black bg, thin borders |
| Pricing | 3-column grid, black cards, simple, sin decoración |

## Animation System

### Scroll Reveal
```javascript
// Template — apply to any element
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.style.transition = 'opacity 0.5s cubic-bezier(0.22, 1, 0.36, 1), transform 0.5s cubic-bezier(0.22, 1, 0.36, 1)';
      entry.target.style.opacity = '1';
      entry.target.style.transform = 'translateY(0)';
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.15 });
// Set initial: opacity: 0, transform: translateY(20-30px)
```

### Stagger (grid items)
```
Each item: initial opacity 0, translateY(20px)
On visible: transition with delay calc(index * 100-200ms)
```

### Page Transitions
```
If multi-page: fade 400ms between pages, no slide
If SPA sections: smooth scroll, IntersectionObserver reveals
```

### Hover States
```
Buttons: opacity change or bg change, 300-400ms
Cards: bg lighten 0.02 opacity, 400ms
Links: color increase opacity, 300ms
No scale, no lift, no shadow changes
```

## Integration With Other Skills & MCPs

When this skill is loaded alongside other design MCPs (HeroUI, 21st.dev, ui-ux-pro-max), the workflow is:

### Step 1: Generate with the MCP
Use the MCP tool normally to generate the component/page structure.

### Step 2: Filter through cinema-web tokens
Override ALL generated colors with the monochrome palette:
```diff
- primary: #6366f1 (indigo)
+ primary: #fff (white)
- bg: #fafafa
+ bg: #000
- border-radius: 12px
+ border-radius: 0
- box-shadow: 0 4px 20px ...
+ box-shadow: none
- font-family: 'Inter', sans-serif
+ font-family: 'Playfair Display', serif (headings) / 'Inter', sans-serif (body)
- animation: bounce 1s
+ animation: fade 0.5s cubic-bezier(0.22, 1, 0.36, 1)
```

### Step 3: Remove colored variants
If the MCP generates multiple color versions (primary, secondary, success, danger), keep only the monochrome version. Remove colored badges, chips, alerts.

### Step 4: Adjust spacing
Increase padding/margin by 1.5x–2x compared to what the MCP generates. The default is too tight.

### When NOT to use MCPs
For simple components (buttons, cards, navbars, footers), write custom HTML/CSS using the Component Patterns above. MCPs are useful for complex components (sliders, slideshows, tabs, complex forms, dropdowns).

## Decision Gates

| Si el usuario pide... | Usá el patrón... |
|----------------------|------------------|
| Botón / CTA | Button patterns arriba. Directo, sin MCP. |
| Navbar / Header | Navbar pattern arriba. Directo, sin MCP. |
| Footer | Footer pattern arriba. Directo, sin MCP. |
| Hero / Landing | Hero pattern + Three.js (opcional). Directo o con 21st.dev filtrado. |
| Tarjetas / Grid | Grid pattern. Directo o con HeroUI Card filtrado. |
| Formulario / Input | Form pattern. Directo o con HeroUI TextField filtrado. |
| Modal / Diálogo | Modal pattern. Directo o con HeroUI Modal filtrado. |
| Slideshow / Carrusel | 21st.dev para estructura, luego filtrar colores. HeroUI no tiene carrusel. |
| 3D / Animación de fondo | Three.js: solo esferas wireframe blancas, estrellas, geometría simple. NUNCA texturas ni colores. |
| Tabla / Datos | HeroUI Table filtrado. Sin color, sin badges de colores. |
| Pricing | Grid de 3 columnas. Sin "popular" destacado con color. Borde sutil si necesitás destacar. |
| Timeline | Lista vertical con línea al costado. Sin íconos de colores. |
| Charts | 21st.dev charts, filtrados a B/N. Sin leyendas de colores. |

## Pre-Delivery Checklist

### Must have
- [ ] Fondo negro puro #000
- [ ] Playfair Display en todos los headings
- [ ] Inter en todo el body/UI
- [ ] Cero acentos de color — ni un solo hex de color
- [ ] Border-radius 0 o máximo 4px
- [ ] Sin box-shadow
- [ ] Animaciones con cubic-bezier(0.22, 1, 0.36, 1)
- [ ] Espaciado generoso

### Should have
- [ ] Uppercase solo en labels/nav
- [ ] Letter-spacing en labels y nav
- [ ] Scroll reveal en secciones
- [ ] SVG outline icons (Lucide/Heroicons)
- [ ] Sin emoji como íconos

### Avoid
- [ ] Gradientes de color
- [ ] Sombras
- [ ] Border-radius grandes
- [ ] Animaciones rápidas o con bounce
- [ ] Colores de acento (azul, rojo, verde, etc.)
- [ ] Íconos filled o multi-color
- [ ] Texturas, patterns, backgrounds con imagen

## Output Contract

Return the page with:
- Google Fonts link (Playfair Display + Inter)
- Design system tokens aplicados consistentemente
- Solo los componentes solicitados (sin elementos no pedidos)
- Animaciones con timing y curva de esta skill
- Si usaste un MCP, listá qué filtraste

## References

- Google Fonts: `https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400`
- Lucide icons: `https://lucide.dev/icons/` — usar solo outline style
- HeroUI v3: disponible via MCP, filtrar colores con esta skill
- 21st.dev: disponible via MCP, filtrar colores con esta skill
- ui-ux-pro-max: usar para design research, pero reemplazar paleta
