InitConn <- function(){
  
  # connect to the server
  conn <-odbcConnect("Capability")
  PrgMap <- list(Programs = c("Seahawk", "DragonCC"), Database = c("Seahawk", "DragonCC"))
  def_trk <- sqlQuery(conn, paste("select [TruckName] from",PrgMap$Database[[1]],".dbo. tblTrucks"))
  DiagList <- sqlQuery(conn, paste("select * from",PrgMap$Database[[1]],".dbo. tblProcessingInfo"))
  trucks <- sqlQuery(conn, paste("select * from",PrgMap$Database[[which(PrgMap$Programs=='Seahawk')]],".dbo. tblTrucks"))
  
  
  meta = list(conn = conn, PrgMap = PrgMap, def_trk = def_trk,DiagList = DiagList,trucks = trucks  )
  
  return (meta)
}