SetConn <- function() {
  
  conn <-odbcConnect("Capability")
  PrgMap <- list(Programs = c("Seahawk", "DragonCC"), Database = c("Seahawk", "DragonCC"))
  def_trk <- sqlQuery(conn, paste("select [TruckName] from",PrgMap$Database[[1]],".dbo. tblTrucks"))
  DiagList <- sqlQuery(conn, paste("select * from",PrgMap$Database[[1]],".dbo. tblProcessingInfo"))
  trucks <- sqlQuery(conn, paste("select * from",PrgMap$Database[[which(PrgMap$Programs=='Seahawk')]],".dbo. tblTrucks"))
  
}

UpdateConn <- function(input,session,meta) {
  
  observe({
    trk <- sqlQuery(meta$conn, paste("select [TruckName] from",PrgMap$Database[[which(meta$PrgMap$Programs==input$Program)]],".dbo. tblTrucks"))
    trucks <- sqlQuery(meta$conn, paste("select * from",meta$PrgMap$Database[[which(meta$PrgMap$Programs==input$Program)]],".dbo. tblTrucks"))
    # browser()
    updateSelectInput(session,"Trucks",label = "Choose Trucks of interest here",choices = 
                        as.character(meta$trk$TruckName),selected = as.character(meta$trk$TruckName[1]))
    DiagList <- sqlQuery(meta$conn, paste("select * from",meta$PrgMap$Database[[which(meta$PrgMap$Programs==input$Program)]],".dbo. tblProcessingInfo"))
    
    updateSelectInput(session,"Diag",label = "Choose Diagnostics of interest here",choices = 
                        as.character(meta$DiagList$Name))
    
    
  })
  
  
  
  
  
}
