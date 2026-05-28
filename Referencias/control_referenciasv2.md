# Control de Referencias — Tesina
**Tema:** Detección de Punto de Cambio en Serie de Tiempo de Reportes de Violencia de Género en Monterrey
**Norma:** APA 7ª edición
**Última actualización:** mayo 2026

---

## Cómo usar este archivo

- **Estado:** ✅ verificada tú directo en la fuente | ⚠️ pendiente de verificar | ❌ no encontrada
- **Tipo de cita:** P = paráfrasis | T = textual | D = dato numérico
- Agrega notas libremente debajo de cada entrada

---

## Referencias

---

### OMS2021
**Estado:** ✅ Verificada
**Tipo:** D — dato numérico
**Citada en:** Cap. 2, Cap. 5.1

**Referencia APA 7:**
Organización Mundial de la Salud. (2021). *Violencia contra la mujer*. https://www.who.int/es/news-room/fact-sheets/detail/violence-against-women

**Dato clave:** Casi 1 de cada 3 mujeres en el mundo ha sufrido violencia física o sexual al menos una vez en su vida.

**Notas:**
- URL activa verificada mayo 2026.
- Nota descriptiva oficial de la OMS, publicada el 9 de marzo de 2021.

---

### INEGI2022a
**Estado:** ✅ Verificada
**Tipo:** D — dato numérico
**Citada en:** Cap. 2, Cap. 5.2

**Referencia APA 7:**
INEGI. (2022a). *Encuesta Nacional sobre la Dinámica de las Relaciones en los Hogares (ENDIREH) 2021*. Instituto Nacional de Estadística y Geografía. https://www.inegi.org.mx/programas/endireh/2021/

**Dato clave:** El 70.1% de las mujeres de 15 años y más han experimentado al menos un incidente de violencia a lo largo de su vida.

**Notas:**
- Fuente primaria. Indicador de referencia nacional para VG en México.
- Periodicidad quinquenal — ediciones: 2003, 2006, 2011, 2016, 2021.
- No permite construir serie de tiempo mensual, sirve como referencia de prevalencia.
- La "a" distingue esta referencia de INEGI2022b (ENVIPE) al citar en texto: (INEGI, 2022a).

---

### INEGI2022b
**Estado:** ✅ Verificada
**Tipo:** D — dato numérico
**Citada en:** Cap. 2, Cap. 5.2, Cap. 4.1.4

**Referencia APA 7:**
INEGI. (2022b). *Encuesta Nacional de Victimización y Percepción sobre Seguridad Pública (ENVIPE) 2022*. Instituto Nacional de Estadística y Geografía. https://www.inegi.org.mx/programas/envipe/2022/

**Dato clave:** El 93.2% de los delitos en México no se denuncian formalmente ante las autoridades (cifra negra).

**Notas:**
- Fuente primaria. Referencia estándar para documentar subregistro en México.
- Se levanta anualmente — permite ver tendencias año a año.
- La "b" distingue esta referencia de INEGI2022a (ENDIREH) al citar en texto: (INEGI, 2022b).

---
### SESNSP2025
**Estado:** ✅ Verificada
**Tipo:** D — dato numérico
**Citada en:** Cap. 2, Cap. 4.1.3, Cap. 5.2, Cap. 6

**Referencia APA 7:**
Secretariado Ejecutivo del Sistema Nacional de Seguridad Pública. (2025). *Cifras de víctimas del fuero común 2015–2025* [Base de datos]. Gobierno de México. https://www.gob.mx/sesnsp/acciones-y-programas/datos-abiertos-de-incidencia-delictiva

**Referencia APA 7 del manual metodológico:**
Secretariado Ejecutivo del Sistema Nacional de Seguridad Pública. (2025). *Manual metodológico del Registro Nacional de Incidencia Delictiva (RNID)*. Gobierno de México. https://www.gob.mx/cms/uploads/attachment/file/1058582/Manual_metodol_gico_RNID_V1.0_VF.pdf

**Notas metodológicas:**
1. Qué mide exactamente
La incidencia delictiva se refiere a la presunta ocurrencia de delitos registrados en carpetas de investigación iniciadas por los hechos por los que una denuncia o querella es presentada ante el Ministerio Público y que derivan en el inicio de una investigación penal, o bien los que son investigados de oficio. Milenio
Traducido a términos simples: no es el número de delitos ocurridos, es el número de carpetas de investigación abiertas. Una carpeta puede tener múltiples víctimas, y un delito puede no generar ninguna carpeta si no se denuncia.

