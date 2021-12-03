library(shiny)

shinyUI(fluidPage(

  titlePanel("Shiny Plots"),
  
  plotOutput('plot_click_option',
             click = 'click',
             dblclick = 'dclk',
             hover = 'mouse_hover',
             brush = 'mouse_brush'
  ),

  tableOutput('mtcars_tbl_click'),
  tableOutput('mtcars_tbl'),
  
))
