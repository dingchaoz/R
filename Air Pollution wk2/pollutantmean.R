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
  
  #attach data so no need to add $ to refer to var
  #attach(data)
  
  #return(tables)
  
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
  
  # combine all rows of tables into one
  #do.call(rbind, tables)
  
  #fl <- paste(directory,"","",sep="")
  
  #Read the files data in a data frame
  # data <- read.csv(file = fl,head=TRUE,sep=",")
  
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  #ignore NA values to get mean
  #result <- mean(,na.rm=TRUE)
  
  #return(result) 
}