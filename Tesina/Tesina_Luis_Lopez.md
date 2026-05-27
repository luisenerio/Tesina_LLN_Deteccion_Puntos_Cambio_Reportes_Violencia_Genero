# Detección de Punto de Cambio en Serie de Tiempo de Reportes de Violencia de Género en la Ciudad de Monterrey

**UNIVERSIDAD AUTÓNOMA DE NUEVO LEÓN**
Facultad de Ciencias Físico Matemáticas

**Por:** Luis Enrique López Nerio
**Matrícula:** 1487280
**Grado:** Maestría en Ciencia de Datos
**Fecha:** Mayo, 2023

---

**Director:** Dr. Álvaro Eduardo Cordero Franco

**Coordinadora de la Maestría en Ciencia de Datos:**
M.C. Azucena Yoloxóchitl Ríos Mercado

San Nicolás de los Garza, N.L.

---

## Tabla de Contenidos

- [Dedicatoria](#dedicatoria)
- [Agradecimientos](#agradecimientos)
- [Capítulo 1 — Introducción](#capitulo-1--introduccion)
- [Capítulo 2 — Delimitación y Planteamiento del Problema de Investigación](#capitulo-2--delimitacion-y-planteamiento-del-problema-de-investigacion)
- [Capítulo 3 — Justificación](#capitulo-3--justificacion)
- [Capítulo 4 — Formulación de Objetivos](#capitulo-4--formulacion-de-objetivos)
- [Capítulo 5 — Marco Teórico](#capitulo-5--marco-teorico)
  - [5.1 Concepto de violencia de género y el impacto en México](#51-concepto-de-violencia-de-genero-y-el-impacto-en-mexico)
  - [5.2 Indicadores y estadística sobre la violencia de género en México](#52-indicadores-y-estadistica-sobre-la-violencia-de-genero-en-mexico)
  - [5.3 Detección de puntos de cambio](#53-deteccion-de-puntos-de-cambio)
    - [5.3.1 Definición y formulación del problema](#531-definicion-y-formulacion-del-problema)
    - [5.3.2 Categorización de las técnicas](#532-categorizacion-de-las-tecnicas)
- [Capítulo 6 — Metodología](#capitulo-6--metodologia)
- [Capítulo 7 — Resultados y Conclusiones](#capitulo-7--resultados-y-conclusiones)
- [Referencias](#referencias)
- [Anexos y Apéndices](#anexos-y-apendices)

---

## Dedicatoria

> _(pendiente de redactar)_

---

## Agradecimientos

> _(pendiente de redactar)_

---

## Capitulo 1 — Introduccion

### 1.1 _(subtítulo pendiente)_

> _(pendiente de redactar)_

### 1.2 _(subtítulo pendiente)_

> _(pendiente de redactar)_

---

## Capitulo 2 — Delimitacion y Planteamiento del Problema de Investigacion


---

La violencia de género constituye uno de los problemas de derechos humanos más graves en México, de acuerdo con la Organización Mundial de la Salud (2021), casi una de cada tres mujeres en el mundo ha sufrido violencia física o sexual al menos una vez en su vida. En México la magnitud del fenómeno es aún más pronunciada: la Encuesta Nacional sobre la Dinámica de las Relaciones en los Hogares (ENDIREH 2021) del INEGI, la cual es considerada el indicador de referencia nacional en la materia, reportó que el 70.1% de las mujeres de 15 años y más han experimentado al menos un incidente de violencia a lo largo de su vida (INEGI, 2022). 
Ademas, esta cifra solamente representa la violencia que las mujeres reconocen y reportan en la encuesta, la Encuesta Nacional de Victimización (ENVIPE, 2022) estima que el 93.2% de los delitos en México no se denuncian formalmente ante las autoridades, esto nos deja en evidencia que los registros administrativos de denuncias formales, como las carpetas de investigación consolidadas mensualmente por el Secretariado Ejecutivo del Sistema Nacional de Seguridad Pública (SESNSP, 2025) representan solamente una fracción del fenenomeno real. Comprender los patrones temporales del fenomeno de la violencia de genero resulta fundamental para el diseño de plíticas públicas efectivas.


Partiendo del punto de la importancia de estudiar la violencia de genero, el estudio de la problematica no puede limitarse a las fuentes estadísticas institucionales tradicionales. Tanto la ENDIREH como las carpetas de investigación del SESNSP capturan dimensiones distintas del fenómeno, sin embargo, ambas depende de que la víctica toma la iniciativa de denunciar formalmente ante el Ministerio Público o su experiencia se vea reflejada en la muestra de la encuesta. En este contexto, los reportes realizados al servicio de emergencias 9-1-1 representan una fuente complementaria con ventajas importantes, una mayor granularidad, periodicidad continua y ademas  capturan episodios de violencia no derivan en una denuncia formal (Rojido y Cano, 2018). Es precisamente esta fuente la que utiliza el presente trabajo para analizar los patrones temporales de la violencia de género en Monterrey.

La elección de Monterrey como caso de estudio no es arbitraria: desde el 18 de noviembre de 2016, el estado de Nuevo León cuenta con una Declaratoria de Alerta de Violencia de Género contra las Mujeres que incluyó al municipio de Monterrey entre sus cinco territorios prioritarios (CONAVIM, 2016), lo que convierte a este periodo de análisis en especialmente relevante para evaluar el comportamiento de los reportes en vigencia de la alerta.


La base de datos de reportes al 9-1-1 del municipio de Monterrey, publicada a finales de 2022, representa una oportunidad para enriquecer el entendimiento del fenómeno de la violencia de género en la ciudad. Organismos como el Observatorio de Violencia de Género de Nuevo León (2022) han construido un panorama sólido a partir de fuentes como el SESNSP y la ENDIREH; el análisis temporal de los reportes de emergencia mediante técnicas estadísticas formales puede sumarse a ese esfuerzo, aportando una dimensión adicional: la identificación de momentos en que el comportamiento de la serie presenta cambios estructurales que podrían asociarse a distintos tipos de eventos, ya sean de política pública —como la Declaratoria de Alerta de Violencia de Género de 2016—, de contexto social —como el confinamiento por COVID-19 en 2020—, o de carácter sociocultural, como eventos deportivos de alta convocatoria que la literatura ha asociado con incrementos en los reportes de violencia de género (Brimicombe y Cafe, 2012).

Lo anterior plantea la siguiente pregunta de investigación: ¿En qué momentos se producen cambios estructurales estadísticamente significativos en la serie de tiempo de reportes de violencia de género al 9-1-1 en el municipio de Monterrey durante el periodo enero 2017 – septiembre 2022, y en qué medida dichos cambios coinciden con algún evento de interés identificable? Para responder esta pregunta, el presente trabajo propone la aplicación de técnicas estadísticas de detección de puntos de cambio, cuyo fundamento teórico y metodológico se desarrolla en los capítulos subsecuentes.

---







> **[Figura 1]** Serie de tiempo de los reportes de violencia de género. Fuente: Datos Abiertos Monterrey, 2022.

Esta base de datos es una fuente oficial, sin embargo, por su fecha de publicación, no es una base de datos ampliamente estudiada; como se mencionaba anteriormente, estudiar este tipo de datos ayuda a entender el fenómeno de la violencia de género.

Una problemática es analizar el comportamiento de la serie de tiempo del número de reportes realizados e identificar patrones o momentos en los que las propiedades de la serie de tiempo tienen un cambio.

---

## Capitulo 3 — Justificacion

Identificar los puntos de cambio de la serie de tiempo de reportes de violencia de género puede ayudarnos a responder preguntas importantes del fenómeno de violencia de género. Las técnicas de detección de punto de cambio nos pueden ayudar a monitorear y evaluar el impacto que tienen las políticas y programas que buscan atacar la problemática de la violencia de género. Esto podría ayudar a que los recursos se utilicen de manera efectiva.

Además, la técnica de detección de puntos de cambio podría ser útil para identificar cambios en los patrones de violencia, identificar cambios significativos en la serie de tiempo, como un aumento repentino en los casos de violencia en un periodo específico o un cambio en la volatilidad de la serie. Esto puede ayudar a las autoridades a gestionar sus recursos y tomar medidas acorde a los hallazgos.

Uno de los puntos más importantes para atacar la violencia a la mujer es la sensibilización de la sociedad; el estudio de la violencia de género mediante técnicas estadísticas nos otorga la capacidad de dimensionar la magnitud del problema. Los resultados obtenidos pueden educar a la población sobre los patrones de violencia de género, los grupos de mujeres más afectados y las consecuencias de la violencia. Esto puede fomentar una mayor conciencia y compromiso en la sociedad para abordar la violencia de género.

Además, estudiar el problema utilizando esta serie de tiempo de reportes realizados al 911 nos permitirá obtener una fotografía más amplia del problema. Si bien no todos los reportes realizados al 911 pueden derivar en una denuncia formal, es importante recordar que existe un sesgo en las estadísticas oficiales de denuncias por delitos relacionados con violencia de género debido a la falta de denuncias.

El sesgo en las estadísticas de violencia de género debido a la falta de denuncias es un problema común en México. Muchas víctimas de violencia de género no denuncian debido a factores como el miedo a represalias, la falta de confianza en el sistema de justicia, la vergüenza o la falta de conocimiento sobre los recursos disponibles para ayudarles. Esto significa que las estadísticas oficiales sobre la violencia de género a menudo subestiman el verdadero alcance del problema.

---

## Capitulo 4 — Formulacion de Objetivos

Los objetivos planteados son:

- Identificar y estimar si existen puntos de cambio y, en su caso, la localización de estos.
- Si es que existen puntos de cambio, identificar el tipo de cambio que se presenta.

---

## Capitulo 5 — Marco Teorico

### 51 Concepto de violencia de genero y el impacto en Mexico

La violencia de género es un problema complejo y persistente que afecta a mujeres y niñas en todo el mundo, incluyendo México. Es una forma de discriminación y opresión basada en el género que tiene graves consecuencias para la salud, el bienestar y los derechos humanos de las mujeres.

La Organización de las Naciones Unidas (ONU) en su "Declaración sobre la Eliminación de la Violencia contra la Mujer" (1993), entiende a la violencia de género como:

> "…todo acto de violencia basado en la pertenencia al sexo femenino que tenga o pueda tener como resultado un daño o sufrimiento físico, sexual o sicológico para la mujer, así como las amenazas de tales actos, la coacción o la privación arbitraria de la libertad, tanto si se producen en la vida pública como en la vida privada…"

En México, la violencia de género es un problema persistente que ha sido reconocido como una de las principales preocupaciones de derechos humanos. Según el Sistema de Indicadores de Género del Instituto Nacional de las Mujeres (2022), en 2022 se registraron más de 70,000 denuncias por violencia de género, y es probable que muchos más casos no se informen al no tener una denuncia formal.

> **[Figura 2]** Denuncias presentadas ante agencias del ministerio público por delitos de género. Fuente: Sistema de Indicadores de Género del Instituto Nacional de las Mujeres (2022).

Es importante recalcar que la violencia contra la mujer no es exclusivamente la violencia física. Como menciona González y Bejarano (2014), "la violencia comprende también el maltrato psicológico, sexual, de aislamiento y control social, que suelen pasar mucho más desapercibidos". De acuerdo con la normativa en México, la Ley General de Acceso de las Mujeres a una Vida Libre de Violencia (2007) establece que los distintos tipos de violencia son:

- **Violencia psicológica.** Es cualquier acto u omisión que dañe la estabilidad psicológica, que puede consistir en: negligencia, abandono, descuido reiterado, celotipia, insultos, humillaciones, devaluación, marginación, indiferencia, infidelidad, comparaciones destructivas, rechazo, restricción a la autodeterminación y amenazas, las cuales conllevan a la víctima a la depresión, al aislamiento, a la devaluación de su autoestima e incluso al suicidio.

- **Violencia física.** Es cualquier acto que inflige daño no accidental, usando la fuerza física o algún tipo de arma u objeto que pueda provocar o no lesiones ya sean internas, externas, o ambas.

- **Violencia patrimonial.** Es cualquier acto u omisión que afecta la supervivencia de la víctima. Se manifiesta en: la transformación, sustracción, destrucción, retención o distracción de objetos, documentos personales, bienes y valores, derechos patrimoniales o recursos económicos destinados a satisfacer sus necesidades y puede abarcar los daños a los bienes comunes o propios de la víctima.

- **Violencia económica.** Es toda acción u omisión del agresor que afecta la supervivencia económica de la víctima. Se manifiesta a través de limitaciones encaminadas a controlar el ingreso de sus percepciones económicas, así como la percepción de un salario menor por igual trabajo, dentro de un mismo centro laboral.

- **Violencia sexual.** Es cualquier acto que degrada o daña el cuerpo y/o la sexualidad de la víctima y que por tanto atenta contra su libertad, dignidad e integridad física. Es una expresión de abuso de poder que implica la supremacía masculina sobre la mujer, al denigrarla y concebirla como objeto.

- Cualesquiera otras formas análogas que lesionen o sean susceptibles de dañar la dignidad, integridad o libertad de las mujeres.

Además, la violencia de género es un fenómeno altamente relacionado con otros problemas sociales y económicos como la pobreza, la discriminación racial y de género, la desigualdad económica y la falta de acceso a la justicia. Estos factores contribuyen a crear un entorno en el que la violencia de género es aceptada y normalizada.

La respuesta a la violencia de género en México ha sido una combinación de medidas legales y de sensibilización pública. En 2007 se publica la Ley General de Acceso de las Mujeres a una Vida Libre de Violencia, la cual establece en su artículo 1: "…tiene como objeto establecer la coordinación entre la Federación, las entidades federativas, el Distrito Federal y los municipios para prevenir, sancionar y erradicar la violencia contra las mujeres…"

Esta ley implementa un mecanismo de alerta de violencia de género, descrito en el artículo 22, con el objetivo de implementar acciones gubernamentales de emergencia para enfrentar y erradicar la violencia feminicida en un territorio determinado. Sin embargo, como plantean Damián y Flores (2017), las respuestas a las solicitudes de alerta por violencia de género se ven afectadas por el Estado mexicano, lo cual provoca que el objetivo del mecanismo no se cumpla cabalmente.

A pesar de los esfuerzos gubernamentales y de las organizaciones no gubernamentales en México para erradicar la violencia de género, la tasa de violencia contra las mujeres en el país sigue siendo alarmantemente alta. Hay varias razones por las cuales las estrategias para erradicar la violencia de género en México no han tenido el éxito esperado:

- **Falta de implementación efectiva:** Muchas de las leyes y políticas existentes para abordar la violencia de género en México no se implementan adecuadamente o no tienen los recursos necesarios para ser efectivas.

- **Desigualdad de género:** La desigualdad de género y la discriminación hacia las mujeres en México son causas profundas de la violencia de género y deben abordarse de manera más integral.

- **Cultura de la impunidad:** La cultura de la impunidad y la corrupción en el sistema de justicia en México contribuyen a la perpetuación de la violencia de género y a la falta de consecuencias para los perpetradores.

- **Falta de sensibilización pública:** La sensibilización pública y la educación son clave para prevenir la violencia de género y fomentar una cultura de respeto e igualdad de género. Sin embargo, en muchos casos, la falta de sensibilización pública y educación en esta materia contribuye a la perpetuación de la violencia de género.

---

### 52 Indicadores y estadistica sobre la violencia de genero en Mexico

Las estadísticas son un elemento clave para la formulación de políticas públicas efectivas y la toma de decisiones informadas. La recopilación de datos precisos y actualizados sobre un problema o situación es fundamental para entender su magnitud y gravedad, identificar tendencias y patrones, y evaluar la efectividad de las soluciones implementadas. En el caso de la violencia de género, las estadísticas son esenciales para entender la magnitud del problema y la efectividad de las políticas y programas implementados para prevenirla y abordarla.

La recopilación de datos precisos y actualizados sobre la violencia de género permite identificar las formas en las que está ocurriendo y las víctimas más afectadas. El Sistema de Indicadores de Género del Instituto Nacional de las Mujeres establece que las fuentes principales de información regulares respecto a estadísticas de género son:

- Censos / Conteos
- Encuestas
- Registros administrativos

Estas fuentes cuentan con una metodología y periodicidad establecida; sin embargo, cada una tiene sus pros y contras. La información de registros administrativos se obtiene a partir de instituciones de procuración de justicia de cada entidad: las procuradurías reportan al Instituto Nacional de Estadística y Geografía las estadísticas de denuncias y delitos relacionados con violencia de género. Sin embargo, estas cifras se ven sesgadas ya que solo representan los delitos y denuncias procesadas. Como menciona Rojido & Cano (2018), factores como la gravedad de los hechos, la confianza en las autoridades y el temor a sufrir represalias afectan la decisión de presentar una denuncia.

Un ejemplo de fuente de tipo encuesta es la Encuesta Nacional sobre la Dinámica de las Relaciones en los Hogares (ENDIREH, 2021) recabada por el INEGI, con periodicidad quinquenal y cuyo objetivo principal es "generar información sobre las experiencias de violencia que han enfrentado las mujeres de 15 años y más, de manera detallada por tipo de violencia, para los distintos ámbitos (de pareja, familiar, escolar, laboral y comunitario)". Una ventaja es que esta encuesta cuenta con una metodología establecida que hace que los resultados sean confiables y comparables en distintos años; sin embargo, debido a la periodicidad quinquenal y a la naturaleza del fenómeno, provoca que se tengan estadísticas desactualizadas.

Una fuente relativamente nueva son las llamadas realizadas al 9-1-1 registradas en los centros de atención a llamadas de emergencia en todo el país. Estas llamadas son recopiladas con base en el Catálogo Nacional de Incidentes de Emergencia (2016), que busca homologar la clasificación de los incidentes. Los reportes son una fuente oficial; sin embargo, no todas las entidades en México liberan la información. Para el presente estudio se utilizará la base de reportes de violencia de género al 911 liberada por el municipio de Monterrey.

---

### 53 Deteccion de puntos de cambio

Las series de tiempo son secuencias de valores numéricos observados a lo largo del tiempo. Cada valor en la serie representa una medición o una observación de una variable en un momento específico. Las series de tiempo son ampliamente utilizadas en una variedad de campos como economía, finanzas, epidemiología, meteorología, entre otros.

Una serie de tiempo se puede definir como una secuencia de observaciones de la forma:

$$y = y_1, y_2, y_3, \ldots, y_T$$

En el análisis de series de tiempo se utilizan una variedad de técnicas para describir y modelar las propiedades estadísticas de la serie. Dentro de este análisis existen las técnicas de detección de punto de cambio.

> **[Figura 3]** Serie de tiempo con múltiples puntos de cambio. Fuente: Elaboración propia.

El análisis de detección de punto de cambio es una técnica estadística que busca identificar el punto en el tiempo en el que las propiedades estadísticas de una serie temporal sufren un cambio significativo. Este cambio se puede presentar en la media o la varianza de la serie de tiempo. Los principales objetivos de las técnicas de detección de punto de cambio son estimar el momento en el que ocurren los cambios en la serie y la naturaleza de los mismos.

Las técnicas de detección de punto de cambio son una herramienta estadística útil con un amplio abanico de aplicaciones. Algunas de las primeras aplicaciones se dieron en el control de calidad por parte de Page (1954), buscando cambios en las medias de una serie de tiempo.

> **[Figura 4]** Series de tiempo con cambio en media, varianza y tendencia. Fuente: Elaboración propia.

La naturaleza de los cambios en las propiedades estadísticas de la serie se puede presentar de distintas formas: solamente en media, solamente en varianza o en tendencia, como se observa en la Figura 4.

Las áreas de aplicación de la detección de punto de cambio van desde la medicina —para la detección de puntos de cambio en la serie de tiempo de los latidos del corazón durante el sueño (Staudacher et al., 2005)— hasta el reconocimiento de voz para la segmentación de audio (Rybach et al., 2009).

---

#### 531 Definicion y formulacion del problema

Como se definió anteriormente, una serie de tiempo se puede expresar como:

$$y = y_1, y_2, y_3, \ldots, y_n$$

Donde $y_t$ es una observación en el tiempo $t$. En la detección de un solo cambio se busca encontrar, si es que existe, el valor de $\tau$ que segmenta la serie en:

$$y = y_1, y_2, \ldots, y_\tau \mid y_{\tau+1}, y_{\tau+2}, \ldots, y_n$$

De tal manera que la serie antes y después del punto $\tau$ son diferentes. La formulación para la detección de múltiples puntos de cambio sigue una lógica similar y busca identificar los valores:

$$\tau = \{\tau_1, \tau_2, \tau_3, \ldots, \tau_k\}$$

que separan a $y$ en $k+1$ segmentos, los cuales de manera individual no tienen cambios en sus propiedades estadísticas.

---

#### 532 Categorizacion de las tecnicas de deteccion de punto de cambio

Una de las formas en las que se pueden categorizar las técnicas de punto de cambio es **Online vs. Offline**:

- **Métodos Online (tiempo real):** buscan detectar cambios tan pronto ocurren, utilizando los datos conforme van llegando. Sus ventajas son la respuesta rápida y la adaptación a problemas con datos continuos; sin embargo, al no contar con todos los datos pueden ser menos precisos y generar falsos positivos.

- **Métodos Offline (retrospectivos):** utilizan toda la serie temporal disponible para encontrar los momentos en los que ocurrieron los cambios. Suelen tener mayor precisión, aunque presentan mayor complejidad computacional y no son útiles cuando se requiere detectar cambios en tiempo real.

> **[Figura 5]** Series de tiempo con detección de punto de cambio online y offline. Fuente: Elaboración propia.

Para ilustrar la diferencia: se genera una serie de tiempo con 50 datos con distribución normal ($\mu=0$, $\sigma=0.25$) y 15 con ($\mu=0.5$, $\sigma=0.4$), por lo que la serie tiene un cambio en $t=60$. En la detección online, la línea roja representa el momento en que se detecta el cambio; en la retrospectiva, todos los datos son alimentados al algoritmo para identificar el punto de ruptura.

Como establece Aminikhanghahi (2017), los métodos también pueden clasificarse como **supervisados y no supervisados**:

- **Métodos supervisados:** requieren que los datos estén etiquetados (series de tiempo con ubicación exacta del cambio conocida). Utilizan estas series para entrenar algoritmos de machine learning bajo dos enfoques: clasificación multi-clase o clasificación binaria.

> **[Figura 6]** Métodos supervisados. Fuente: Aminikhanghahi, S., & Cook, D. J. (2017). A survey of methods for time series change point detection.

- **Métodos no supervisados:** buscan encontrar puntos de cambio sobre series de tiempo no etiquetadas, utilizando propiedades estadísticas intrínsecas a la serie para identificar los puntos de cambio.

> **[Figura 7]** Métodos no supervisados. Fuente: Aminikhanghahi, S., & Cook, D. J. (2017). A survey of methods for time series change point detection.

Otra categorización se basa en los supuestos sobre la distribución de los datos: **métodos paramétricos y no paramétricos**.

En los **métodos paramétricos** se asume que la serie sigue una distribución estadística definida por un número finito de parámetros:

$$y_t \sim \begin{cases} f_{\theta_1} & \text{para } t \leq \tau_1 \\ f_{\theta_2} & \text{para } \tau_1 < t \leq \tau_2 \\ \vdots \\ f_{\theta_k} & \text{para } \tau_{k-1} < t \leq \tau_k \end{cases}$$

El parámetro $\theta_k$ representa la propiedad estadística sobre la que se busca el cambio. En la detección con un solo cambio:

$$y_t \sim \begin{cases} f_{\theta_1} & \text{para } t \leq \tau \\ f_{\theta_2} & \text{para } \tau < t \end{cases}$$

Localizar el punto de cambio se reduce a encontrar el valor de $\tau$ que minimiza la función de costo $C(\tau)$, donde la función de costo suele ser la log-verosimilitud negativa:

$$\tau = \underset{1 \leq \tau \leq n-1}{\arg\min} \; C(\tau)$$

> **[Figura 8]** Serie de tiempo con cambio en media en $t = 250$. Fuente: Elaboración propia.

> **[Figura 9]** Función de costo para distintos valores de $t$. Fuente: Elaboración propia.

En los **métodos no paramétricos**, los datos no siguen una distribución paramétrica definida, pero se sigue la misma lógica: minimizar una función de costo que depende de $\tau$. Como menciona Truong (2020), los tres principales métodos se basan en la función de distribución acumulada empírica, detección basada en rangos y detección basada en kernel.

---

## Capitulo 6 — Metodologia

### 6.1 _(subtítulo pendiente)_

> _(pendiente de redactar)_

### 6.2 _(subtítulo pendiente)_

> _(pendiente de redactar)_

---

## Capitulo 7 — Resultados y Conclusiones

### 7.1 _(subtítulo pendiente)_

> _(pendiente de redactar)_

### 7.2 _(subtítulo pendiente)_

> _(pendiente de redactar)_

---

## Referencias
---
INEGI. (2022a). Encuesta Nacional sobre la Dinámica de las Relaciones en los Hogares (ENDIREH) 2021. Instituto Nacional de Estadística y Geografía. https://www.inegi.org.mx/programas/endireh/2021/

INEGI. (2022b). Encuesta Nacional de Victimización y Percepción sobre Seguridad Pública (ENVIPE) 2022. Instituto Nacional de Estadística y Geografía. https://www.inegi.org.mx/programas/envipe/2022/

Organización Mundial de la Salud. (2021). Violencia contra la mujer. https://www.who.int/es/news-room/fact-sheets/detail/violence-against-women

Secretariado Ejecutivo del Sistema Nacional de Seguridad Pública. (2025). Cifras de víctimas del fuero común 2015–2025 [Base de datos]. Gobierno de México. https://www.gob.mx/sesnsp/acciones-y-programas/datos-abiertos-de-incidencia-delictiva


Datos Abiertos Monterrey. (2022). Reportes al 911 por violencia de género [Base de datos]. Municipio de Monterrey. https://datos.monterrey.gob.mx/dataset/reportes-al-911-por-violencia-de-genero
https://mide.monterrey.gob.mx/catalogue/#/dataset/92

Comisión Nacional para Prevenir y Erradicar la Violencia Contra las Mujeres. (2016). Declaratoria de Alerta de Violencia de Género contra las Mujeres para el estado de Nuevo León. CONAVIM / Secretaría de Gobernación. https://www.gob.mx/conavim/documentos/solicitud-de-alerta-de-violencia-de-genero-contra-las-mujeres-en-el-estado-de-nuevo-leon

---

Aminikhanghahi, S., & Cook, D. J. (2017). A survey of methods for time series change point detection. *Knowledge and Information Systems*, 51(2), 339–367.

Catálogo Nacional de Incidentes de Emergencia. (2016). Secretariado Ejecutivo del Sistema Nacional de Seguridad Pública.

Damián Bernal, A. L., & Flores, J. A. (2018). Feminicidios y políticas públicas: declaratorias de alertas de violencia de género en México, 2015-2017. *Perspectiva Geográfica*, 23(2), 33–57.

Datos Abiertos Monterrey. (2022, noviembre). Reportes al 911 por Violencia de Género. https://datos.monterrey.gob.mx/dataset/reportes-al-911-por-violencia-de-genero

Gobierno Federal. (2007). Ley General de Acceso de las Mujeres a una Vida Libre de Violencia. *Diario Oficial de la Federación*. México.

González, G. C., & Bejarano, R. C. (2014). La violencia de género: evolución, impacto y claves para su abordaje. *Enfermería Global*, 13(1), 424–439.

Hinkley, D. V. (1970). Inference about the change-point in a sequence of random variables. *Biometrika*, 57(1), 1–17.

INEGI. (2021). Encuesta Nacional sobre la Dinámica de las Relaciones en los Hogares (ENDIREH). https://www.inegi.org.mx/programas/endireh/2021/

Instituto Nacional de las Mujeres. Sistema de Indicadores de Género. (2022). http://estadistica-sig.inmujeres.gob.mx/

Naciones Unidas, Asamblea General. (1993). Declaración sobre la Eliminación de la Violencia contra la Mujer. Resolución A/RES/48/104.

Page, E. S. (1954). Continuous inspection schemes. *Biometrika*, 41(1/2), 100–115.

Rojido, E., & Cano, I. (2018). Los desafíos metodológicos de investigar violencia: una mirada desde América Latina. *Acta Sociológica*, (75), 61–85.

Rybach, D., Gollan, C., Schluter, R., & Ney, H. (2009, April). Audio segmentation for speech recognition using segment features. En *2009 IEEE International Conference on Acoustics, Speech and Signal Processing* (pp. 4197–4200). IEEE.

Staudacher, M., Telser, S., Amann, A., Hinterhuber, H., & Ritsch-Marte, M. (2005). A new method for change-point detection developed for on-line analysis of the heart beat variability during sleep. *Physica A: Statistical Mechanics and its Applications*, 349(3–4), 582–596.

Truong, C., Oudre, L., & Vayatis, N. (2020). Selective review of offline change point detection methods. *Signal Processing*, 167, 107299.

---

## Anexos y Apendices

> _(pendiente)_

---

*Última actualización: mayo 2026*