2. Cómo fluye la información — de abajo hacia arriba
El flujo es este:
```
Víctima denuncia (o MP investiga de oficio)
        ↓
Fiscalía o Procuraduría estatal abre carpeta
        ↓
Fiscalía reporta mensualmente al SESNSP
        ↓
SESNSP consolida las 32 entidades
        ↓
Publica base de datos abierta el día 20 de cada mes
```
Desde 2015 el SESNSP utiliza la metodología CNSP/38/15, que consiste en actualizar los datos de incidencia delictiva mensualmente. Las instancias estatales son las responsables de asegurar la veracidad y actualización de la información. SciELO
Esto tiene una implicación crítica para tu tesina: el SESNSP no genera los datos, los consolida. Si una fiscalía estatal clasifica mal un delito o retrasa su reporte, eso se refleja en la base nacional.



3. Las tres bases de datos que publica
Los datos publicados por el SESNSP se organizan en: incidencia delictiva estatal (carpetas agregadas por entidad), incidencia delictiva municipal (mayor desagregación geográfica), y víctimas del fuero común (número de víctimas con variables adicionales como sexo y grupo de edad). Milenio
Para tu tesina la relevante es la de víctimas municipales porque:

Tiene desagregación por sexo — esencial para aislar violencia contra mujeres
Tiene desagregación por municipio — necesitas Monterrey específicamente
Tiene desagregación por grupo de edad — desde la nueva metodología 2026

Resumen para tu sección 5.2 — en una oración citable
Puedes escribirlo así en tu marco teórico:

El SESNSP consolida mensualmente las carpetas de investigación iniciadas por las 32 fiscalías estatales bajo la metodología CNSP/38/15, publicando tres niveles de desagregación: estatal, municipal y por víctimas; siendo esta última la que permite identificar el sexo y grupo de edad de las personas afectadas (SESNSP, 2025).

4. Los delitos relevantes para VG en esta base
Dentro del catálogo, los delitos que debes filtrar para tu análisis son:

| Categoría | Delitos específicos |
|---|---|
| Contra la familia | Violencia familiar, violencia de género en todas sus modalidades distinta a la violencia familiar |
| Contra la libertad y seguridad sexual | Violación simple, violación equiparada, abuso sexual, acoso sexual, hostigamiento sexual |
| Contra la vida | Feminicidio |

5. El cambio metodológico que debes mencionar en tu tesina
Los datos publicados por el SESNSP de 2015 a 2025 mantienen la metodología del instrumento CNSP/38/15, mientras que los datos publicados de 2026 a la fecha utilizan el Manual metodológico del Registro Nacional de Incidencia Delictiva (RNID). En febrero de 2026 el SESNSP publicó las nuevas bases de datos correspondientes a la nueva metodología, que por primera vez proporciona el conteo de víctimas para todos los delitos a nivel estatal y municipal. Milenio
Para tu tesina esto es irrelevante porque tu serie termina en septiembre 2022, que cae completamente dentro de la metodología CNSP/38/15. Pero debes mencionarlo en la sección de limitaciones para mostrar que conoces el contexto.

6. La limitación más importante para tu trabajo
Los presuntos delitos reportados en los informes del SESNSP pueden estar involucrados con una o más víctimas, ya que se cuenta por carpetas o averiguaciones y no por caso particular. SciELO
Esto significa que si en una sola carpeta hay tres víctimas de violencia familiar, el SESNSP cuenta 1, no 3 — a menos que uses la base de víctimas, que sí las cuenta individualmente. De ahí la importancia de especificar en tu metodología exactamente cuál de las tres bases usas.

Resumen para tu sección 5.2 — en una oración citable
Puedes escribirlo así en tu marco teórico:

El SESNSP consolida mensualmente las carpetas de investigación iniciadas por las 32 fiscalías estatales bajo la metodología CNSP/38/15, publicando tres niveles de desagregación: estatal, municipal y por víctimas; siendo esta última la que permite identificar el sexo y grupo de edad de las personas afectadas (SESNSP, 2025).

---
### DatosAbiertosMonterrey2022
**Estado:** ✅ Pendiente de verificar URL activa
**Tipo:** D — dato numérico
**Citada en:** Cap. 2, Cap. 6

