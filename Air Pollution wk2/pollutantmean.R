pollutantmean <- function(directory, pollutant, id) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  #Diretory where all files are stored
  #directory <- "C:/Users/ks692/Documents/Dingchao/Courses/R/Assignments/Air Pollution wk2/specdata/"
  
  # files is a char array of all the csv files path
  #files <- dir(directory, pattern = '.csv', full.names = TRUE)
  
  #apply read.csv to the list of all files and store data into var tables
  #tables <- lapply(files, read.csv)
  
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