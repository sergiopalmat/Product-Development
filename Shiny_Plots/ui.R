library(shiny)

shinyUI(fluidPage(

  titlePanel("Shiny Plots"),
  plotOutput('plot',
             click = 'clk', 
             dblclick = 'dclk',
             hover = 'mouse_hover',
             brush = 'mouse_brush'
  ),
  DT::dataTableOutput('mtcars_tbl')
 
))
