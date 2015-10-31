meltdata <- read.csv("AcadiaDOE/AcadiaDOEtest.csv",header = TRUE,stringsAsFactors=FALSE)
meltdata$Test_No = as.factor(meltdata$Test_No)