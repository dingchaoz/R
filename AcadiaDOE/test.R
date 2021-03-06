## Import two libaries
library(zoo)
library(ggplot2)

pd <- position_dodge(.1)

# Read AcadiaDOE.csv using read.csv as a dataframe with 13 variables
data <- read.csv("AcadiaDOE/AcadiaDOENew2.csv",header = TRUE,stringsAsFactors=FALSE)

# Create arrays to hold the SEID, Threshold and USL or not values
#SEID = c(5369,12493,10102,5978,5976,5366,5365)
SEID = c(5365,5366,5369,5976,5978,10102,12493,7293,7294,7295,7296,12125,5250)
Threshold = c(2125,1125,0,1500,-30,-5,1000,20001,20001,20001,20001,20001,105)
# 1 means USL, 0 means LSL
USL = c(1,1,1,0,0,1,0,1,1,1,1,1,1)

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

## Replace the NA values with the mean of the column, didn't use
#for (i in which(sapply(data, is.numeric))) {
  #+     data[is.na(data[, i]), i] <- mean(data[, i],  na.rm = TRUE)
  #+ }
## Creat plot 1 to show the Ppk trendlines for all System Error, that NA is replaced by latest Non NA value
# ggplot(data2, aes(x=Test_No, y=Ppk, colour=System_Error,group = System_Error)) +
#   geom_point(aes(shape = System_Error)) + geom_hline(yintercept = 1.5,color = "green",linetype = "longdash") +
#   geom_text(aes(5,1.5,label = "Ppk 1.5", vjust = -1)) + 
#   geom_line(position=pd,aes(group = System_Error,pch= System_Error )) +ylim(0,500) + scale_y_log10()+
#   labs(title="Ppk Trend Plot of All SEIDs, with NA replaced by Latest Non-NA value") +
#   theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))
# 
# ggsave("AcadiaDOE/Rexport2/PpkTrend_allSE_NAreplaced.png")

## Creat plot 2 to show the Ppk trendlines for all System Error, that NA is as blank
# ggplot(data, aes(x=Test_No, y=Ppk, colour=System_Error,group = System_Error)) +
#   geom_point(aes(shape = System_Error)) + geom_hline(yintercept = 1.5,color = "green",linetype = "longdash") +
#   geom_text(aes(5,1.5,label = "Ppk 1.5", vjust = -1)) + 
#   geom_line(position=pd,aes(group = System_Error,pch= System_Error )) +ylim(0,500) + scale_y_log10()+
#   labs(title="Ppk Trend Plot of All SEIDs, with NA as blank value") +
#   theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))

# ggsave("AcadiaDOE/Rexport2/PpkTrend_allSE.png")


## Creat plot 3 to show the possible variance box for all System Error, that NA is as blank
pd <- position_dodge(.1)
ggplot(data, aes(x=Test_No, y=Mean, colour=System_Error,group = System_Error)) +
  geom_point(aes(shape = System_Error))+
   geom_errorbar(aes(ymin=Mean-1*Std, ymax=Mean+1*Std), width=.1, position=pd) +
  ylim(-20,2000) +
  labs(title="Mean +/- 1 Standard Deviation Plot of All SEIDs") +
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))

ggsave("AcadiaDOE/Rexport2/Mean+-1Std_allSE_1std.pdf",width = 11,height = 8.5, units = "in")

## Creat plot 4 to show the possible variance box for all System Error, that NA is as blank
pd <- position_dodge(.1)
ggplot(data, aes(x=Test_No, y=Mean, colour=System_Error,group = System_Error)) +
  geom_point(aes(y= Mean,shape = System_Error))+
  geom_errorbar(aes(ymin=Mean-3*Std, ymax=Mean+3*Std), width=.25, position=pd) +
  ylim(-20,2000) + scale_y_log10() +
  labs(title="Variance Plot of All SEIDs, Logarithm of Y") +
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))

ggsave("AcadiaDOE/Rexport2/VarianceTrend_allSE_LogY.pdf",width = 11,height = 8.5, units = "in")


# 
# thd = c(2215,1125,1500,-30,-5,1000,0)
# c = c("gold","dark green","green","blue","purple","pink","red")
# lab = c("USL","USL","USL","LSL","LSL","USL","LSL")


## Creat plot 5 to show the recorded max,min,mea variance box for all System Error, that NA is as blank
# pd <- position_dodge(.1)
# ggplot(data, aes(x=Test_No, y=Mean, colour=System_Error,group = System_Error)) +
#   geom_point(aes(y= Mean,shape = System_Error))+
#   geom_pointrange(aes(ymin=Min, ymax=Max), width=.1, position=pd) +
#   geom_hline(yintercept = c(2215,1125,1500,-30,-5,1000,0),color = c,linetype = "longdash") +
#   geom_text(aes(8,thd,label = lab, vjust = -1)) + 
#   ylim(-35,2000) +
#   labs(title="MinMaxMean Range Plot of All SEIDs") +
#   theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))
# 
# ggsave("AcadiaDOE/Rexport2/MinMaxMeanRange_allSE_withSpecs.png")

