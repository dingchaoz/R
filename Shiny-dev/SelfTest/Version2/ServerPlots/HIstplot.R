
Hisplot <- function(input,meta){
  
  TruckID <- meta$trucks$TruckID[which(meta$trucks$Family%in%meta$input$Trucks)]
  SEID <- meta$DiagList$SEID[which(meta$DiagList$Name==input$Diag)]
  Parameter <- meta$DiagList$CriticalParam[which(meta$DiagList$Name == input$Diag)]
  data <- reactive({sqlQuery(meta$conn,paste("select * FROM ",meta$PrgMap$Database[[which(meta$PrgMap$Programs==input$Program)]],".dbo. tblEventDrivenData Where ",
                                        "TruckID in (",as.character(meta$trucks$TruckID[which(meta$trucks$TruckName %in% input$Trucks)]),") and SEID = ",SEID))})
  x <- rnorm(data())
  hist(x,col = "red",breaks = 10,main = "Histogram with Normal Curve")
  xfit<-seq(min(x),max(x),length=40) 
  yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
  lines(xfit,yfit,col = "blue",lwd = 2)
  
}
