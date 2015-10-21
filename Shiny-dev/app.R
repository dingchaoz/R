### Test file to plot ggplot linking to capability database

# call libraries required
library(shiny)
library(RODBC)
library(RSQLServer)
library(ggplot2)

# connect to the server
conn <-odbcConnect("Capability")
PrgMap <- list(Programs = c("Seahawk", "DragonCC"), Database = c("Seahawk", "DragonCC"))
def_trk <- sqlQuery(conn, paste("select [TruckName] from",PrgMap$Database[[1]],".dbo. tblTrucks"))
DiagList <- sqlQuery(conn, paste("select * from",PrgMap$Database[[1]],".dbo. tblProcessingInfo"))
trucks <- sqlQuery(conn, paste("select * from",PrgMap$Database[[which(PrgMap$Programs=='Seahawk')]],".dbo. tblTrucks"))

ui <- fluidPage(
  # Select Product from drop down
    selectInput(inputId = "Program",label = "Choose the Program", choices = PrgMap$Programs,selected = PrgMap$Database[[1]]),
    
    # Make available choice of trucks
    selectInput(inputId = "Trucks", label = "Choose Trucks of interest here",choices = as.character(def_trk$TruckName),multiple = T,selected = as.character(def_trk$TruckName[1])),
    
    # Make available choice of Diagnostics
    
    selectInput(inputId = "Diag", label = "Choose Diagnostic of interest here",choices = as.character(DiagList$Name)),
    
    sliderInput(inputId = "num", label = "choose a numer", value = 25,min=1,max=25),
  
  plotOutput("plot"),
  plotOutput("print")
  #verbatimTextOutput("print")
  
)

a = 6

server <- function(input,output){
  
  #TruckID <- trucks$TruckID[which(trucks$Family%in%input$Trucks)]
  #Parameter <- DiagList$CriticalParam[which(DiagList$Name == input$Diag)]
  #SEID <- DiagList$SEID[which(DiagList$Name==input$Diag)]
  #Data <- reactive({sqlQuery(conn,paste("select * FROM ",PrgMap$Database[[which(PrgMap$Programs==input$Program)]],".dbo. tblEventDrivenData Where ",
  #"TruckID in (",as.character(trucks$TruckID[which(trucks$TruckName %in% input$Trucks)]),") and SEID = ",SEID))})
  
  
  
  
  output$plot <- renderPlot({hist(rnorm(input$num))})
  
  output$print <- renderPlot({
    ## Input variable transform
    b <- length(input$Trucks)
    ## Render this exact function that takes the transformed input in the above
    hist(rnorm(b))})
  
  #output$print <- renderPrint({
    #data <- observe(input$Trucks)
    #tgt <- data()
 #})
    
    #input$Program
  
}


shinyApp(ui = ui, server = server)