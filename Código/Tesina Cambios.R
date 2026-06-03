# =============================================================================
# PANEL EJECUTIVO SUPERSTORE
# Stack: shiny + bslib (Bootstrap 5, claro) | echarts4r | reactable | dplyr + lubridate
# Estética: paleta editorial "The Economist"
# Archivo único: app.R
# =============================================================================

# ---- 0. Librerías ----------------------------------------------------------
library(shiny)
library(bslib)        # tema Bootstrap 5
library(echarts4r)    # TODOS los gráficos
library(reactable)    # tablas
library(dplyr)        # transformaciones
library(lubridate)    # manejo de fechas
library(readr)        # lectura rápida del CSV
library(scales)       # formateo de números/moneda
library(htmltools)    # helpers de HTML para reactable / KPIs

# =============================================================================
# 1. PALETA "THE ECONOMIST" ---------------------------------------------------
# =============================================================================
ECON <- list(
  bg          = "#F9F6F0",
  panel       = "#FFFFFF",
  red         = "#E3120B",
  blue        = "#006BA2",
  blue_light  = "#A8C8E8",
  amber       = "#F5A623",
  text        = "#121212",
  text_muted  = "#5A5A5A",
  border      = "#D9D9D9"
)

CHART_PALETTE <- c(ECON$red, ECON$blue, ECON$blue_light, ECON$amber)

# =============================================================================
# 2. CARGA Y LIMPIEZA DE DATOS ------------------------------------------------
# =============================================================================
DATA_FILE <- if (file.exists("Sample - Superstore.csv")) {
  "Sample - Superstore.csv"
} else {
  "Sample_-_Superstore.csv"
}

superstore <- read_csv(
  DATA_FILE,
  show_col_types = FALSE,
  locale = locale(encoding = "Latin1")
) %>%
  rename(
    Fecha_Pedido = `Order Date`,
    Fecha_Envio = `Ship Date`,
    Region = Region,
    Segmento = Segment,
    Categoria = Category,
    Subcategoria = `Sub-Category`,
    Ventas = Sales,
    Beneficio = Profit,
    Cantidad = Quantity,
    Descuento = Discount,
    ID_Pedido = `Order ID`,
    ID_Cliente = `Customer ID`,
    Nombre_Cliente = `Customer Name`,
    Nombre_Producto = `Product Name`
  ) %>%
  mutate(
    Fecha_Pedido = mdy(Fecha_Pedido),
    Fecha_Envio  = mdy(Fecha_Envio),
    Mes_Pedido   = floor_date(Fecha_Pedido, "month"),
    Ventas       = as.numeric(Ventas),
    Beneficio    = as.numeric(Beneficio),
    Cantidad     = as.numeric(Cantidad),
    Descuento    = as.numeric(Descuento)
  ) %>%
  filter(!is.na(Fecha_Pedido))

FECHA_MIN   <- min(superstore$Fecha_Pedido, na.rm = TRUE)
FECHA_MAX   <- max(superstore$Fecha_Pedido, na.rm = TRUE)
REGIONES    <- sort(unique(superstore$Region))
SEGMENTOS   <- sort(unique(superstore$Segmento))
CATEGORIAS  <- sort(unique(superstore$Categoria))

# =============================================================================
# 3. FUNCIONES AUXILIARES DE FORMATEO -----------------------------------------
# =============================================================================
fmt_dinero <- function(x) paste0("$", comma(round(x), accuracy = 1))
fmt_pct   <- function(x) paste0(round(x, 1), "%")
fmt_entero <- function(x) comma(round(x))

# =============================================================================
# 4. TEMA bslib Y CSS ---------------------------------------------------------
# =============================================================================
tema_econ <- bs_theme(
  version       = 5,
  bg            = ECON$bg,
  fg            = ECON$text,
  primary       = ECON$red,
  secondary     = ECON$blue,
  base_font     = font_collection(font_google("Arial", local = FALSE), "Arial", "sans-serif"),
  heading_font  = font_collection("Georgia", "serif"),
  "border-color" = ECON$border
)

