


# Select Product from drop down
UICreate <- function() {
  ui <- fluidPage(
    selectInput(inputId = "Program",label = "Choose the Program", choices = meta$PrgMap$Programs,selected = meta$PrgMap$Database[[1]]),
    
    # Make available choice of trucks
    selectInput(inputId = "Trucks", label = "Choose Trucks of interest here",choices = as.character(meta$def_trk$TruckName),multiple = T,selected = as.character(meta$def_trk$TruckName[1])),
    
    # Make available choice of Diagnostics
    
    selectInput(inputId = "Diag", label = "Choose Diagnostic of interest here",choices = as.character(meta$DiagList$Name)),
    
    sliderInput(inputId = "num", label = "choose a numer", value = 25,min=1,max=25),
    
    #plotOutput("plot"),
    plotOutput("print"),
    plotOutput("data")
    #verbatimTextOutput("print")
    
  )
  
  return (ui)
  
}
