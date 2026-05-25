# MCP Integration — Generating Assets for Cinematic Sites

## Available MCP: mcpollinations

`mcpollinations` is installed and ready to use. Zero setup, no API key needed.

**Tools it provides:**
- `generateImageUrl(prompt, options)` — returns a URL to the generated image
- `generateImage(prompt, options)` — generates and saves the image locally (base64 + file)
- `editImage(imagePath, prompt)` — edit an existing image
- `generateImageFromReference(imagePath, prompt)` — generate from a reference image
- `listImageModels()` — list available models

**Models recommended for cinematic:**
| Model | Best for |
|-------|----------|
| `flux` (default) | General purpose, high quality |
| `turbo` | Faster, slightly lower quality |
| `seedream` | Photorealistic, good for textures |

**Default behavior:** saves images as PNG in the current working directory.

## Cuándo Generar vs. Usar Assets Estáticos

| Situación | Qué hacer |
|---|---|
| Hero image principal | Generar con MCP de imágenes → optimizar con `image-pipeline.md` |
| Background texture / grain | Si es abstracta, generar. Si es una textura conocida, usar asset estático. |
| Logo / branding | Asset existente. NO generar. |
| Iconos UI | Usar Lucide o Heroicons vía imports. NO generar. |
| Video background | Stock o generado → comprimir con `video-cinematic.md` |
| Fonts | NO generar con MCP. Comprar o descargar. |

## Flujo de Trabajo con MCP de Imágenes

Si tenés disponible un MCP tipo Replicate, Stability AI, o DALL-E:

### 1. Prompt para fondos/texturas cinematográficas

```
Prompt template:
"{style} background texture, {color}, {mood}, {detail}, no subject, no text, 16:9, {quality}"
```

Ejemplos concretos:
- `"matte black paper texture, subtle grain, dark mood, macro detail, no subject, no text, 16:9"`
- `"dark concrete wall, rainy atmosphere, low key, cinematic lighting, 16:9"`
- `"abstract dark oil on water, deep gray tones, macro, editorial, moody, no subject, 16:9"`
- `"smoke fog on black background, atmospheric, cinematic, no text, no subject, 16:9"`

### 2. Post-procesamiento obligatorio

Después de generar una imagen con un MCP:

1. Descargar en máxima resolución
2. Convertir a WebP (y AVIF si el MCP lo permite)
3. Redimensionar a 1920x1080 o 3840x2160 (según necesidad)
4. Crear thumbnail de 10x10px para blurDataURL
5. Ubicar en `/public/images/` con nombre semántico

### 3. Cuándo NO usar MCP de imágenes

- **Logos** — deben ser exactos, no generados
- **Fotos de producto** — deben ser reales o renders controlados
- **Fotos de personas** — generación puede crear inconsistencia (proporciones, manos)
- **Anything con texto** — los MCPs de imagen no escriben texto consistente

## Assets que Conviene Tener en Repo

```
public/
├── images/
│   ├── hero.webp             ← Hero principal
│   ├── hero-blur.webp        ← miniatura 10x10 para blurDataURL
│   └── textures/
│       ├── grain.webp        ← textura de grano
│       └── overlay-dark.webp ← overlay de vineta
├── fonts/
│   ├── Brand-Regular.woff2
│   └── Brand-Bold.woff2
└── video/
    └── hero-bg.mp4
```
