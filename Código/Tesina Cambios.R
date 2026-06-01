# =============================================================================
# Tesina: Detección de Puntos de Cambio en Serie de Tiempo de Reportes de
#         Violencia de Género en Monterrey
# Autor:  Luis Enrique López Nerio
# =============================================================================


# =============================================================================
# 0. LIBRERÍAS Y CONFIGURACIÓN
# =============================================================================

library(fpp3)
library(tidyverse)
library(DataExplorer)
library(ggplot2)
library(changepoint)
library(changepoint.np)
library(EnvCpt)
library(prophet)

ruta_completa <- "../Datos/Datos.csv"


# =============================================================================
# 1. CARGA DE DATOS
# =============================================================================

datos <- read_csv(
  ruta_completa,
  col_names = TRUE,
  col_types = cols(fecha = col_date("%d/%m/%Y")),
  locale = locale(encoding = "latin1")
)


# =============================================================================
# 2. ANÁLISIS EXPLORATORIO (EDA)
# =============================================================================

# --- 2.1 Resumen general --------------------------------------------------

datos %>% summarise(
  total_reportes   = n(),
  colonias_unicas  = n_distinct(colonia),
  tipos_unicos     = n_distinct(descripcion_tipo),
  fecha_inicio     = min(fecha),
  fecha_fin        = max(fecha)
)

# --- 2.2 Reportes por tipo de llamada ------------------------------------

tipo_llamada <- datos %>%
  group_by(descripcion_tipo) %>%
  summarise(num_llamadas = n()) %>%
  arrange(desc(num_llamadas))

tipo_llamada

ggplot(tipo_llamada, aes(y = reorder(descripcion_tipo, num_llamadas),
                         x = num_llamadas,
                         fill = descripcion_tipo)) +
  geom_bar(stat = "identity", color = "black") +
  geom_text(aes(label = num_llamadas), hjust = -0.1, size = 3.5) +
  scale_fill_brewer(palette = "Dark2") +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(x = "# de llamadas", y = "Tipo de reporte",
       title = "Reportes al 911 por tipo de llamada",
       subtitle = "Municipio de Monterrey, enero 2017 – septiembre 2022")

# --- 2.3 Reportes por descripción de cierre ------------------------------

cierre_llamada <- datos %>%
  group_by(descripcion_cierre) %>%
  summarise(num_llamadas = n()) %>%
  arrange(desc(num_llamadas))

cierre_llamada

datos %>%
  group_category("descripcion_cierre", threshold = 0.00015, update = TRUE) %>%
  group_by(descripcion_cierre) %>%
  summarise(num_llamadas = n()) %>%
  arrange(desc(num_llamadas)) %>%
  ggplot(aes(y = reorder(descripcion_cierre, num_llamadas),
             x = num_llamadas,
             fill = descripcion_cierre)) +
  geom_bar(stat = "identity", color = "black") +
  geom_text(aes(label = num_llamadas), hjust = -0.1, size = 3.5) +
  scale_fill_brewer(palette = "Dark2") +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(x = "# de llamadas", y = "Cierre del reporte",
       title = "Reportes al 911 por tipo de cierre",
       subtitle = "Municipio de Monterrey, enero 2017 – septiembre 2022")

# --- 2.4 Reportes por colonia (top 20) -----------------------------------

datos %>%
  group_by(colonia) %>%
  summarise(num_llamadas = n()) %>%
  arrange(desc(num_llamadas)) %>%
  slice_head(n = 20)


# =============================================================================
# 3. CONSTRUCCIÓN DE SERIES DE TIEMPO
# =============================================================================

# --- 3.1 Serie diaria -----------------------------------------------------

serie_tiempo_dias <- datos %>%
  select(fecha) %>%
  group_by(fecha) %>%
  summarise(llamadas = n()) %>%
  as_tsibble()

# --- 3.2 Serie semanal ----------------------------------------------------

serie_tiempo_semana <- datos %>%
  mutate(semana = yearweek(fecha)) %>%
  select(semana) %>%
  group_by(semana) %>%
  summarise(llamadas = n()) %>%
  as_tsibble()

# --- 3.3 Serie mensual ----------------------------------------------------

