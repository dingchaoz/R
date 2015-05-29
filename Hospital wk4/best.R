#take two arguments: the 2-character abbreviated name of a state and an
#outcome name. The function reads the outcome-of-care-measures.csv and returns a character vector
#with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specied outcome
#in that state.

best <- function(state, outcome) {
  
  
  # define the path of file to read
  file <- "C:/Users/ks692/Documents/Dingchao/Courses/R/Assignments/Hospital wk4/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
  
  # read the outcome data
  data <- read.csv(file,colClasses="character")
  
  # if the state input is not a valid state
  if (!(state %in% unique(data$State))){
    
    stop ("invalid state")
  }
  
  # if the outcome input is not a valid state
  if (!(outcome %in% c("heart attack","heart failure","pneumonia"))){
    
    stop ("invalid outcome")
  }
  
  
  # convert the colum 11 heart attack mort rate to num
  data[,11] <- as.numeric(data[,11])
  
  # convert the colum 11 heart failure mort rate to num
  data[,17] <- as.numeric(data[,17])
  
  # convert the colum 11 pneumonia mort rate to num
  data[,23] <- as.numeric(data[,23])
}