**Referencia APA 7:**
Datos Abiertos Monterrey. (2022). *Reportes al 911 por violencia de género* [Base de datos]. Municipio de Monterrey. https://datos.monterrey.gob.mx/dataset/reportes-al-911-por-violencia-de-genero
https://mide.monterrey.gob.mx/catalogue/#/dataset/92

**Notas:**
- Fuente primaria de datos de la tesina.
- Periodo: enero 2017 – septiembre 2022.
- Pendiente: verificar URL activa y que la base no haya sido modificada.
- Pendiente: anotar fecha exacta de descarga en la sección de metodología.
- Pendiente: registrar número total de registros y variables disponibles en la base.

---
### AVGMNL2016
**Estado:** ✅ Verificada — alerta activa confirmada 2025
**Tipo:** P — paráfrasis
**Citada en:** Cap. 2, Cap. 4.1.2

**Referencia APA 7 — Declaratoria original:**
Comisión Nacional para Prevenir y Erradicar la Violencia
  Contra las Mujeres. (2016). *Declaratoria de Alerta de
  Violencia de Género contra las Mujeres para el estado
  de Nuevo León*. CONAVIM / Secretaría de Gobernación.
  https://www.gob.mx/conavim/documentos/solicitud-de-alerta-de-violencia-de-genero-contra-las-mujeres-en-el-estado-de-nuevo-leon

https://www.gob.mx/cms/uploads/attachment/file/831667/10._Resoluci_n_DAVGM_18.11.2016.pdf

**Referencia APA 7 — Vigencia 2025:**
Milenio. (2025, 13 de abril). Nuevo León asigna 25 mdp
  a municipios con alerta de violencia de género. *Milenio*.
  https://www.milenio.com/politica/comunidad/nuevo-leon-
  asigna-25-mdp-municipios-alerta-violencia-genero

**Datos verificados:**
- Fecha de declaratoria: 18 de noviembre de 2016.
- Organismo declarante: CONAVIM (federal) — ya no existe
  desde 2024, sus funciones pasaron a Semujeres.
- Municipios originales (2016): Apodaca, Cadereyta
  Jiménez, Guadalupe, Juárez y Monterrey.
- Municipios ampliados (2023): Escobedo, García,
  Ciénega de Flores y Salinas Victoria.
- Estado actual: vigente a 2025, con presupuesto
  asignado de $25 mdp publicado en Periódico Oficial NL.
- Solo 3 de 18 medidas cumplidas al último dictamen
  disponible (2021).

**Cómo citar en texto:**
- Declaratoria: (CONAVIM, 2016)
- Vigencia actual: (Milenio, 2025)

**Notas:**
- Evento clave para el análisis CPD: posible change
  point en la serie de tiempo en noviembre 2016.
- La baja implementación de medidas (3/18) implica
  que un change point en 2016 podría reflejar efecto
  de visibilización más que efecto de política pública.
  Argumento útil para la sección de discusión.

---
### Rojido2018
**Estado:** ✅ Verificada — PDF revisado
**Tipo:** P — paráfrasis
**Citada en:** Cap. 2, Cap. 5.2

**Referencia APA 7:**
Rojido, E., y Cano, I. (2018). Los desafíos metodológicos
  de investigar la violencia: una mirada desde América
  Latina. *Acta Sociológica*, (75), 61–85.

**Argumentos clave:**
- p. 75: factores que inhiben la denuncia formal —
  gravedad de los hechos, confianza en autoridades,
  temor a represalias.
- p. 79: tasa de subnotificación en México del 93.7%
  para 2016 según ENVIPE (dato de 2016, no usar para
  cifra actual — usar ENVIPE 2022 directamente).
- p. 74: los datos oficiales reflejan tanto los delitos
  ocurridos como las decisiones institucionales del
  sistema de justicia.

**Notas:**
- No tiene DOI asignado — revista UNAM, Redalyc.
- El artículo es sobre metodología de investigación
  de violencia en general, no específicamente VG.
- Se aplica el argumento de subnotificación al
  contexto de VG y reportes al 911.
- Citar con página: (Rojido y Cano, 2018, p. 75)
  para el argumento de factores de no denuncia.
---


### BAESVIM2024
**Estado:** ✅ Verificada — portal oficial activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 2, Cap. 4.1.3