serie_tiempo_mes <- datos %>%
  mutate(mes = yearmonth(fecha)) %>%
  select(mes) %>%
  group_by(mes) %>%
  summarise(llamadas = n()) %>%
  as_tsibble()

# --- 3.4 Visualización de las tres escalas temporales --------------------

serie_tiempo_dias %>%
  autoplot(llamadas) +
  labs(y = "# de reportes", x = "Día",
       title = "Serie de tiempo diaria",
       subtitle = "Reportes de VG al 911, Monterrey 2017-2022")

serie_tiempo_semana %>%
  autoplot(llamadas, colour = "firebrick") +
  labs(y = "# de reportes", x = "Semana",
       title = "Serie de tiempo semanal",
       subtitle = "Reportes de VG al 911, Monterrey 2017-2022")

serie_tiempo_mes %>%
  autoplot(llamadas) +
  labs(y = "# de reportes", x = "Mes",
       title = "Serie de tiempo mensual",
       subtitle = "Reportes de VG al 911, Monterrey 2017-2022")


# =============================================================================
# 4. ANÁLISIS DE LA SERIE — NORMALIDAD Y PRIMERAS DIFERENCIAS
# =============================================================================

# --- 4.1 ACF, PACF y estructura de la serie semanal ----------------------

serie_tiempo_semana %>%
  gg_tsdisplay(llamadas, plot_type = "partial") +
  labs(title = "Serie semanal — ACF y PACF")

# --- 4.2 Primeras diferencias de la serie semanal -------------------------

serie_tiempo_semana %>%
  gg_tsdisplay(difference(llamadas), plot_type = "partial") +
  labs(title = "Primeras diferencias — serie semanal")

# --- 4.3 Prueba de normalidad (Shapiro-Wilk) ------------------------------

# Serie semanal original
shapiro.test(serie_tiempo_semana$llamadas)

# Primeras diferencias semanal
llamadas_lag_vector <- difference(serie_tiempo_semana$llamadas)
llamadas_lag_vector <- llamadas_lag_vector[!is.na(llamadas_lag_vector)]

shapiro.test(llamadas_lag_vector)

# Histogramas comparativos
par(mfrow = c(1, 2))
hist(serie_tiempo_semana$llamadas,
     main = "Serie semanal original",
     xlab = "Llamadas por semana", col = "steelblue")
hist(llamadas_lag_vector,
     main = "Primeras diferencias",
     xlab = "Diferencia semanal", col = "firebrick")
par(mfrow = c(1, 1))


# =============================================================================
# 5. DETECCIÓN DE PUNTOS DE CAMBIO
# =============================================================================

# Vectores de trabajo
llamadas          <- serie_tiempo_semana$llamadas
llamadas_diarias  <- serie_tiempo_dias$llamadas
llamadas_lag      <- llamadas_lag_vector   # ya limpio de NAs (sección 4.3)

# --- 5.1 PELT — Media y varianza (MBIC) — serie semanal -------------------
# Nota: se aplica sobre la serie original con fines exploratorios.
# Los supuestos de normalidad no se cumplen plenamente en esta serie.

pelt_semanal <- cpt.meanvar(
  llamadas,
  test.stat = "Normal",
  method    = "PELT",
  minseglen = 12,
  penalty   = "MBIC"
)

cpts(pelt_semanal)
plot(pelt_semanal, cpt.width = 3, cpt.col = "blue",
     main = "PELT — Media y varianza — Serie semanal (MBIC)")

# --- 5.2 PELT — Varianza — primeras diferencias (MBIC) -------------------
# Serie que cumple supuesto de normalidad (Shapiro-Wilk, sección 4.3)

pelt_lag_var <- cpt.var(
  llamadas_lag,
  test.stat = "Normal",
  method    = "PELT",
  minseglen = 12,
  penalty   = "MBIC"
)

cpts(pelt_lag_var)
plot(pelt_lag_var, cpt.width = 3, cpt.col = "blue",
     main = "PELT — Varianza — Primeras diferencias (MBIC)")

# --- 5.3 CROPS — Selección de penalización óptima -------------------------
# Permite explorar el número de changepoints según distintas penalizaciones

