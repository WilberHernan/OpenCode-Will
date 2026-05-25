# Video Cinematic — Asset Pipeline

## Background Video Loop

El patrón para fondos de video atmosféricos (hero sections, landing pages):

```tsx
"use client"

import { useRef, useState, useEffect } from "react"

export function CinematicVideo({ src, poster }: { src: string; poster: string }) {
  const videoRef = useRef<HTMLVideoElement>(null)
  const [loaded, setLoaded] = useState(false)

  useEffect(() => {
    const video = videoRef.current
    if (!video) return

    const onCanPlay = () => setLoaded(true)
    video.addEventListener("canplay", onCanPlay)
    // Fallback: si el video ya está cargado
    if (video.readyState >= 3) setLoaded(true)

    return () => video.removeEventListener("canplay", onCanPlay)
  }, [])

  return (
    <div className="absolute inset-0 overflow-hidden">
      <video
        ref={videoRef}
        src={src}
        poster={poster}
        muted
        loop
        playsinline
        preload="auto"
        className={`
          absolute inset-0 w-full h-full object-cover
          transition-opacity duration-700 ease-out
          ${loaded ? "opacity-100" : "opacity-0"}
        `}
      />
      {/* Overlay para legibilidad del contenido */}
      <div className="absolute inset-0 bg-black/40" />
    </div>
  )
}
```

**Atributos obligatorios:**
| Atributo | Razón |
|---|---|
| `muted` | Sin audio. Los browsers bloquean autoplay con audio. |
| `loop` | Se repite infinito — es fondo, no contenido. |
| `playsinline` | iOS lo necesita para autoplay. Sin esto no funciona en Safari. |
| `poster` | Frame estático que se muestra mientras carga. Crítico. |
| `preload="auto"` | Para hero background querés que cargue rápido. |

**Overlay**: siempre un `bg-black/40` como mínimo para que el texto sea legible. Ajustá la opacidad según el contenido (más oscuro si hay texto encima, más claro si es puramente decorativo).

## Poster Frame — Cómo generarlo

El poster es el frame que se ve mientras el video carga o en dispositivos lentos.

**Reglas:**
- Mismo aspect ratio que el video.
- Formato: WebP (liviano) o JPG al 80%.
- La imagen debe verse BIEN sola — puede que el video nunca cargue.
- Nombrarlo como `{video-name}-poster.webp`.

## Lazy Loading — Video fuera del viewport

Para videos que NO están en el hero (abajo del fold):

```tsx
"use client"

import { useRef, useState, useEffect } from "react"

export function LazyVideo({ src, poster }: { src: string; poster: string }) {
  const containerRef = useRef<HTMLDivElement>(null)
  const [shouldLoad, setShouldLoad] = useState(false)

  useEffect(() => {
    const el = containerRef.current
    if (!el) return

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setShouldLoad(true)
          observer.unobserve(el)
        }
      },
      { rootMargin: "200px" } // empieza a cargar 200px antes de aparecer
    )

    observer.observe(el)
    return () => observer.disconnect()
  }, [])

  return (
    <div ref={containerRef} className="relative aspect-video">
      {shouldLoad ? (
        <VideoPlayer src={src} poster={poster} />
      ) : (
        <img src={poster} alt="" className="object-cover w-full h-full" />
      )}
    </div>
  )
}
```

## Performance Checklist para Video

- [ ] `muted loop playsinline poster`
- [ ] Poster existe y es WebP
- [ ] CSS fade-in (opacity 0 → 1 con 600-700ms)
- [ ] Overlay black para legibilidad
- [ ] Video comprimido: H.264 (MP4) + WebM (VP9) para browsers modernos
- [ ] Duración ideal: 10–20 segundos (loop invisible)
- [ ] Tamaño ideal: < 5MB para hero, < 2MB para secundarios
- [ ] Formato: 16:9 o 21:9 para hero, vertical (9:16) para mobile-first

## Formato y Comandos de Compresión

```bash
# H.264 — máxima compatibilidad
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -preset slow -an -movflags +faststart output.mp4

# WebM (VP9) — mejor compresión, Chrome/Firefox
ffmpeg -i input.mp4 -c:v libvpx-vp9 -crf 30 -b:v 0 -an output.webm

# Generar poster frame
ffmpeg -i input.mp4 -vframes 1 -vf "scale=1920:1080" poster.webp
```
