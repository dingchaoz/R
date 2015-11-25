table <- read.csv("ForTim/play.txt",header = F, sep = "\n")  ## Break the file into single line

header1 <- toString(table[1,1]) # Test to read the first line as the header of the 1st table and convert to a string
value1 <- toString(table[2,1]) 
### To do: recognize and able to retrieve each test record values, headers and comments

rownum <- dim(table)[1]
tablenum <- 0
for (i in 1:rownum)
{
  if (strsplit( toString(table[i,1]),split = " ")[[1]][1] == "") {
    d.tablenum <- data.frame(table[1,1])
    tablenum = tablenum + 1
    #d.tablenum <- data.frame()
    tablerowstart <- i
    
  }
  else{
    tablerowend = tablerowstart + 1
    
    
  }
  
}
gsub("[[:space:]]", "", header1) ## Remove all empty spaces
strsplit(header1,split = "")
install.packages("qdapRegex")
library(ddapRegex)
rm_white(header1)
string< - rm_white(header1)
strsplit(string, "")
l <- list()
myfunction <- function(x) {
  for (i in 1:length(x)){
    if (x[i] != ""){
      l <- c(list,x[i])
      
    }
      
    
  }
  return 
}
  
}