**Referencia APA 7:**
Secretaría de las Mujeres de Nuevo León. (2024).
  *Informes estadísticos de casos de violencia contra
  mujeres (BAESVIM). Reporte trimestral enero a marzo
  2024*. Gobierno del Estado de Nuevo León.
  https://www.nl.gob.mx/es/informes-estadisticos-de-
  casos-de-violencia-contra-mujeres-baesvim

**Notas:**
- Fuente oficial del Gobierno de NL, mucho más
  verificable y citable que el Observatorio.
- Publicación trimestral desde 2020 — cubre
  exactamente el periodo de tu serie de tiempo.
- Usa datos del SESNSP, Fiscalía NL y registros
  institucionales propios.
- Sustituye al ObservatorioVGNL2022 en el párrafo.
- En texto citar como: (Secretaría de las Mujeres
  de NL, 2024).
- Puedes citar el reporte más cercano a tu periodo
  de análisis: usa el de 2022 si necesitas coincidir
  con tu serie (2017–2022).

---


---

## Bibliografía — Partidos de Fútbol y Violencia de Género

### BrimicombeyCafe2012
**Estado:** ✅ Verificada — DOI activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 2, Cap. 5, Cap. 6

**Referencia APA 7:**
Brimicombe, A., y Cafe, R. (2012). Beware, win or lose: Domestic violence and the World Cup. *Significance*, *9*(5), 32–35. https://doi.org/10.1111/j.1740-9713.2012.00606.x

**Notas:**
- Paper original que motivó el análisis de partidos en la tesina.
- Hallazgo: victorias Y derrotas aumentan VD, empates no generan efecto significativo.
- Usa comparación contra mismo día de semana en semanas sin partido — control que debes replicar.
- PDF verificado y disponible (adjunto en sesión).

---

### CardDahl2011
**Estado:** ✅ Verificada — DOI activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 2, Cap. 5, Cap. 6

**Referencia APA 7:**
Card, D., y Dahl, G. B. (2011). Family violence and football: The effect of unexpected emotional cues on violent behavior. *The Quarterly Journal of Economics*, *126*(1), 103–143. https://doi.org/10.1093/qje/qjr001

**Notas:**
- Paper fundacional del tema — el más citado en la literatura de deportes y VD.
- Derrotas inesperadas en NFL generan +10% en VD.
- Modelo Poisson con dummies de temporada, semana y clima — estructura base para el tuyo.
- Acceso libre en PMC: pmc.ncbi.nlm.nih.gov/articles/PMC3712874/

---

### Trendl2021
**Estado:** ✅ Verificada — DOI activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5, Cap. 6

**Referencia APA 7:**
Trendl, A., Stewart, N., y Mullett, T. L. (2021). The role of alcohol in the link between national football (soccer) tournaments and domestic abuse: Evidence from England. *Social Science & Medicine*, *268*, 113457. https://doi.org/10.1016/j.socscimed.2020.113457

**Notas:**
- Usa regresión binomial negativa — más adecuada que OLS para datos de conteos sobredispersos.
- +47% en casos relacionados con alcohol tras victoria. Empates sin efecto.
- 10 años de datos (2010–2019), West Midlands Police.
- Justifica elección de binomial negativa sobre regresión lineal.

---

### IvandicManchester2021
**Estado:** ✅ Verificada
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5, Cap. 6

**Referencia APA 7:**
Ivandić, R., Kirchmaier, T., y Linton, B. (2021). Football, alcohol and domestic abuse (CEP Discussion Paper No. 1781). London School of Economics. https://cep.lse.ac.uk/pubs/download/dp1781.pdf

**Notas:**
- Diseño más similar al de la tesina: dos equipos de la misma ciudad (Manchester City y Manchester United) — equivalente a Tigres y Rayados en Monterrey.
- 434,596 llamadas, 780 partidos, 2012–2019.
- El efecto se extiende hasta 16h después del partido — justifica análisis de lags.

---

## Bibliografía — Enfoques Metodológicos

---

### CPD Offline

#### Truong2020
**Estado:** ✅ Verificada — DOI activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5.3, Cap. 6

**Referencia APA 7:**
Truong, C., Oudre, L., y Vayatis, N. (2020). Selective review of offline change point detection methods. *Signal Processing*, *167*, 107299. https://doi.org/10.1016/j.sigpro.2019.107299

