# Guía de Proceso para Escribir la Tesina
**FCFM — Maestría en Ciencia de Datos, UANL**
**Alumno:** Luis Enrique López Nerio
**Tema:** Detección de Punto de Cambio en Serie de Tiempo de Reportes de Violencia de Género en Monterrey

> Esta guía combina el orden de escritura recomendado en la práctica con los lineamientos oficiales del Manual para la Elaboración de Tesina de la M.C. Azucena Yoloxóchitl Ríos Mercado (FCFM, UANL, 2022).

---

## Principio fundamental

El orden en que **aparece** la tesina no es el orden en que se **escribe**.

Intentar escribir en orden lineal (introducción → planteamiento → ... → conclusiones) es el error más común y la causa más frecuente de estancamiento. La introducción es la primera sección del documento pero es la **última** que se escribe.

---

## Orden de escritura recomendado

```
ORDEN EN EL DOCUMENTO        ORDEN DE ESCRITURA
─────────────────────        ──────────────────
1. Introducción          ←── 6. Al final, siempre
2. Planteamiento         ←── 1. Lo primero
3. Justificación         ←── 1. Junto con planteamiento
4. Objetivos             ←── 2. Antes del marco teórico
5. Marco teórico         ←── 3. Guiado por los objetivos
6. Metodología           ←── 4. Una vez claros objetivos y teoría
7. Resultados            ←── 5. El trabajo real
8. Conclusiones          ←── 5. Junto con resultados
9. Referencias           ←── Crece en paralelo desde el inicio
10. Anexos               ←── Al final, si aplica
```

---

## Fase 1 — Planteamiento del problema y Justificación
**Estado actual:** ✅ Tienes borradores de ambas secciones

### Qué hace esta fase
Define la razón de existir de la tesina. Si no está claro aquí, todo lo demás flota sin ancla.

### Qué debe contener el Planteamiento (según el Manual FCFM)
Responder estas preguntas de forma explícita:

- ¿Cuáles son los elementos del problema: datos, situaciones y conceptos relacionados?
- ¿Cuáles son los hechos anteriores que guardan relación con el problema?
- ¿Cuál es la situación actual?
- ¿Cuál es la relevancia del problema?
- ¿Qué pasa?
- ¿Por qué estará pasando?
- ¿Cuál es el diagnóstico?
- ¿Qué puede pasar si todo continúa así?
- ¿Qué se puede hacer para evitar que pase?

### Qué debe contener la Justificación (según el Manual FCFM)
Responder el **¿Por qué?** y el **¿Para qué?** en tres dimensiones:

- **Motivos:** ¿Por qué se hace? ¿Por qué este tema y no otro?
- **Beneficios:** ¿Para qué se hace? ¿Para qué será útil socialmente o institucionalmente?
- **Factibilidad:** ¿Cómo deberá aplicarse? ¿Es viable realizarlo?

### Para tu tesina específicamente
Tu planteamiento ya tiene los elementos clave: la base de reportes al 911 del municipio de Monterrey (2017–2022), la problemática del subregistro en denuncias formales, y la necesidad de identificar patrones en la serie de tiempo. Lo que puedes reforzar es conectar explícitamente el diagnóstico con la herramienta (CPD) como solución metodológica al problema identificado.

---

## Fase 2 — Objetivos
**Estado actual:** ⚠️ Tienes dos bullets, necesitas expandirlos

### Por qué van antes del marco teórico
Los objetivos son el filtro que te dice **qué teoría incluir y qué descartar**. Sin objetivos claros, el marco teórico se convierte en un resumen interminable de todo lo que existe sobre el tema. Con objetivos definidos, incluyes exactamente lo que necesitas demostrar.

### Qué dice el Manual FCFM
> "Los objetivos expresarán lo que se pretende lograr al término de la investigación, es decir, fijarán los alcances del problema. Deben ser **concretos, evaluables, viables y relevantes**. Deben redactarse con verbos en infinitivo que se puedan evaluar, verificar y refutar."

Preguntas guía del manual:
- ¿Qué quiero hacer en la investigación?
- ¿Qué es lo que busco conocer?
- ¿A dónde quiero llegar?
- ¿Qué pregunta deseo responder?

### Estructura recomendada
**1 objetivo general** + **4 a 6 objetivos específicos**

El objetivo general resume el propósito completo en una oración.
Los objetivos específicos son los pasos concretos y medibles que en conjunto logran el general.

### Verbos recomendados para objetivos de ciencia de datos
| Para objetivos de datos | Para objetivos de análisis | Para objetivos de interpretación |
|---|---|---|
| Recopilar | Implementar | Identificar |
| Construir | Aplicar | Comparar |
| Preprocesar | Estimar | Contrastar |
| Integrar | Detectar | Interpretar |
| Caracterizar | Validar | Asociar |

### Señal de que un objetivo está bien escrito
Al final de la tesina debes poder responder con un sí o un no a cada objetivo específico. Si no puedes marcarlo como cumplido o no cumplido, está mal planteado.

---

