corr <- function(directory, threshold) {
  
  #Diretory where all files are stored
  directory <- "C:/Users/ks692/Documents/Dingchao/Courses/R/specdata/"
  
  # files is a char array of all the csv files path
  files <- dir(directory, pattern = '.csv', full.names = TRUE)
  
  #apply read.csv to the list of all files and store data into var tables
  tables <- lapply(files, read.csv)
  
  #combine the large lists of tables into one and store in data var
  assign('data',do.call(rbind, tables))
  
  # remove all the NA of sulfate and nitrate colu
  fildata <- subset(data,!is.na(data$sulfate)&!is.na(data$nitrate))
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  #Get the length of all files
  length <- length(files)
  
  #Create the data.frame as res
  #res <- data.frame(id=numeric(length), nobs = numeric(length))
  
  res <- numeric(0)
  
  # Loop into to update values of the res data.frame
  for (i in 1:length) {
    
    # count the completed observations
    count <- sum(fildata$ID == i)
       
    # if the count is larger than the threshold
    if(count > threshold){
      
      temp <- subset(fildata,fildata$ID == i)
      
      res <- c(res,cor(temp$sulfate,temp$nitrate))
    }
  }
  
  #print(head(data,5))
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  return(res)
  
  
  
}