pollutantnobs <- function(directory, id) {
  
  #Diretory where all files are stored
  directory <- "C:/Users/ks692/Documents/Dingchao/Courses/R/specdata/"
  
  # files is a char array of all the csv files path
  files <- dir(directory, pattern = '.csv', full.names = TRUE)
  
  #apply read.csv to the list of all files and store data into var tables
  tables <- lapply(files, read.csv)
  
  #combine the large lists of tables into one and store in data var
  assign('data',do.call(rbind, tables))
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  #Get the length of id
  length <- length(id)
  
  #Create the data.frame as res
  res <- data.frame(id=numeric(length), nobs = numeric(length))
  
  # Loop into to update values of the res data.frame
  for (i in 1:length(id)) {
    
    # subset selected ID data into temp var
    temp <- subset(data,data$ID == id[i])
    
    # count var initiate
    count <- 0 
    
    # loop into temp var to count nobs
    for (i in 1: length(temp$ID)) {
      
      #if sulfate and nitrate are not NA
      if(!is.na(temp$sulfate[i]) & !is.na(temp$nitrate[i])) {
        
         count ++
      }
    }
    
    # set the id value
    res[i,1] <- id[i]
    
    # set the nobs value
    res[i,2] <- count
  }
  
  print(head(data,5))
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  return(res)
 
  

}