css_personalizado <- sprintf("
  body { background-color: %s; color: %s; }
  .app-header { background: %s; border-bottom: 3px solid %s; padding: 14px 24px 12px 24px; margin-bottom: 0; }
  .app-header .app-title { font-family: Georgia, serif; font-weight: 700; font-size: 26px; color: %s; margin: 0; letter-spacing: -0.3px; }
  .app-header .app-sub { font-family: Arial, sans-serif; font-size: 13px; color: %s; margin: 2px 0 0 0; }
  .app-header .masthead-tag { display: inline-block; background: %s; color: #fff; font-family: Arial, sans-serif; font-weight: 700; font-size: 11px; letter-spacing: 1px; text-transform: uppercase; padding: 3px 9px; margin-bottom: 6px; }
  .kpi-card { background: %s; border: 1px solid %s; border-left: 4px solid %s; padding: 14px 18px; height: 100%%; }
  .kpi-label { font-family: Arial, sans-serif; font-size: 12px; text-transform: uppercase; letter-spacing: 0.6px; color: %s; margin-bottom: 6px; }
  .kpi-value { font-family: Georgia, serif; font-size: 30px; font-weight: 700; color: %s; line-height: 1.05; }
  .kpi-sub { font-family: Arial, sans-serif; font-size: 12px; color: %s; margin-top: 4px; }
  .panel-card { background: %s; border: 1px solid %s; padding: 16px 18px 10px 18px; height: 100%%; }
  .panel-title { font-family: Georgia, serif; font-size: 16px; font-weight: 700; color: %s; margin: 0 0 2px 0; }
  .panel-desc { font-family: Arial, sans-serif; font-size: 12px; color: %s; margin: 0 0 12px 0; border-bottom: 1px solid %s; padding-bottom: 8px; }
  .filter-title { font-family: Georgia, serif; font-weight: 700; font-size: 15px; color: %s; border-bottom: 2px solid %s; padding-bottom: 6px; margin-bottom: 14px; }
  .nav-tabs .nav-link { font-family: Arial, sans-serif; font-weight: 700; font-size: 13px; color: %s; border: none; border-bottom: 3px solid transparent; border-radius: 0; }
  .nav-tabs .nav-link.active { color: %s; background: transparent; border-bottom: 3px solid %s; }
  .nav-tabs { border-bottom: 1px solid %s; }
  .ReactTable, .rt-table { font-family: Arial, sans-serif; font-size: 13px; }
  /* Ajuste visual para los checkboxes */
  .form-check-label { font-size: 13px; }
",
                             ECON$bg, ECON$text, ECON$panel, ECON$red, ECON$text, ECON$text_muted, ECON$red,
                             ECON$panel, ECON$border, ECON$red, ECON$text_muted, ECON$text, ECON$text_muted,
                             ECON$panel, ECON$border, ECON$text, ECON$text_muted, ECON$border,
                             ECON$text, ECON$red, ECON$text_muted, ECON$red, ECON$red, ECON$border
)

tarjeta_kpi <- function(etiqueta, valor_output, sub_output = NULL) {
  div(class = "kpi-card",
      div(class = "kpi-label", etiqueta), div(class = "kpi-value", valor_output),
      if (!is.null(sub_output)) div(class = "kpi-sub", sub_output)
  )
}

tarjeta_panel <- function(titulo, desc, ...) {
  div(class = "panel-card", div(class = "panel-title", titulo), div(class = "panel-desc", desc), ...)
}

# =============================================================================
# 7. INTERFAZ (UI) ------------------------------------------------------------
# =============================================================================
ui <- page_fluid(
  theme = tema_econ,
  tags$head(tags$style(HTML(css_personalizado))),
  
  div(class = "app-header",
      span(class = "masthead-tag", "Superstore"),
      h1(class = "app-title", "Panel Ejecutivo de Ventas"),
      p(class = "app-sub", "Rendimiento comercial · ingresos, rentabilidad y clientes")
  ),
  
  layout_sidebar(
    sidebar = sidebar(
      width = 280,
      bg = ECON$panel,
      div(class = "filter-title", "Filtros Globales"),
      
      dateRangeInput(
        "f_fechas", "Rango de fechas",
        start = FECHA_MIN, end = FECHA_MAX,
        min = FECHA_MIN, max = FECHA_MAX,
        format = "dd/mm/yyyy", separator = " – "
      ),
      
      # Cambiados a Checkboxes
      checkboxGroupInput("f_region", "Región", choices = REGIONES, selected = REGIONES),
      checkboxGroupInput("f_segmento", "Segmento", choices = SEGMENTOS, selected = SEGMENTOS),
      checkboxGroupInput("f_categoria", "Categoría", choices = CATEGORIAS, selected = CATEGORIAS),
      
      hr(style = sprintf("border-color:%s;", ECON$border)),
      actionButton("reset", "Restablecer Filtros", class = "btn btn-outline-secondary btn-sm w-100"),
      div(style = sprintf("font-size:11px;color:%s;margin-top:14px;", ECON$text_muted),
          textOutput("conteo_filas"))
    ),
    
    navset_tab(
      nav_panel("Resumen Ejecutivo",
                div(style = "padding-top:16px;"),
                layout_columns(
                  col_widths = c(2, 2, 3, 2, 3),
                  tarjeta_kpi("Ingresos Totales", textOutput("kpi_ingresos", inline = TRUE)),
                  tarjeta_kpi("Beneficio Total",  textOutput("kpi_beneficio", inline = TRUE)),
                  tarjeta_kpi("Margen de Benef.", textOutput("kpi_margen", inline = TRUE), "Beneficio / Ingresos"),
                  tarjeta_kpi("Pedidos Totales",  textOutput("kpi_pedidos", inline = TRUE), "IDs únicos"),
                  tarjeta_kpi("Valor Prom. Pedido", textOutput("kpi_vpp", inline = TRUE), "Ingresos / Pedido")
                ),
                div(style = "height:16px;"),
                layout_columns(
                  col_widths = 12,
                  tarjeta_panel("Ingresos y Beneficio Mensual", "Evolución en el tiempo",
                                echarts4rOutput("graf_tendencia", height = "320px"))
                ),
                div(style = "height:16px;"),
                layout_columns(
                  col_widths = c(7, 5),
                  tarjeta_panel("Top 10 Subcategorías (Ingresos)", "Ingresos acumulados",
                                echarts4rOutput("graf_subcat", height = "360px")),
                  tarjeta_panel("Ingresos por Segmento", "Distribución del cliente",
                                echarts4rOutput("graf_segmento", height = "360px"))
                ),
                div(style = "height:24px;")
      ),
      
      nav_panel("Región y Categoría",
                div(style = "padding-top:16px;"),
                layout_columns(
                  col_widths = c(5, 7),
                  tarjeta_panel("Beneficio: Región × Categoría", "Mapa de calor de rentabilidad",
                                echarts4rOutput("graf_calor", height = "340px")),
                  tarjeta_panel("Ventas por Región y Categoría", "Gráfico de barras apiladas",
                                echarts4rOutput("graf_apilado", height = "340px"))
                ),
                div(style = "height:16px;"),
                layout_columns(
                  col_widths = 12,
                  tarjeta_panel("Descuento vs Beneficio por Pedido", "Relación y dispersión por categoría",
                                echarts4rOutput("graf_dispersion", height = "380px"))
                ),
                div(style = "height:24px;")
      ),
      
      nav_panel("Clientes y Productos",
                div(style = "padding-top:16px;"),
                layout_columns(
                  col_widths = c(3, 3, 3, 3),
                  tarjeta_kpi("Clientes Únicos", textOutput("kpi_clientes", inline = TRUE)),
                  tarjeta_kpi("Ingresos / Cliente", textOutput("kpi_ing_cliente", inline = TRUE), "Promedio"),
                  tarjeta_kpi("Pedidos / Cliente", textOutput("kpi_ped_cliente", inline = TRUE), "Promedio"),
                  tarjeta_kpi("Productos Vendidos", textOutput("kpi_productos", inline = TRUE), "Únicos")
                ),
                div(style = "height:16px;"),
                layout_columns(
                  col_widths = c(7, 5),
                  tarjeta_panel("Top 20 Clientes por Ingresos", "Ranking de mayor facturación",
                                reactableOutput("tabla_clientes")),
                  tarjeta_panel("Top 10 Productos por Ingresos", "Mayor volumen de ventas",
                                echarts4rOutput("graf_productos", height = "460px"))
                ),
                div(style = "height:24px;")
      )
    )
  )
)

# =============================================================================
# 8. SERVIDOR (SERVER) --------------------------------------------------------
# =============================================================================
server <- function(input, output, session) {
  
  filtrado <- reactive({
    req(input$f_fechas) 
    
    # Manejo seguro: si un checkbox se desmarca por completo, devuelve NULL.
    # En ese caso, detenemos la evaluación y devolvemos 0 filas.
    if (is.null(input$f_region) || is.null(input$f_segmento) || is.null(input$f_categoria)) {
      return(superstore %>% filter(FALSE))
    }
    
    superstore %>%
      filter(
        Fecha_Pedido >= input$f_fechas[1],
        Fecha_Pedido <= input$f_fechas[2],
        Region %in% input$f_region,
        Segmento %in% input$f_segmento,
        Categoria %in% input$f_categoria
      )
  })
  
  observeEvent(input$reset, {
    updateDateRangeInput(session, "f_fechas", start = FECHA_MIN, end = FECHA_MAX)
    # Actualizado a updateCheckboxGroupInput
    updateCheckboxGroupInput(session, "f_region",    selected = REGIONES)
    updateCheckboxGroupInput(session, "f_segmento",  selected = SEGMENTOS)
    updateCheckboxGroupInput(session, "f_categoria", selected = CATEGORIAS)
  })
  
  output$conteo_filas <- renderText({
    paste0(fmt_entero(nrow(filtrado())), " filas seleccionadas")
  })
  
  # ===========================================================================
  # Lógica de Gráficos (Sin cambios)
  # ===========================================================================
  output$kpi_ingresos <- renderText(fmt_dinero(sum(filtrado()$Ventas, na.rm = TRUE)))
  output$kpi_beneficio <- renderText(fmt_dinero(sum(filtrado()$Beneficio, na.rm = TRUE)))
  output$kpi_margen   <- renderText({
    df <- filtrado()
    ing <- sum(df$Ventas, na.rm = TRUE)
    fmt_pct(if (ing > 0) 100 * sum(df$Beneficio, na.rm = TRUE) / ing else 0)
  })
  output$kpi_pedidos  <- renderText(fmt_entero(n_distinct(filtrado()$ID_Pedido)))
  output$kpi_vpp      <- renderText({
    df <- filtrado()
    n  <- n_distinct(df$ID_Pedido)
    fmt_dinero(if (n > 0) sum(df$Ventas, na.rm = TRUE) / n else 0)
  })
  
  output$graf_tendencia <- renderEcharts4r({
    filtrado() %>%
      group_by(Mes_Pedido) %>%
      summarise(Ingresos = sum(Ventas, na.rm = TRUE), Beneficio = sum(Beneficio, na.rm = TRUE), .groups = "drop") %>%
      arrange(Mes_Pedido) %>%
      mutate(Mes = format(Mes_Pedido, "%Y-%m")) %>%
      e_charts(Mes) %>%
      e_line(Ingresos, smooth = FALSE, symbol = "circle", symbolSize = 5) %>%
      e_line(Beneficio, smooth = FALSE, symbol = "circle", symbolSize = 5) %>%
      e_color(c(ECON$red, ECON$blue)) %>%
      e_tooltip(trigger = "axis", formatter = e_tooltip_pointer_formatter("currency", digits = 0)) %>%
      e_y_axis(formatter = e_axis_formatter("currency", digits = 0)) %>%
      e_x_axis(axisLabel = list(rotate = 45)) %>%
      e_legend(top = 0) %>%
      e_grid(left = "12%", right = "4%", bottom = "18%")
  })
  
  output$graf_subcat <- renderEcharts4r({
    filtrado() %>%
      group_by(Subcategoria) %>%
      summarise(Ingresos = sum(Ventas, na.rm = TRUE), .groups = "drop") %>%
      arrange(desc(Ingresos)) %>%
      slice_head(n = 10) %>%
      arrange(Ingresos) %>%
      e_charts(Subcategoria) %>%
      e_bar(Ingresos, itemStyle = list(color = ECON$red)) %>%
      e_flip_coords() %>%
      e_legend(show = FALSE) %>%
      e_x_axis(formatter = e_axis_formatter("currency", digits = 0)) %>%
      e_tooltip(formatter = e_tooltip_item_formatter("currency", digits = 0)) %>%
      e_grid(left = "22%", right = "8%")
  })
  
  output$graf_segmento <- renderEcharts4r({
    filtrado() %>%
      group_by(Segmento) %>%
      summarise(Ingresos = sum(Ventas, na.rm = TRUE), .groups = "drop") %>%
      e_charts(Segmento) %>%
      e_pie(Ingresos, radius = c("45%", "70%"), label = list(formatter = "{b}\n{d}%")) %>%
      e_color(CHART_PALETTE) %>%
      e_tooltip(formatter = e_tooltip_item_formatter("currency", digits = 0)) %>%
      e_legend(bottom = 0)
  })
  
  output$graf_calor <- renderEcharts4r({
    hm <- filtrado() %>%
      group_by(Region, Categoria) %>%
      summarise(Beneficio = sum(Beneficio, na.rm = TRUE), .groups = "drop")
    
    if (nrow(hm) == 0) return(e_charts() %>% e_empty("Sin datos"))
    rng <- range(hm$Beneficio, na.rm = TRUE)
    
    hm %>%
      e_charts(Region) %>%
      e_heatmap(Categoria, Beneficio, label = list(show = TRUE,
                                                   formatter = htmlwidgets::JS("function(p){ return '$' + Math.round(p.value[2]).toLocaleString(); }"))) %>%
      e_visual_map(Beneficio, min = rng[1], max = rng[2],
                   inRange = list(color = c(ECON$blue, ECON$blue_light, "#FFFFFF", "#F6B0AD", ECON$red)),
                   orient = "horizontal", left = "center", bottom = 0) %>%
      e_tooltip() %>%
      e_grid(top = "10%", bottom = "22%")
  })
  
  output$graf_apilado <- renderEcharts4r({
    filtrado() %>%
      group_by(Categoria, Region) %>%
      summarise(Ventas = sum(Ventas, na.rm = TRUE), .groups = "drop") %>%
      group_by(Categoria) %>%
      e_charts(Region) %>%
      e_bar(Ventas, stack = "total") %>%
      e_color(CHART_PALETTE) %>%
      e_y_axis(formatter = e_axis_formatter("currency", digits = 0)) %>%
      e_tooltip(trigger = "axis") %>%
      e_legend(top = 0) %>%
      e_grid(left = "14%", right = "4%", top = "14%")
  })
  
  output$graf_dispersion <- renderEcharts4r({
    filtrado() %>%
      group_by(Categoria) %>%
      e_charts(Descuento) %>%
      e_scatter(Beneficio, symbolSize = 6) %>%
      e_color(CHART_PALETTE) %>%
      e_x_axis(name = "Descuento", axisLabel = list(formatter = "{value}")) %>%
      e_y_axis(name = "Beneficio", formatter = e_axis_formatter("currency", digits = 0)) %>%
      e_tooltip() %>%
      e_legend(top = 0) %>%
      e_grid(left = "12%", right = "4%", top = "12%")
  })
  
  output$kpi_clientes <- renderText(fmt_entero(n_distinct(filtrado()$ID_Cliente)))
  output$kpi_productos <- renderText(fmt_entero(n_distinct(filtrado()$Nombre_Producto)))
  output$kpi_ing_cliente <- renderText({
    df <- filtrado(); n <- n_distinct(df$ID_Cliente)
    fmt_dinero(if (n > 0) sum(df$Ventas, na.rm = TRUE) / n else 0)
  })
  output$kpi_ped_cliente <- renderText({
    df <- filtrado(); n <- n_distinct(df$ID_Cliente)
    round(if (n > 0) n_distinct(df$ID_Pedido) / n else 0, 1)
  })
  
  output$tabla_clientes <- renderReactable({
    tbl <- filtrado() %>%
      group_by(Nombre_Cliente, Segmento) %>%
      summarise(Pedidos = n_distinct(ID_Pedido), Ingresos = sum(Ventas, na.rm = TRUE),
                Beneficio = sum(Beneficio, na.rm = TRUE), .groups = "drop") %>%
      mutate(Margen = ifelse(Ingresos > 0, 100 * Beneficio / Ingresos, 0)) %>%
      arrange(desc(Ingresos)) %>% slice_head(n = 20)
    
    reactable(tbl, defaultPageSize = 10, highlight = TRUE, compact = TRUE, borderless = FALSE,
              defaultSorted = list(Ingresos = "desc"),
              theme = reactableTheme(
                headerStyle = list(fontFamily = "Arial", fontSize = "12px", textTransform = "uppercase",
                                   letterSpacing = "0.5px", color = ECON$text_muted,
                                   borderBottom = paste0("2px solid ", ECON$red)),
                borderColor = ECON$border
              ),
              columns = list(
                Nombre_Cliente = colDef(name = "Cliente", minWidth = 160),
                Segmento = colDef(minWidth = 100),
                Pedidos  = colDef(align = "right", maxWidth = 90),
                Ingresos = colDef(align = "right", cell = function(v) fmt_dinero(v), style = list(fontWeight = 600)),
                Beneficio = colDef(align = "right", cell = function(v) fmt_dinero(v),
                                   style = function(v) list(color = if (v < 0) ECON$red else ECON$text)),
                Margen   = colDef(name = "Margen %", align = "right", cell = function(v) fmt_pct(v),
                                  style = function(v) list(color = if (v < 0) ECON$red else ECON$blue))
              )
    )
  })
  
  output$graf_productos <- renderEcharts4r({
    filtrado() %>%
      group_by(Nombre_Producto) %>%
      summarise(Ingresos = sum(Ventas, na.rm = TRUE), .groups = "drop") %>%
      arrange(desc(Ingresos)) %>%
      slice_head(n = 10) %>%
      mutate(Producto = ifelse(nchar(Nombre_Producto) > 38,
                               paste0(substr(Nombre_Producto, 1, 38), "…"), Nombre_Producto)) %>%
      arrange(Ingresos) %>%
      e_charts(Producto) %>%
      e_bar(Ingresos, itemStyle = list(color = ECON$blue)) %>%
      e_flip_coords() %>%
      e_legend(show = FALSE) %>%
      e_x_axis(formatter = e_axis_formatter("currency", digits = 0)) %>%
      e_tooltip(formatter = e_tooltip_item_formatter("currency", digits = 0)) %>%
      e_grid(left = "40%", right = "8%")
  })
}

shinyApp(ui, server)