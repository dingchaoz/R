# take an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
#The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
#of the hospital that has the ranking specified by the num argument.


rankall <- function(outcome, num) {
  
  #define the path of file to read
  file <- "C:/Users/ks692/Documents/Dingchao/Courses/R/Assignments/Hospital wk4/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
  
  # read the outcome data
  data <- read.csv(file,colClasses="character")
  
  
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
  
  # get unique state names
  uniqst <- unique(data$State)
  
  # get number of states
  nstate <- length(uniqst)
  
  #Create the data.frame as res
  res <- data.frame(hospital=numeric(nstate), state = numeric(nstate))
  
  # set row names of res value as the state name
  row.names(res) <- uniqst
  
  
  if (outcome == "heart attack") {
    
    # exclude the NAs 
    data <- subset(data,!is.na(data[,11]))
    
    # convert the colum 11 heart attack mort rate to num
    data[,11] <- as.numeric(data[,11])
    
    for (i in 1:nstate) {
      
      # subset into each state
      stdata <- subset(data,data$State == uniqst[i])
      
      # first order by heart attack mort rate, then order by hospital name
      # default is ascending
      stdata <- stdata[order(stdata[,11], stdata[,2]), ]
      
      # assign state value to res data frame
      res[i,2] <- uniqst[i]
      
      # return the name of hospital according to user input criteria
      if (is.numeric(num)){
        # return the name of the hospital
        res[i,1] <- stdata[,2][num]
      }
      else if (num == "best"){
        
        res[i,1] <- stdata[,2][1]
      }
      else if (num == "worst"){
        
        len <- length(stdata[,2])
        res[i,1] <- stdata[,2][len]
      }
    
    }
    
    # return result data frame
    return (res)
    
  }
  
  else if (outcome == "heart failure") {
    
    # exclude the NAs 
    data <- subset(data,!is.na(data[,17]))
    
    # convert the colum 11 heart attack mort rate to num
    data[,17] <- as.numeric(data[,17])
    
    for (i in 1:nstate) {
      
      # subset into each state
      stdata <- subset(data,data$State == uniqst[i])
      
      # first order by heart failure mort rate, then order by hospital name
      # default is ascending
      stdata <- stdata[order(stdata[,17], stdata[,2]), ]
      
      # assign state value to res data frame
      res[i,2] <- uniqst[i]
      
      # return the name of hospital according to user input criteria
      if (is.numeric(num)){
        # return the name of the hospital
        res[i,1] <- stdata[,2][num]
      }
      else if (num == "best"){
        
        res[i,1] <- stdata[,2][1]
      }
      else if (num == "worst"){
        
        len <- length(stdata[,2])
        res[i,1] <- stdata[,2][len]
      }
      
    }
    
    # return result data frame
    return (res)
    
  }
  
  else if (outcome == "pneumonia") {
    
    # exclude the NAs 
    data <- subset(data,!is.na(data[,23]))
    
    # convert the colum 11 heart attack mort rate to num
    data[,23] <- as.numeric(data[,23])
    
    for (i in 1:nstate) {
      
      # subset into each state
      stdata <- subset(data,data$State == uniqst[i])
      
      # first order by pneumonia mort rate, then order by hospital name
      # default is ascending
      stdata <- stdata[order(stdata[,23], stdata[,2]), ]
      
      # assign state value to res data frame
      res[i,2] <- uniqst[i]
      
      # return the name of hospital according to user input criteria
      if (is.numeric(num)){
        # return the name of the hospital
        res[i,1] <- stdata[,2][num]
      }
      else if (num == "best"){
        
        res[i,1] <- stdata[,2][1]
      }
      else if (num == "worst"){
        
        len <- length(stdata[,2])
        res[i,1] <- stdata[,2][len]
      }
      
    }
    
    # return result data frame
    return (res)
    
    
    
  }
}