pollutantmean <- function(directory, pollutant, id) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  #Diretory where all files are stored
  directory <- "C:/Users/ks692/Documents/Dingchao/Courses/R/specdata/"
  
  # files is a char array of all the csv files path
  files <- dir(directory, pattern = '.csv', full.names = TRUE)
  
  #apply read.csv to the list of all files and store data into var tables
  tables <- lapply(files, read.csv)
  
  #combine the large lists of tables into one and store in data var
  assign('data',do.call(rbind, tables))
  
  
  # subset data to the rows and column defined by user input
  temp <- subset(data,data$ID >= id[1] & data$ID <= id[length(id)])
  #print(head(temp))
  
  #if the 2nd input matches sulfate string,assign that column to temp var
  if (pollutant == "sulfate") {
    temp <- temp$sulfate
    
  }
  #else if the 2nd input matches nitrate string,assign that column to temp var
  else if (pollutant == "nitrate") {
    temp <- temp$nitrate
    
  }
  
  
  #print(head(temp))
  
  # calculate mean without na value
  res <- mean(temp,na.rm = TRUE)
  
  return(res)
  
  
  #return(result) 
}