#take two arguments: the 2-character abbreviated name of a state and an
#outcome name. The function reads the outcome-of-care-measures.csv and returns a character vector
#with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specied outcome
#in that state.

# to do: handling ties to return by alphabic order
# a stackoverflow to refer http://stackoverflow.com/questions/19300808/ties-when-finding-minimum-in-r

best <- function(state, outcome) {
  
  
  # define the path of file to read
  file <- "C:/Users/ks692/Documents/Dingchao/Courses/R/Assignments/Hospital wk4/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
  
  # read the outcome data
  alldata <- read.csv(file,colClasses="character")
  
  # if the state input is not a valid state
  if (!(state %in% unique(alldata$State))){
    
    stop ("invalid state")
  }
  
  # if the outcome input is not a valid state
  if (!(outcome %in% c("heart attack","heart failure","pneumonia"))){
    
    stop ("invalid outcome")
  }
  
  # get a subset of the data for the user inputted state only
  data <- subset(alldata,alldata$State == state)
  
  if (outcome == "heart attack") {
  
    # convert the colum 11 heart attack mort rate to num
    data[,11] <- as.numeric(data[,11])
    
    # find the index of the lowest heart attack mort rate hospital
    index <- which.min(data[,11])
    
    # return the name of the hospital
    return (data[,2][index])
  
  }
  
  else if (outcome == "heart failure") {
  
    # convert the colum 11 heart failure mort rate to num
    data[,17] <- as.numeric(data[,17])
    
    # find the index of the lowest heart attack mort rate hospital
    index <- which.min(data[,17])
    
    # return the name of the hospital
    return (data[,2][index])
  
  }
  
  else if (outcome == "pneumonia") {
  
    # convert the colum 11 pneumonia mort rate to num
    data[,23] <- as.numeric(data[,23])
    
    # find the index of the lowest heart attack mort rate hospital
    index <- which.min(data[,23])
    
    # return the name of the hospital
    return (data[,2][index])
  
  
  }
}