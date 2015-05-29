#the 2-character abbreviated name of a
#state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
#The function reads the outcome-of-care-measures.csv le and returns a character vector with the name
#of the hospital that has the ranking specied by the num argument.


rankhospital <- function(state, outcome, num) {
  
  #define the path of file to read
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
  
  # check if num is a valid input
  # if the num is not a valid char input
  if (is.character(num)&!(num %in% c("best","worst"))) {
    
    stop ("invalid num") 
  }
  
  # if the outcome input is not a positive integer number
  if (is.numeric(num)) {
    if (num <= 0){
     stop ("invalid num")
    }
    if (num%%1 != 0) {
     stop ("invalid num") 
    }
  }
  
  # get a subset of the data for the user inputted state only
  data <- subset(alldata,alldata$State == state)
  
  
  if (outcome == "heart attack") {
    
    # exclude the NAs 
    data <- subset(data,!is.na(data[,11]))
    
    # convert the colum 11 heart attack mort rate to num
    data[,11] <- as.numeric(data[,11])
    
    # first order by heart attack mort rate, then order by hospital name
    # default is ascending
    data <- data[order(data[,11], data[,2]), ]
    
    # return the name of hospital according to user input criteria
    if (is.numeric(num)){
      # return the name of the hospital
      return (data[,2][num])
    }
    else if (num == "best"){
    
      return (data[,2][1])
    }
    else if (num == "worst"){
      
      len <- length(data[,2])
      return (data[,2][len])
    }
      
  }
  
  else if (outcome == "heart failure") {
    
    # exclude the NAs 
    data <- subset(data,!is.na(data[,17]))
    
    # convert the colum 11 heart failure mort rate to num
    data[,17] <- as.numeric(data[,17])
    
    # first order by heart failure mort rate, then order by hospital name
    # default is ascending
    data <- data[order(data[,17], data[,2]), ]
    
    # return the name of hospital according to user input criteria
    if (is.numeric(num)){
      # return the name of the hospital
      return (data[,2][num])
    }
    else if (num == "best"){
      
      return (data[,2][1])
    }
    else if (num == "worst"){
      
      len <- length(data[,2])
      return (data[,2][len])
    }
    
    
  }
  
  else if (outcome == "pneumonia") {
    
    # exclude the NAs 
    data <- subset(data,!is.na(data[,23]))
    
    # convert the colum 11 pneumonia mort rate to num
    data[,23] <- as.numeric(data[,23])
    
    # first order by pneumonia mort rate, then order by hospital name
    # default is ascending
    data <- data[order(data[,23], data[,2]), ]
    
    # return the name of hospital according to user input criteria
    if (is.numeric(num)){
      # return the name of the hospital
      return (data[,2][num])
    }
    else if (num == "best"){
      
      return (data[,2][1])
    }
    else if (num == "worst"){
      
      len <- length(data[,2])
      return (data[,2][len])
    }
    
    
  }
}