**Notas:**
- Revisión de más de 140 artículos de CPD offline.
- Marco teórico: función de costo + método de búsqueda + restricción en número de cambios.
- Librería asociada: ruptures (Python).
- Acceso abierto en arXiv: arxiv.org/abs/1801.00718

---

#### Killick2012
**Estado:** ✅ Verificada — DOI activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5.3, Cap. 6

**Referencia APA 7:**
Killick, R., Fearnhead, P., y Eckley, I. A. (2012). Optimal detection of changepoints with a linear computational cost. *Journal of the American Statistical Association*, *107*(500), 1590–1598. https://doi.org/10.1080/01621459.2012.737745

**Notas:**
- Paper original del algoritmo PELT.
- Citar cuando uses rpt.Pelt() en ruptures.
- Complejidad O(n) en la práctica.
- Acceso libre en arXiv: arxiv.org/abs/1101.1438

---

#### Page1954
**Estado:** ✅ Verificada
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5.3

**Referencia APA 7:**
Page, E. S. (1954). Continuous inspection schemes. *Biometrika*, *41*(1/2), 100–115.

**Notas:**
- Primera aplicación histórica de CPD en control de calidad industrial.
- Ya citada en el docx original de la tesina.

---

### Interrupted Time Series (ITS)

#### BernalITS2017
**Estado:** ✅ Verificada — DOI activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5, Cap. 6

**Referencia APA 7:**
Bernal, J. L., Cummins, S., y Gasparrini, A. (2017). Interrupted time series regression for the evaluation of public health interventions: a tutorial. *International Journal of Epidemiology*, *46*(1), 348–355. https://doi.org/10.1093/ije/dyw098

**Notas:**
- Referencia estándar para ITS en salud pública.
- Tutorial con ejemplo trabajado paso a paso con regresión segmentada.
- Trata problemas metodológicos: autocorrelación, estacionalidad y confusores.
- Acceso abierto en Oxford Academic.

---

#### BernalITS2018
**Estado:** ✅ Verificada
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5, Cap. 6

**Referencia APA 7:**
Lopez Bernal, J., Soumerai, S., y Gasparrini, A. (2018). A methodological framework for model selection in interrupted time series studies. *Journal of Clinical Epidemiology*, *103*, 82–91.

**Notas:**
- Extensión metodológica del tutorial anterior.
- Guía para selección de modelo en estudios ITS.

---

#### Wagner2002
**Estado:** ✅ Verificada
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5, Cap. 6

**Referencia APA 7:**
Wagner, A. K., Soumerai, S. B., Zhang, F., y Ross-Degnan, D. (2002). Segmented regression analysis of interrupted time series studies in medication use research. *Journal of Clinical Pharmacy and Therapeutics*, *27*(4), 299–309.

**Notas:**
- Referencia pionera de regresión segmentada aplicada a series de tiempo.
- Base conceptual para entender los coeficientes del modelo ITS.

---

### CausalImpact

#### Brodersen2015
**Estado:** ✅ Verificada — DOI activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5, Cap. 6

**Referencia APA 7:**
Brodersen, K. H., Gallusser, F., Koehler, J., Remy, N., y Scott, S. L. (2015). Inferring causal impact using Bayesian structural time-series models. *Annals of Applied Statistics*, *9*(1), 247–274. https://doi.org/10.1214/14-AOAS788

**Notas:**
- Paper original de CausalImpact (Google).
- Versión bayesiana del ITS: produce distribución de probabilidad sobre el efecto, no solo un coeficiente.
- Implementación en Python: pip install causalimpact
- Candidato para evaluar efecto de COVID-19 (mar. 2020) sobre la serie.

---

### Regresión con Variables Dummy

#### NeweyWest1987
**Estado:** ✅ Verificada — DOI activo
**Tipo:** P — paráfrasis
**Citada en:** Cap. 6

**Referencia APA 7:**
Newey, W. K., y West, K. D. (1987). A simple, positive semi-definite, heteroskedasticity and autocorrelation consistent covariance matrix. *Econometrica*, *55*(3), 703–708. https://doi.org/10.2307/1913610

**Notas:**
- Referencia para justificar corrección HAC en errores estándar.
- En Python: cov_type='HAC', maxlags=7
- Trendl et al. (2021) aplican esta corrección y confirman robustez de resultados.

---

### ONU1993
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** T — cita textual
**Citada en:** Cap. 5.1

