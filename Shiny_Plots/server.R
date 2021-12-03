library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output, session) {
  
  plot.Colors <- reactiveValues(colVect = rep(1, nrow(mtcars)), preHoverColors = rep(1, nrow(mtcars)))

  observe({
    output$plot_click_option <- renderPlot({
      plot(mtcars$wt, mtcars$mpg, xlab = 'wt', ylab = 'Millas por galon', pch = 16, cex = 2.5, col = plot.Colors$colVect)
    })
  })
  
  observeEvent(input$mouse_hover,{
    plot.Colors$colVect <- plot.Colors$preHoverColors
    eventDots <- nearPoints(mtcars, input$mouse_hover, xvar = 'wt', yvar = 'mpg')
    filteredRowsIndex <- mtcars$wt == eventDots$wt & mtcars$mpg == eventDots$mpg
    plot.Colors$colVect[filteredRowsIndex] <- 8
  })
  
  observeEvent(input$click,{
    eventDots <- nearPoints(mtcars, input$click, xvar = 'wt', yvar = 'mpg')
    filteredRowsIndex <- mtcars$wt == eventDots$wt & mtcars$mpg == eventDots$mpg
    plot.Colors$colVect[filteredRowsIndex] <- 3
    plot.Colors$preHoverColors[filteredRowsIndex] <- 3
    output$mtcars_tbl_click <- renderTable({eventDots})
  })

  observeEvent(input$dclk,{
    eventDots <- nearPoints(mtcars, input$dclk, xvar = 'wt', yvar = 'mpg')
    filteredRowsIndex <- mtcars$wt == eventDots$wt & mtcars$mpg == eventDots$mpg
    plot.Colors$colVect[filteredRowsIndex] <- 1
    plot.Colors$preHoverColors[filteredRowsIndex] <- 1
    
  })

  observeEvent(input$mouse_brush,{
    eventDots <-  brushedPoints(mtcars, input$mouse_brush, xvar='wt', yvar = 'mpg')
    filteredRowsIndex <- mtcars$wt >= min(eventDots$wt) & mtcars$wt <= max(eventDots$wt) & mtcars$mpg >= min(eventDots$mpg) & mtcars$mpg <= max(mtcars$mpg)
    plot.Colors$colVect[filteredRowsIndex] <- 3
    plot.Colors$preHoverColors[filteredRowsIndex] <- 3
    
  })

  output$mtcars_tbl <- renderTable({
    df <- brushedPoints(mtcars, input$mouse_brush, xvar='wt', yvar = 'mpg')
    df
  })
  
})