## Fase 3 — Marco Teórico
**Estado actual:** ✅ Bien desarrollado, revisar alineación con objetivos finales

### Qué hace esta fase
Proporciona el sustento académico que separa una investigación seria de una indagación de sentido común. Demuestra que conoces el territorio conceptual y posiciona tu trabajo dentro de él.

### Qué dice el Manual FCFM
> "Se describirán brevemente las teorías, enfoques teóricos, postulados, conceptos, etc. que sustentan el abordaje. El marco conceptual incluye la descripción del estado actual de las cosas, cómo se ha abordado el problema en otras investigaciones, en otras organizaciones, en otros lugares geográficos. Qué han encontrado en investigaciones previas sobre el tema."

### Los tres bloques que necesita tu marco teórico
1. **Bloque sustantivo** — Violencia de género: definición, marco legal en México y NL, sistemas de registro (SESNSP, ENDIREH), limitaciones de los datos.
2. **Bloque metodológico** — Series de tiempo, CPD: formulación matemática, funciones de costo, PELT, métodos online vs offline, paramétrico vs no paramétrico, selección de penalización.
3. **Bloque de antecedentes** — Trabajos previos que hayan aplicado CPD a datos sociales o de salud pública. Esto muestra que tu enfoque no es arbitrario.

### Regla de oro
Solo incluye teoría que uses en la metodología o que necesites para interpretar los resultados. Si no aparece en el Capítulo 6 ni en el 7, probablemente sobra en el 5.

---

## Fase 4 — Metodología
**Estado actual:** ❌ Pendiente — es urgente

### Qué hace esta fase
Describe cómo hiciste lo que hiciste. Debe ser tan específica que alguien con los mismos datos pueda replicar exactamente tu análisis.

### Qué dice el Manual FCFM
> "La metodología supone la sistematización, es decir, la organización de los pasos a través de los cuales se ejecutará una investigación científica."

Para tu tema, la metodología es **cuantitativa**. Según el manual, los métodos cuantitativos buscan resultados numéricos que permitan establecer estadísticas, porcentajes o variaciones numéricas — exactamente lo que hace CPD.

### Estructura sugerida para tu metodología

**6.1 Fuente de datos**
- Base: Reportes al 911 por Violencia de Género, Datos Abiertos Monterrey
- Periodo: enero 2017 – septiembre 2022
- Unidad de análisis: reportes mensuales al 911 en el municipio de Monterrey
- Variable dependiente: número de reportes por periodo

**6.2 Preprocesamiento**
- Agregación temporal (¿diaria → mensual?)
- Tratamiento de valores faltantes o periodos sin reporte
- Análisis de estacionalidad y decisión sobre ajuste

**6.3 Implementación del método CPD**
- Método seleccionado y justificación (PELT, Binary Segmentation, etc.)
- Función de costo utilizada y por qué
- Librería y versión de Python (`ruptures`)
- Rango de penalización explorado

**6.4 Selección de parámetros y validación**
- Criterio formal de selección de β (BIC, elbow, etc.)
- Análisis de sensibilidad

**6.5 Contextualización**
- Línea de tiempo de eventos relevantes (Alerta de Género NL nov. 2016, COVID-19 mar. 2020, etc.)
- Criterio de asociación entre change points y eventos

### La pregunta clave para cada párrafo de metodología
*¿Podría alguien más replicar esto exactamente con esta descripción?* Si la respuesta es no, falta detalle.

---

## Fase 5 — Resultados y Conclusiones
**Estado actual:** ❌ Pendiente — el corazón de la tesina

### Resultados
Muestra qué encontraste, **sin interpretarlo todavía**. Tablas, gráficas de la serie con los change points marcados, estadísticos descriptivos por segmento. Sin opinión, sin "esto sugiere que".

Una buena gráfica de la serie con los τ marcados y los eventos contextuales anotados vale más que dos páginas de texto.

### Conclusiones (según el Manual FCFM)
> "Lo que se busca es dar una respuesta al problema planteado. Es necesario hacer una valoración de los objetivos y ver si estos se lograron o no, si se respondieron o no las interrogantes planteadas."

Estructura recomendada para las conclusiones:
1. Respuesta directa a cada objetivo específico (uno por uno)
2. Limitaciones del estudio — qué no puedes afirmar con tus datos o tu método
3. Trabajo futuro — qué haría alguien que continúe esta investigación

> Mostrar que conoces las limitaciones no te resta puntos — al contrario, demuestra madurez metodológica.

---

## Fase 6 — Introducción
**Estado actual:** ❌ Pendiente — se escribe al final

### Por qué va al final
La introducción es un resumen de todo lo que **ya sabes** que encontraste. Si la escribes primero, la reescribirás tres veces. Escrita al final, tarda una tarde.

### Qué dice el Manual FCFM
> "Consiste en una descripción clara y concisa del problema que se investigó. Se trata de explicar, **en menos de tres páginas**, bajo qué circunstancias se decidió y se realizó la investigación, qué se ha pretendido demostrar o alcanzar y cómo se ha estructurado el contenido de la tesina."

