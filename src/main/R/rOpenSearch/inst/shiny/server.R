library(shiny)
library(RCurl)
library(XML)
library(stringr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  dataInput <- reactive({ 
  
    if(input$get == 0) return(NULL)
    
    value <- c(100, as.Date(input$dates[1]), input$dates[2])
    type <- c("count", "time:start", "time:end")
    df.params <- data.frame(type, value)
    return(df.params)
  })

  output$osd.url <- renderText({
  
     if(input$get == 0) return(NULL)
  
     paste("You have queried ", input$osd, "from", input$dates[1], "to", input$dates[2])
  })

  output$mytable = renderDataTable({
  
       if(input$get == 0) return(NULL)
    
      params <- dataInput()  
      #res <- Query(input$osd, dataInput())
      
      #res$dataset
      params
  })
#  output$distPlot <- renderPlot({
#    x    <- faithful[, 2]  # Old Faithful Geyser data
#    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
 #   hist(x, breaks = bins, col = 'darkgray', border = 'white')
#  })
})
