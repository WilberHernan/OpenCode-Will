# Image Pipeline — Cinematic Assets

## next/image — Hero / Full-bleed

```tsx
import Image from "next/image"

// Hero — priority, blur, WebP
<Image
  src="/images/hero.webp"
  alt="Descripción cinematográfica"
  fill
  priority
  className="object-cover"
  sizes="100vw"
  placeholder="blur"
  blurDataURL="data:image/webp;base64,..." // 10x10px miniatura
/>
```

**Reglas:**
- `priority` SOLO en hero / LCP. El resto `loading="lazy"`.
- `fill` + `className="object-cover"` para full-bleed. `object-contain` para producto.
- `sizes` SIEMPRE explícito: `"100vw"` para hero, `"(max-width: 768px) 100vw, 50vw"` para grids.
- `placeholder="blur"` siempre que haya `blurDataURL`.

## Overlay Gradients — Texto sobre imagen

```tsx
<div className="relative">
  <Image src="/hero.webp" alt="" fill className="object-cover" priority />
  {/* Overlay: negro abajo → transparente arriba */}
  <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/30 to-transparent" />
  {/* Contenido */}
  <div className="absolute bottom-0 left-0 p-8 z-10">
    <h1 className="text-white">Título</h1>
  </div>
</div>
```

Patterns de overlay para cine:
| Efecto | Clase |
|--------|-------|
| Vignette (esquinas oscuras) | `bg-radial-[circle_at_center]_black/40_transparent_70%` |
| Bottom fade (texto legible) | `bg-gradient-to-t from-black/80 via-black/20 to-transparent` |
| Darken total | `bg-black/40` + imagen en B/N vía CSS (`filter: grayscale(100%)`) |
| Split (mitad imagen, mitad texto) | `bg-gradient-to-r from-black/60 50% transparent 50%` |

## WebP / AVIF — Build-time

**En Next.js:** ya viene configurado en `next.config.js`. Verificá que esté activo:

```js
// next.config.js
module.exports = {
  images: {
    formats: ["image/avif", "image/webp"],
  },
}
```

**En Vite / sin Next.js:** usá `imagemin` con los plugins correspondientes en el build.

## Responsive Images — sizes bien

```tsx
// Grid de 3 columnas desktop, 1 columna mobile
<Image
  src="/product.webp"
  alt=""
  fill
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 33vw, 25vw"
  className="object-cover"
/>
```

## BlurDataURL — placeholder automático

```tsx
// next/blur — genera el base64 en build time
// O manual: reducí la imagen a 10x10px, exportá como WebP base64

// Ejemplo manual:
const shimmer = (w: number, h: number) => `
<svg width="${w}" height="${h}" xmlns="http://www.w3.org/2000/svg">
  <rect width="100%" height="100%" fill="#111"/>
</svg>`

const toBase64 = (str: string) =>
  typeof window === "undefined"
    ? Buffer.from(str).toString("base64")
    : window.btoa(str)

// Uso:
blurDataURL={`data:image/svg+xml;base64,${toBase64(shimmer(10, 10))}`}
```

## CSS Background Image — Decorativo

Para imágenes decorativas (no content):

```tsx
// No uses next/image — usá CSS
<section
  className="bg-[url('/textures/grain.webp')] bg-repeat bg-[length:200px]"
  // O para full-bleed:
  // bg-[url('/hero-bg.webp')] bg-cover bg-center
/>
```

Si la textura es crítica para el diseño (above-fold), pre-cargala:

```tsx
<Head>
  <link rel="preload" href="/textures/grain.webp" as="image" type="image/webp" />
</Head>
```