pelt_crops_meanvar <- cpt.meanvar(
  llamadas_lag,
  method    = "PELT",
  penalty   = "CROPS",
  pen.value = c(5, 500),
  minseglen = 12
)

cpts.full(pelt_crops_meanvar)
plot(pelt_crops_meanvar, diagnostic = TRUE,
     main = "CROPS — Diagnóstico de penalización")

# Modelos con distinto número de changepoints
plot(pelt_crops_meanvar, ncpts = 1, cpt.width = 3, cpt.col = "blue",
     main = "CROPS — 1 changepoint")
plot(pelt_crops_meanvar, ncpts = 2, cpt.width = 3, cpt.col = "blue",
     main = "CROPS — 2 changepoints")
plot(pelt_crops_meanvar, ncpts = 4, cpt.width = 3, cpt.col = "blue",
     main = "CROPS — 4 changepoints")

# --- 5.4 EnvCpt — Selección automática de modelo -------------------------
# Compara automáticamente múltiples modelos (tendencia, AR, changepoints)

envcpt_semanal <- EnvCpt::envcpt(llamadas)
plot(envcpt_semanal,
     main = "EnvCpt — Comparación de modelos (serie semanal)")
plot(envcpt_semanal, type = "bic",
     main = "EnvCpt — Selección por BIC (serie semanal)")

# --- 5.5 CPD No Paramétrico -----------------------------------------------
# No requiere supuesto de normalidad

# Sobre la serie semanal original
pelt_np_semanal <- cpt.np(
  llamadas,
  method     = "PELT",
  minseglen  = 12,
  nquantiles = 4 * log(length(llamadas))
)

cpts(pelt_np_semanal)
plot(pelt_np_semanal,
     main = "PELT No Paramétrico — Serie semanal")

# Sobre las primeras diferencias
pelt_np_lag <- cpt.np(
  llamadas_lag,
  method     = "PELT",
  minseglen  = 12,
  nquantiles = 4 * log(length(llamadas_lag))
)

cpts(pelt_np_lag)
plot(pelt_np_lag,
     main = "PELT No Paramétrico — Primeras diferencias")

# --- 5.6 Prophet — Changepoints en tendencia --------------------------------
# Aplicado sobre serie diaria. Controla estacionalidad semanal y anual.

serie_prophet <- data.frame(
  ds = serie_tiempo_dias$fecha,
  y  = serie_tiempo_dias$llamadas
)

modelo_prophet <- prophet(serie_prophet)

future_prophet <- make_future_dataframe(modelo_prophet, periods = 0)
forecast_prophet <- predict(modelo_prophet, future_prophet)

plot(modelo_prophet, forecast_prophet) +
  add_changepoints_to_plot(modelo_prophet) +
  labs(title = "Prophet — Changepoints en tendencia",
       subtitle = "Serie diaria de reportes de VG al 911, Monterrey 2017-2022")

prophet_plot_components(modelo_prophet, forecast_prophet)


# =============================================================================
# 6. CONSOLIDACIÓN DE RESULTADOS
# =============================================================================

# Fechas de inicio de la serie semanal (para convertir índices a fechas)
fechas_semana <- as.Date(serie_tiempo_semana$semana)

# Función auxiliar para convertir índices a fechas
idx_a_fecha <- function(indices, fechas) {
  if (length(indices) == 0) return(data.frame(indice = integer(), fecha = Date()))
  data.frame(
    indice = indices,
    fecha  = fechas[indices]
  )
}

# Tabla de changepoints por método
resultados <- list(
  PELT_MBIC_Semanal    = idx_a_fecha(cpts(pelt_semanal),     fechas_semana),
  PELT_Var_Lag         = idx_a_fecha(cpts(pelt_lag_var),     fechas_semana[-1]),
  PELT_NP_Semanal      = idx_a_fecha(cpts(pelt_np_semanal),  fechas_semana),
  PELT_NP_Lag          = idx_a_fecha(cpts(pelt_np_lag),      fechas_semana[-1])
)

# Mostrar resultados de cada método
for (nombre in names(resultados)) {
  cat("\n---", nombre, "---\n")
  print(resultados[[nombre]])
}

# Changepoints de Prophet
cat("\n--- Prophet (serie diaria) ---\n")
print(modelo_prophet$changepoints)