**Referencia APA 7:**
Naciones Unidas. (1993). *Declaración sobre la eliminación de la violencia contra la mujer*. Resolución A/RES/48/104. https://www.un.org/es/

**Dato clave:** Definición operacional de violencia de género adoptada por la Asamblea General de la ONU.

**Notas:**
- Es cita textual — necesita número de página: (Naciones Unidas, 1993, p. X).
- Pendiente: localizar PDF oficial de la resolución para obtener número de página exacto.
- URL actual apunta a la página principal de ONU, buscar URL directa del documento.

---

### LGAMVLV2007
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** T/P — textual y paráfrasis
**Citada en:** Cap. 5.1, Cap. 4.1.2

**Referencia APA 7:**
Cámara de Diputados del H. Congreso de la Unión. (2007, 1 de febrero). *Ley General de Acceso de las Mujeres a una Vida Libre de Violencias*. Diario Oficial de la Federación. http://www.diputados.gob.mx/LeyesBiblio/pdf/LGAMVLV.pdf

**Dato clave:** Define los tipos de violencia (Arts. 6–10): psicológica, física, patrimonial, económica y sexual. Establece el mecanismo de Alerta de Violencia de Género (Art. 22).

**Notas:**
- Última reforma: diciembre 2024.
- Cambio de nombre: desde enero 2026 se denomina "Violencias" en plural.
- Para citas textuales indicar artículo: (Cámara de Diputados, 2007, Art. 6).
- Pendiente: verificar que el PDF del enlace corresponda a la versión con última reforma.

---





### GonzalezLozano2021
**Estado:** ✅ Verificada
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.1

**Referencia APA 7:**
González-Lozano, D. K., y Martínez-Pérez, Y. B. (2021). Mujeres, violencia e igualdad: una cuestión de derechos humanos. *Revista Política, Globalidad y Ciudadanía*, *7*(14), 103–125. https://doi.org/10.29105/pgc7.14-6

**Notas:**
- DOI verificado y activo.
- Institución: UANL — estratégico porque es de la misma universidad y enfoca NL.
- Acceso abierto en SciELO.
- Publicación: mayo 2021.

---

### Lagarde1990
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.1

**Referencia APA 7:**
Lagarde y de los Ríos, M. (1990). *Los cautiverios de las mujeres: madresposas, monjas, putas, presas y locas*. Universidad Nacional Autónoma de México.

**Notas:**
- Pendiente: verificar edición exacta — hay reimpresiones (2006, 2015).
- Consultar en biblioteca UANL o FCFM.
- Obra fundacional del feminismo académico mexicano. Cita obligada en tesinas de VG en México.

---

### Lagarde1996
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.1

**Referencia APA 7:**
Lagarde y de los Ríos, M. (1996). *Género y feminismo: desarrollo humano y democracia*. Horas y Horas.

**Notas:**
- Pendiente: verificar disponibilidad en biblioteca UANL o FCFM.
- Útil para distinguir "violencia doméstica" de "violencia de género" como conceptos distintos.

---

### Lagarde2012
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.2

**Referencia APA 7:**
Lagarde y de los Ríos, M. (2012). Las leyes de violencia de género en México: medidas de prevención y sensibilización. *REDUR*, *10*, 253–275.

**Notas:**
- ISSN: 1695-078X.
- URL a verificar: https://www.unirioja.es/dptos/dd/redur/numero10/lagarde.pdf
- Escrito por la propia impulsora de la LGAMVLV — fuente primaria sobre el proceso legislativo.

---

### Monarrez2010
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.1

**Referencia APA 7:**
Monárrez Fragoso, J. E. (2010). Violencia de género, violencia de pareja, feminicidio y pobreza. En J. E. Monárrez Fragoso (Ed.), *Violencia contra las mujeres e inseguridad ciudadana en Ciudad Juárez* (pp. 234–255). El Colegio de la Frontera Norte / Miguel Ángel Porrúa.

**Notas:**
- Pendiente: verificar páginas exactas del capítulo en el libro.
- Principal investigadora mexicana en feminicidio con metodología cuantitativa.

---

### Russell2006
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.1

**Referencia APA 7:**
Russell, D. E., y Harmes, R. A. (Eds.). (2006). *Feminicidio: una perspectiva global*. CEIICH-UNAM.

**Notas:**
- Pendiente: verificar en biblioteca UANL o CEIICH-UNAM.
- Diana Russell acuñó el término "feminicidio" en 1976.