## Create plot 6 to show the possible variance range of all System Errors, that NA is replaced by latest Non-Na value
pd <- position_dodge(.1)
ggplot(data2, aes(x=Test_No, y=Mean, colour=System_Error,group = System_Error)) +
  geom_point(aes(y= Mean,shape = System_Error))+
  geom_errorbar(aes(ymin=Mean-3*Std, ymax=Mean+3*Std), width=.25, position=pd) +
  ylim(-20,2000) + scale_y_log10() +
  labs(title="Variance Plot of All SEIDs, NA replaced by latest Non-NA value Logarithm of Y") +
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))

ggsave("AcadiaDOE/Rexport2/VarianceTrend_allSE_NAreplaced_LogY.pdf",width = 11,height = 8.5, units = "in")


data2$SEID = as.numeric(data2$SEID)


## Ppk Individual Plot
for (i in 1:length(SEID)) {
  
  ### Subset the data of the current SEID
  
  data3 <- data2[data2$SEID == SEID[i],]
  
  # Ppk Individual Plot
  title = paste0("Ppk plot of SEID",data3$SEID[1])
  
  ggplot(data3, aes(x=Test_No, y=Ppk)) + geom_point(aes(y= Ppk)) +
    labs(title= title) + geom_hline(yintercept = 1.5,color = "green",linetype = "longdash") +
    geom_text(aes(5,1.5,label = "Ppk 1.5", vjust = -1)) + 
    theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))

  
  PpkImage = paste0("AcadiaDOE/Rexport2/","SEID",data3$SEID[1],"_Ppk.pdf")
  
  ggsave(PpkImage,width = 11,height = 8.5, units = "in")
  
  ## Standard Deviation Individual Plot
  title = paste0("Standard Deviation plot of SEID",data3$SEID[1])
  
  ggplot(data3, aes(x=Test_No, y=Std)) + geom_point(aes(y= Std)) +
    theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9)) + labs(title= title) 
  
  
  PpkImage = paste0("AcadiaDOE/Rexport2/","SEID",data3$SEID[1],"_Std.pdf")
  
  ggsave(PpkImage,width = 11,height = 8.5, units = "in")
  
  ## Plot the variance individual plot
  title = paste0("Variance plot of SEID",data3$SEID[1])
  ths = Threshold[i]
  if (USL[i] > 0){
    label = paste0("USL = ",ths)
  } else {
    label =  paste0("LSL = ",ths)}
  
  pd <- position_dodge(.1)
  ggplot(data3, aes(x=Test_No, y=Mean)) +
    geom_point(aes(y= Mean,shape = System_Error))+
    geom_errorbar(aes(ymin=Mean-3*Std, ymax=Mean+3*Std),position=pd) + 
    geom_hline(yintercept = ths,color = "green",linetype = "longdash") +
    geom_text(aes(8,ths,label = label, vjust = -1)) + 
    labs(title=title) +
    theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))
  
  PpkImage = paste0("AcadiaDOE/Rexport2/","SEID",data3$SEID[1],"_Variance.pdf")
  
  ggsave(PpkImage,width = 11,height = 8.5, units = "in")
  
  ## Plot the meanmaxmin range individual plot
  title = paste0("MeanMaxMin range plot of SEID",data3$SEID[1])
  ths = Threshold[i]
  if (USL[i] > 0){
    label = paste0("USL = ",ths)
  } else {
    label =  paste0("LSL = ",ths)}
  
  pd <- position_dodge(.1)
  ggplot(data3, aes(x=Test_No, y=Mean)) +
    geom_point(aes(y= Mean,shape = System_Error))+
    geom_pointrange(aes(ymin=Min, ymax=Max),position=pd) + 
    geom_hline(yintercept = ths,color = "green",linetype = "longdash") +
    geom_text(aes(8,ths,label = label, vjust = -1)) + 
    labs(title=title) +
    theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))
  
  PpkImage = paste0("AcadiaDOE/Rexport2/","SEID",data3$SEID[1],"_MeanMaxMinrange.pdf")
  
  ggsave(PpkImage,width = 11,height = 8.5, units = "in")
  
  
  
}



## Individual SE plots with thresholds

for (i in 1:length(SEID)) {
  
  ### Subset the data of the current SEID
  
  data3 <- data2[data2$SEID == SEID[i],]
  title = paste0("MeanMaxMin range plot of System Error", data3$System_Error[[1]])
  ths = Threshold[i]
  if (USL[i] > 0){
    label = paste0("USL = ",ths)
  } else {
    label =  paste0("LSL = ",ths)}
  
  pd <- position_dodge(.1)
  ggplot(data3, aes(x=Test_No, y=Mean)) +
    geom_point(aes(y= Mean,shape = System_Error))+
    geom_pointrange(aes(ymin=Min, ymax=Max), position=pd) + 
    geom_hline(yintercept = ths,color = "green",linetype = "longdash") +
    geom_text(aes(8,ths,label = label, vjust = -1)) + 
    labs(title=title) +
    theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=9))
  
  PpkImage = paste0("AcadiaDOE/Rexport2/","System Error ",data3$System_Error[[1]],"_MeanMaxMinrange.pdf")
  
  ggsave(PpkImage,width = 11,height = 8.5, units = "in")
  
}




