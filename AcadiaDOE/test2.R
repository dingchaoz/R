library(zoo)
library(ggplot2)

# Read AcadiaDOE.csv using read.csv as a dataframe with 13 variables
data1 <- read.csv("AcadiaDOE/AcadiaDOE5.csv",header = TRUE,stringsAsFactors=FALSE)



## Individual SE plots without thresholds but control specs
## Control limits calculation
## http://www.isixsigma.com/tools-templates/control-charts/a-guide-to-control-charts/
title = paste0("MeanMaxMin range control plot of System Error ", data1$System_Error[[1]])
pd <- position_dodge(.1)
MEAN = mean(data1$Mean,na.rm = TRUE)
usl = MEAN + 3* mean(data1$Std,na.rm = TRUE)
lsl = MEAN - 3* mean(data1$Std,na.rm = TRUE)
label = c("UCL","LCL")
ggplot(data1, aes(x=Test_No, y=Mean)) +
  geom_point(aes(y= Mean,shape = System_Error))+
  geom_pointrange(aes(ymin=Min, ymax=Max), width=.25, position=pd) +
  geom_hline(yintercept = c(usl,lsl),color = "red",linetype = "longdash") +
  geom_text(aes(8,c(usl,lsl),label = label, vjust = -1)) + 
  labs(title=title) +
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))

PpkImage = paste0("AcadiaDOE/Rexport/","System Error ",data1$System_Error[[1]],"_MeanMaxMinControl5.png")

ggsave(PpkImage)