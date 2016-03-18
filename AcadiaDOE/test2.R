library(zoo)
library(ggplot2)

# Read AcadiaDOE.csv using read.csv as a dataframe with 13 variables
# data1 <- read.csv("AcadiaDOE/AcadiaDOE5.csv",header = TRUE,stringsAsFactors=FALSE)
data <- read.csv("AcadiaDOE/AcadiaDOENew2.csv",header = TRUE,stringsAsFactors=FALSE)
## Order by SEID and create to a new data frame
data2 <- data[order(data$SEID),]
# Use na.locf function from zoo package to replace NA with the lastest Non-NA value
data2 <- na.locf(data2)
# Numericalize columns
data2$Ppk <- as.numeric(as.character(data2$Ppk))
data2$Max <-as.numeric(as.character(data2$Max))
data2$Min <- as.numeric(as.character(data2$Min))
data2$Mean <- as.numeric(as.character(data2$Mean))
data2$Std <- as.numeric(as.character(data2$Std))

data2$SEID = as.numeric(data2$SEID)


## Ppk Individual Plot
for (i in 1:length(SEID)) {
  
    data3 <- data2[data2$SEID == SEID[i],]


    ## Individual SE plots without thresholds but control specs
    ## Control limits calculation
    ## http://www.isixsigma.com/tools-templates/control-charts/a-guide-to-control-charts/
    title = paste0("MeanMaxMin range control plot of System Error ", data3$System_Error[[1]])
    pd <- position_dodge(.1)
    MEAN = mean(data3$Mean,na.rm = TRUE)
    usl = MEAN + 3* mean(data3$Std,na.rm = TRUE)
    lsl = MEAN - 3* mean(data3$Std,na.rm = TRUE)
    label = c("UCL","LCL")
    ggplot(data3, aes(x=Test_No, y=Mean)) +
      geom_point(aes(y= Mean,shape = System_Error))+
      geom_pointrange(aes(ymin=Min, ymax=Max), position=pd) +
      geom_hline(yintercept = c(usl,lsl),color = "red",linetype = "longdash") +
      geom_text(aes(8,c(usl,lsl),label = label, vjust = -1)) + 
      labs(title=title) +
      theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))
    
    PpkImage = paste0("AcadiaDOE/Rexport2/","System Error ",data3$System_Error[[1]],"_MeanMaxMinControl.pdf")
    
    ggsave(PpkImage,width = 11,height = 8.5, units = "in")
}