---

### Mancinas2010
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.3, Cap. 4.1.4

**Referencia APA 7:**
Mancinas Espinoza, S. E., y Carbajal Rascón, M. G. (2010). Cambios y permanencias de la violencia familiar en Nuevo León. *Iberofórum. Revista de Ciencias Sociales de la Universidad Iberoamericana*, *V*(9), 49–68.

**Notas:**
- Redalyc. Pendiente: verificar URL activa.
- Uno de los primeros análisis cuantitativos de VF en NL con datos ENDIREH 2006.
- Útil para contexto histórico de la serie.

---

### OPS2013
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** D — dato numérico
**Citada en:** Cap. 4.1.1

**Referencia APA 7:**
Organización Panamericana de la Salud. (2013). *Violencia contra las mujeres en América Latina y el Caribe: análisis comparativo de datos poblacionales de 12 países*. OPS/OMS.

**Notas:**
- Pendiente: localizar URL del PDF original en paho.org.
- Dato a verificar: prevalencias de VG por país en la región (17%–53%).

---

### Orozco2020
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.1, Cap. 4.4

**Referencia APA 7:**
Orozco Vargas, A. E., Jiménez Figueroa, A., y Cudris-Torres, L. (2020). Violencia de género en Latinoamérica: estrategias para su prevención y erradicación. *Revista de Ciencias Sociales (Venezuela)*, *XXVI*(4). https://www.redalyc.org/journal/280/28065077021/html/

**Notas:**
- Redalyc. Pendiente: verificar número de páginas para completar la referencia.
- Revisión sistemática con metodología PRISMA.

---

### MexicoEvalua2021
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** D — dato numérico
**Citada en:** Cap. 4.1.4

**Referencia APA 7:**
México Evalúa. (2021, octubre). La violencia familiar aumentó 9% en Nuevo León; impunidad asciende al 93.9%. *México Evalúa — Programa de Justicia*. https://mexicoevalua.org/la-violencia-familiar-aumento-9-en-nuevo-leon-impunidad-asciende-al-93-9/

**Dato clave:** 92% de los delitos en NL no se denuncian. 93.9% de los investigados quedan impunes. 30.1% de carpetas son por delitos contra la familia.

**Notas:**
- Pendiente: verificar que la URL siga activa.
- Think tank de análisis de seguridad y justicia — fuente confiable pero no gubernamental.

---

### CienciaUANL2020
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 4.1.4

**Referencia APA 7:**
*(pendiente de completar — falta identificar autor(es))*
Ciencia UANL. (2020). Violencia familiar en Nuevo León en tiempos de COVID-19. *Ciencia UANL*. https://cienciauanl.uanl.mx/?p=10875

**Notas:**
- **URGENTE:** APA requiere autor si está disponible. Entrar al artículo y verificar si tiene autor identificado.
- Si no tiene autor, la referencia queda con el título primero: *Violencia familiar en Nuevo León...* (2020).
- Relevante para explicar COVID-19 como posible change point en la serie (2020).

---

### ConsejoCivico2021
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** D — dato numérico
**Citada en:** Cap. 4.1.3, Cap. 4.1.4

**Referencia APA 7:**
Consejo Cívico de Instituciones de Nuevo León. (2021, marzo). *Las víctimas de la violencia en Nuevo León tienen rostro*. https://consejocivico.org.mx/noticias/2021/03/08/las-victimas-de-violencia-tienen-rostro-en-nuevo-leon/

**Dato clave:** Solo 1.6% de los delitos denunciados en NL concluyeron con sentencia condenatoria. 67 víctimas de feminicidio en 2020.

**Notas:**
- Pendiente: verificar URL activa.
- Organización civil con datos de Fiscalía NL — no es fuente primaria, citar con cuidado.

---

### AVGMNL2016
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 2, Cap. 4.1.2

**Referencia APA 7:**
Gobierno del Estado de Nuevo León. (2016, 18 de noviembre). *Declaratoria de Alerta de Violencia de Género contra las Mujeres en el Estado de Nuevo León*. https://www.nl.gob.mx/es/alerta-de-violencia-de-genero-contra-las-mujeres

**Notas:**
- Pendiente: verificar URL activa y que corresponda al documento oficial.
- **Evento clave para el análisis CPD:** posible change point en la serie de tiempo en noviembre 2016.
- Municipios incluidos: Apodaca, Cadereyta Jiménez, Guadalupe, Juárez y Monterrey.
- Solicitud presentada por Arthemisas por la Equidad, A.C. en febrero 2015.

