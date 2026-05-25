# Font Loading — Cinematic Assets

## Regla de Oro

**SIEMPRE** con `next/font`. Nunca `<link>` ni `@import` en CSS.
next/font optimiza: preload, subset, display, fallback automático.

## Google Fonts — next/font/google

```tsx
import { Playfair_Display, Inter } from "next/font/google"

const playfair = Playfair_Display({
  subsets: ["latin"],
  variable: "--font-display",
  display: "swap",       // body: swap. display: "block" para hero si es crítico
  preload: true,          // default true
})

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-body",
  display: "swap",
})
```

## Variable Fonts — un solo archivo, múltiples pesos

```tsx
import { Inter } from "next/font/google"

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-body",
  axes: ["slnt"], // ejes variables extra (opcional)
})
```

**Beneficio:** un archivo `.woff2` con todos los pesos (300–900) en vez de 7 archivos separados.

## Local Fonts — tipografía única

Cuando tengas una fuente premium (bought, custom, brand):

```tsx
import localFont from "next/font/local"

const brandFont = localFont({
  src: [
    {
      path: "../public/fonts/Brand-Thin.woff2",
      weight: "100",
      style: "normal",
    },
    {
      path: "../public/fonts/Brand-Regular.woff2",
      weight: "400",
      style: "normal",
    },
    {
      path: "../public/fonts/Brand-Bold.woff2",
      weight: "700",
      style: "normal",
    },
    {
      path: "../public/fonts/Brand-Italic.woff2",
      weight: "400",
      style: "italic",
    },
  ],
  variable: "--font-brand",
  display: "swap",
  preload: true,          // pre-carga SOLO los pesos usados above-fold
})
```

**Estructura de archivos esperada:**
```
public/fonts/
├── Brand-Thin.woff2
├── Brand-Regular.woff2
├── Brand-Bold.woff2
└── Brand-Italic.woff2
```

## CSS Custom Properties + Tailwind

```tsx
// En el layout:
<html className={`${playfair.variable} ${inter.variable}`}>

// En tailwind.config:
fonts: {
  display: ["var(--font-display)", "serif"],
  body: ["var(--font-body)", "sans-serif"],
}

// Uso en componentes:
<h1 className="font-display">Título</h1>
<p className="font-body">Texto</p>
```

## font-display Estrategia

| font-display | Cuándo usarlo |
|---|---|
| `swap` | **Default.** Body text, UI, todo lo que no sea hero |
| `block` | Solo para display fonts above-fold (el texto es invisible hasta que carga la fuente — ideal para hero titles donde swap causa flash de fallback poco estético) |
| `optional` | Casi nunca. Solo si la fuente es decorativa y su ausencia no afecta la experiencia |

**Regla práctica:** usá `swap` siempre. Si ves FOUT (flash of unstyled text) feo en el hero title, cambiá ese específico a `block` con `preload: true`.

## Size-adjust — evitar CLS

Cuando cargás una fuente nueva, el navegador cambia el tamaño del texto al cargar — eso es CLS.

`next/font` maneja size-adjust automáticamente para Google Fonts. Para fonts locales, ajustá manualmente:

```tsx
const brandFont = localFont({
  src: "./Brand.woff2",
  // Ajustá hasta que el texto NO se mueva al cargar
  // Probá con swap en devtools lento 3G
  sizeAdjust: "95%",
})
```

## Preload Estratégico

next/font ya pre-carga las fuentes indicadas con `preload: true`. Solo pre-cargá **los pesos que están above-fold**.

Para referenciar una fuente desde CSS (no next/font, NO recomendado pero a veces necesario):

```tsx
<Head>
  <link
    rel="preload"
    href="/fonts/Brand-Bold.woff2"
    as="font"
    type="font/woff2"
    crossOrigin="anonymous"
  />
</Head>
```
