# 🎬 El Tanque Blindado

OpenCode preparado y armado hasta los dientes. Nada de instalación a los ponchazos — todo ordenado, todo documentado, todo listo para que llegues a cualquier máquina y en una hora estés codeando como si nunca te hubieras movido.

## ¿Qué es esto?

Una configuración portátil de OpenCode que incluye:

- **11 agentes** de inteligencia artificial especializados
- **8 MCPs** (herramientas que los agentes pueden usar)
- **35 skills** (instrucciones detalladas para tareas específicas)
- **Setup automático** — decís "setup this machine" y el AI lo instala todo

## ¿Qué se instala y para qué sirve?

### 🧠 Los Agentes

Son IAs especializadas. No tenés que hacer nada — el orquestador (`gentle-orchestrator`) decide cuál usar según lo que necesites.

| Qué hace | Quién lo hace |
|----------|---------------|
| Coordina todo, delega trabajo, no se llena de contexto al pedo | **orchestrator** |
| Investiga ideas antes de arrancar | **sdd-explore** |
| Redacta propuestas y alcance | **sdd-propose** |
| Escribe especificaciones detalladas | **sdd-spec** |
| Diseña la arquitectura técnica | **sdd-design** |
| Divide el trabajo en tareas concretas | **sdd-tasks** |
| Implementa el código | **sdd-apply** |
| Verifica que todo funcione | **sdd-verify** |
| Archiva el cambio cuando termina | **sdd-archive** |
| Te da un tour guiado la primera vez | **sdd-onboard** |
| Prepara el proyecto para arrancar | **sdd-init** |

### 🔧 Las Herramientas (MCPs)

Son como **cajas de herramientas** que los agentes tienen disponibles. No se usan solas — el agente decide cuándo usarlas según lo que le pidás.

#### 🛡️ codedev-mcp — El que revisa el código
29 herramientas de análisis. Escanea seguridad, busca código muerto, mide complejidad, revisa dependencias. Todo local, cero APIs externas. Es como tener un code review automático antes de cada commit.

#### 🎨 ui-architect-mcp — El que genera páginas completas
16 herramientas que arman páginas enteras desde una descripción. Le decís "landing para fintech" y te genera el HTML/React/Next.js con imágenes reales de Unsplash/Pexels, animaciones, SEO audit, y consistencia de diseño. Esto no edita páginas existentes — genera nuevas, y vos tomás lo que te sirva.

#### 📚 context7 — El que tiene los docs actualizados
Cuando necesitás saber cómo se usa una librería, este MCP busca la documentación más actualizada y te la trae. Sin tener que ir a Google.

#### 🧠 engram — La memoria que no se borra
Todo lo que hablamos, decidimos y descubrimos queda guardado. Cambiás de sesión? No importa. Se comprime el contexto? Tampoco. Engram recuerda.

#### ✨ magic (21st.dev) — Componentes UI al instante
Necesitás un hero section? Un pricing table? Un modal? Le pedís y te genera el componente con el look que ya tiene tu proyecto.

#### 🎭 threejs — Escenas 3D
Para cuando querés algo visualmente impactante en el navegador. Un fondo 3D sutil, un logo que rota, una visualización interactiva.

#### 🎴 heroui — Componentes accesibles
Botones, cards, tabs, formularios, modales — todo con accesibilidad incorporada y estética moderna.

#### 🖼️ mcpollinations — Imágenes generadas al vuelo
Necesitás una textura de fondo, una imagen para un placeholder, una ilustración? La genera sin salir del editor, sin API key.

### 📋 Las Skills (Instrucciones para el AI)

Son más de 35 guías detalladas que le dicen al agente **cómo** hacer cada cosa. Algunas importantes:

| Skill | Para qué sirve |
|-------|----------------|
| **sleek-ui** | 55+ sistemas de diseño premium (Editorial Dark, Apple, Stripe, Linear, Vercel, Ferrari…) — aplicás el look con un solo prompt |
| **cinematic-ui** | Estética cinematográfica oscura, tipográfica, premium |
| **cinema-web** | Sistema de diseño editorial monocromático |
| **editorial-layout** | Composición espacial tipo revista |
| **motion-choreography** | Animaciones suaves y profesionales |
| **typescript** | TypeScript estricto, sin errores boludos |
| **react-19** | React moderno sin useMemo/useCallback al pedo |
| **tailwind-4** | Tailwind CSS v4, clases limpias |
| **judgment-day** | Revisión ciega de código en dos pasadas |
| **work-unit-commits** | Commits ordenados que tienen sentido en el historial |
| **cognitive-doc-design** | Documentación que no rompe la cabeza |

### 🎬 ¿Cómo fluye todo?

**Escenario: una landing nueva**

1. Decís: *"che, quiero hacer una landing estilo A24 para un proyecto"*
2. El **orquestador** arranca SDD: propuesta → specs → diseño → tareas
3. Consulta **sleek-ui** para el design system (Editorial Dark)
4. **ui-architect-mcp** genera las secciones con imágenes reales y animaciones
5. **magic** + **heroui** completan componentes faltantes
6. **mcpollinations** genera texturas de fondo si hace falta
7. **codedev** revisa seguridad y calidad antes del PR
8. **sdd-verify** confirma que todo cumple

**Escenario: ya tengo una página y quiero mejorarla**

1. Decís: *"dale un look más premium a esta landing"*
2. El agente lee tu código actual
3. Consulta **sleek-ui** con el estilo que elijas
4. Genera los nuevos estilos y componentes
5. **codedev** revisa que no haya roto nada
6. Aplica los cambios

## ¿Cuánto pesa?

- **~260 líneas** de configuración
- **52 archivos** de skills (livianos, son texto)
- **8 MCPs** que solo se activan cuando se usan

Comparado con los 326 archivos de relleno que sacamos al principio, esto es un lujo.

## Setup en máquina nueva

1. Instalá git (`winget install git`)
2. Abrí PowerShell NUEVO
3. `irm get.scoop.sh | iex`
4. `scoop install opencode`
5. `git clone https://github.com/WilberHernan/OpenCode-Will.git "$env:USERPROFILE\.config\opencode"`
6. Abrí OpenCode
7. Decí: **"setup this machine"**

El AI hace el resto solo.

## Disclaimer

Esto es mi configuración personal. No hay dos tanques iguales — cada uno arma el suyo. Acá está el mío: probado, ajustado, y listo para romper.