---

### Page1954
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5.3

**Referencia APA 7:**
Page, E. S. (1954). Continuous inspection schemes. *Biometrika*, *41*(1/2), 100–115.

**Notas:**
- Primera aplicación de CPD en control de calidad industrial.
- Ya citada en el docx original de la tesina.
- Pendiente: verificar DOI en JSTOR o Google Scholar.

---

### Truong2020
**Estado:** ✅ Verificada
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5.3, Cap. 6

**Referencia APA 7:**
Truong, C., Oudre, L., y Vayatis, N. (2020). Selective review of offline change point detection methods. *Signal Processing*, *167*, 107299. https://doi.org/10.1016/j.sigpro.2019.107299

**Notas:**
- DOI verificado y activo.
- Referencia metodológica principal para CPD offline.
- Ya citada en el docx original de la tesina.

---

### Aminikhanghahi2017
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5.3.2

**Referencia APA 7:**
Aminikhanghahi, S., y Cook, D. J. (2017). A survey of methods for time series change point detection. *Knowledge and Information Systems*, *51*(2), 339–367.

**Notas:**
- Pendiente: verificar DOI.
- Fuente para clasificación supervisado/no supervisado de métodos CPD.
- Ya citada en el docx original de la tesina.

---


---

### DamianFlores2018
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** P — paráfrasis
**Citada en:** Cap. 5.1, Cap. 2

**Referencia APA 7:**
Damián Bernal, A. L., y Flores, J. A. (2018). Feminicidios y políticas públicas: declaratorias de alertas de violencia de género en México, 2015–2017. *Perspectiva Geográfica*, *23*(2), 33–57.

**Notas:**
- Pendiente: verificar DOI y páginas exactas.
- Argumento: las respuestas gubernamentales a las alertas de género se ven afectadas por factores políticos.
- Ya citada en el docx original de la tesina.

---

### GonzalezBejarano2014
**Estado:** ⚠️ Pendiente de verificar
**Tipo:** T — cita textual
**Citada en:** Cap. 5.1

**Referencia APA 7:**
González, G. C., y Bejarano, R. C. (2014). La violencia de género: evolución, impacto y claves para su abordaje. *Enfermería Global*, *13*(1), 424–439.

**Dato clave:** "La violencia comprende también el maltrato psicológico, sexual, de aislamiento y control social, que suelen pasar mucho más desapercibidos."

**Notas:**
- Es cita textual — pendiente verificar número de página exacto.
- Ya citada en el docx original de la tesina.

---

## Resumen de estado

| Estado | Cantidad |
|---|:---:|
| ✅ Verificadas | 6 |
| ⚠️ Pendientes de verificar | 20 |
| ❌ No encontradas | 0 |
| **Total** | **26** |

---

## Pendientes urgentes

1. **CienciaUANL2020** — verificar si el artículo tiene autor(es) identificados antes de citar.
2. **ONU1993** — localizar PDF oficial para obtener número de página (cita textual).
3. **LGAMVLV2007** — verificar que el PDF corresponde a la versión con última reforma (dic. 2024).
4. **Lagarde1990 y Lagarde1996** — confirmar edición y disponibilidad en biblioteca UANL.
5. **Mancinas2010** — verificar URL activa en Redalyc.
6. **Rojido2018** — verificar DOI en Google Scholar.
7. **DatosAbiertosMonterrey2022** — verificar URL activa y anotar fecha exacta de descarga.
8. **GonzalezBejarano2014** — verificar número de página para la cita textual.

---

## Notas metodológicas generales

- Las referencias con `a` y `b` (INEGI2022a, INEGI2022b) son de la misma institución y año. En el texto: `(INEGI, 2022a)` y `(INEGI, 2022b)`.
- Toda cita textual requiere número de página: `(Autor, año, p. XX)`.
- Las fuentes de datos primarios (SESNSP, DatosAbiertosMonterrey) se citan en marco teórico **y** en metodología.
- Anotar siempre la fecha exacta de descarga de bases de datos en la sección de metodología.
- El año del SESNSP en la referencia debe ser el año en que descargaste los datos, no 2015.

---

*Norma: APA 7ª edición | Última revisión: mayo 2026*