### Lineamientos del manual que debes cumplir
- Redacción impecable en gramática, sintaxis y ortografía
- No usar ejemplos
- Usar verbos en infinitivo
- **No adelantar el resultado final** de la investigación
- **No incluir gráficos**
- Máximo 3 páginas
- Señalar los objetivos a alcanzar
- Explicar por qué fue elegido este tema

---

## Las referencias crecen en paralelo

Las referencias no son una fase — son un proceso continuo. Cada vez que cites algo en cualquier capítulo, agrégalo inmediatamente a tu lista de referencias en formato APA 7.

### Qué dice el Manual FCFM
> "Presentar en forma de listado y por orden alfabético. La norma de citación es APA 7ª edición."

### Herramientas recomendadas
- **Zotero** (gratuito) — gestor de referencias que genera automáticamente APA 7
- **Google Scholar** — tiene botón "Citar" con formato APA listo para copiar
- Mantener un archivo `referencias.bib` en el repositorio si usas LaTeX o Obsidian

---

## Requisitos formales del Manual FCFM que no debes olvidar

| Requisito | Especificación |
|---|---|
| Extensión mínima | 50 cuartillas |
| Tipografía | Arial, negro, tamaño 12 |
| Interlineado | 1.5 |
| Tamaño de hoja | Carta |
| Márgenes | Superior/inferior 2.5 cm · Izquierdo/derecho 3.0 cm |
| Numeración | Esquina inferior derecha, números arábigos |
| Norma de citas | APA 7ª edición |
| Portada | Con logotipo UANL, nombre, facultad, grado, lugar y fecha |

---

## Checklist de avance

### Fase 1 — Planteamiento y Justificación
- [x] Borrador del planteamiento del problema
- [x] Borrador de la justificación
- [ ] Revisar que el planteamiento responde las 9 preguntas guía del manual
- [ ] Revisar que la justificación cubre motivos, beneficios y factibilidad

### Fase 2 — Objetivos
- [x] Dos objetivos en borrador
- [ ] Redactar objetivo general (1)
- [ ] Redactar objetivos específicos (4–6)
- [ ] Verificar que cada objetivo usa verbo en infinitivo
- [ ] Verificar que cada objetivo es evaluable al final

### Fase 3 — Marco Teórico
- [x] Sección de VG con definición ONU y LGAMVLV
- [x] Sección de indicadores y fuentes estadísticas
- [x] Sección CPD con formulación matemática
- [x] Online vs offline, supervisado vs no supervisado, paramétrico vs no paramétrico
- [ ] Agregar bloque de antecedentes (CPD aplicado a datos sociales)
- [ ] Revisar alineación con objetivos finales
- [ ] Completar bibliografía de la sección 4.1

### Fase 4 — Metodología
- [ ] Descripción de la fuente de datos
- [ ] Preprocesamiento
- [ ] Implementación CPD
- [ ] Selección de parámetros
- [ ] Contextualización / línea de tiempo de eventos

### Fase 5 — Resultados y Conclusiones
- [ ] Análisis exploratorio de la serie
- [ ] Aplicación del método CPD
- [ ] Gráficas con change points marcados
- [ ] Tabla de τ detectados con fechas
- [ ] Interpretación contextual
- [ ] Respuesta a cada objetivo específico
- [ ] Limitaciones del estudio
- [ ] Trabajo futuro

### Fase 6 — Introducción
- [ ] Redactar introducción (máx. 3 páginas, sin gráficos, sin resultados adelantados)

### Elementos formales
- [ ] Portada completa con todos los elementos UANL
- [ ] Índice con números de página
- [ ] Dedicatoria
- [ ] Agradecimientos
- [ ] Índice de figuras
- [ ] Índice de tablas
- [ ] Referencias en APA 7, orden alfabético
- [ ] Verificar mínimo 50 cuartillas
- [ ] Revisar tipografía Arial 12, interlineado 1.5, márgenes correctos

---

## Lo que te estancó — diagnóstico

El Capítulo 5 (Marco Teórico) está desarrollado pero los Capítulos 6 y 7 están vacíos. Eso indica que el marco teórico se escribió **sin tener objetivos específicos suficientemente claros**. Sin objetivos concretos no sabías exactamente qué método justificar en la metodología ni qué demostrar en los resultados.

El marco teórico sin objetivos es como construir una sala sin saber cuántos cuartos tiene la casa.

---

## Próximo paso recomendado

**Esta semana:** Reescribir los objetivos — 1 general y 5 específicos.
Con la fuente de datos ya definida (reportes 911, Monterrey, 2017–2022) y el método ya estudiado (CPD / PELT), los objetivos se pueden redactar en una sola sesión de trabajo.

Con los objetivos listos, la metodología se escribe en una sentada.
Con la metodología lista, los resultados son solo ejecutar lo que ya describiste.

---

*Guía elaborada con base en: Manual para la Elaboración de Tesina, M.C. Azucena Yoloxóchitl Ríos Mercado, FCFM-UANL, junio 2022.*
*Última actualización: mayo 2026*
