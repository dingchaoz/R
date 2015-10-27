


# Select Product from drop down
ServerCreate <- function(input,output,session) {
  server <- function(input,output,session){
    
    ## Update Connection Info
    #UpdateConn(input,session,meta)
    
    ## working well
    output$print <- renderPlot({
      ## Input variable transform
      b <- length(input$Trucks)
      
      qplot(input$Trucks,y = b,geom ="point")
      
      ## Render this exact function that takes the transformed input in the above
      #ggplot(data, aes(y=b)) +
      #   geom_histogram(y=b)
      
      
      
    })
    
    output$data <- renderPlot({
      Hisplot(input,meta)
    })
    
    
  }
  
  
  return (server)
}
