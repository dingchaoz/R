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
  
  #plotOutput("plot"),
  plotOutput("print"),
  plotOutput("data")
  #verbatimTextOutput("print")
  
)


server <- function(input,output,session){
  
  observe({
    trk <- sqlQuery(conn, paste("select [TruckName] from",PrgMap$Database[[which(PrgMap$Programs==input$Program)]],".dbo. tblTrucks"))
    trucks <- sqlQuery(conn, paste("select * from",PrgMap$Database[[which(PrgMap$Programs==input$Program)]],".dbo. tblTrucks"))
    # browser()
    updateSelectInput(session,"Trucks",label = "Choose Trucks of interest here",choices = 
                        as.character(trk$TruckName),selected = as.character(trk$TruckName[1]))
    DiagList <- sqlQuery(conn, paste("select * from",PrgMap$Database[[which(PrgMap$Programs==input$Program)]],".dbo. tblProcessingInfo"))
    
    updateSelectInput(session,"Diag",label = "Choose Diagnostics of interest here",choices = 
                      as.character(DiagList$Name))
    
    
  })
  
  
  
  
  ## working
  #output$plot <- renderPlot({hist(rnorm(input$num))})
  
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
    TruckID <- trucks$TruckID[which(trucks$Family%in%input$Trucks)]
    SEID <- DiagList$SEID[which(DiagList$Name==input$Diag)]
    Parameter <- DiagList$CriticalParam[which(DiagList$Name == input$Diag)]
    data <- reactive({sqlQuery(conn,paste("select * FROM ",PrgMap$Database[[which(PrgMap$Programs==input$Program)]],".dbo. tblEventDrivenData Where ",
  "TruckID in (",as.character(trucks$TruckID[which(trucks$TruckName %in% input$Trucks)]),") and SEID = ",SEID))})
    x <- rnorm(data())
  hist(x,col = "red",breaks = 10,main = "Histogram with Normal Curve")
  xfit<-seq(min(x),max(x),length=40) 
  yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
  lines(xfit,yfit,col = "blue",lwd = 2)
  #hist(rnorm(data))
 })
    
    #input$Program
  
}


shinyApp(ui = ui, server = server)