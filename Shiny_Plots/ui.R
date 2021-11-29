library(shiny)
library(DT)

shinyUI(fluidPage(
  titlePanel('Tarea Shiny Plots'),
  tabsetPanel(
    column(8,
           h2('Plots Interactivos'),
           fluidRow(
             plotOutput('plot2',
                        click = 'clk',
                        dblclick = 'dclk',
                        hover = 'mouse_hover',
                        brush = 'mouse_brush'
             ),
             
             #para limpiar el rango
             actionButton("limpiar_grph", "Limpiar"),
           )
    ),
    column(8,
           h2('Tabla DT'),
           DT::dataTableOutput('tabla_dt')
    )
  )
  
))