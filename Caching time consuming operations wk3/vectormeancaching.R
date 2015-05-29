#Usage example :
#t <- makeVector(10:15)
#t1 <- cachemean(t)
# a good article to understand <<- and lexical scoping
#http://r.789695.n4.nabble.com/What-does-the-quot-lt-lt-quot-operator-mean-td3466657.html

# function to create a list of functions
makeVector <- function(x = numeric()) {
  
  # m is the var holds mean, is set NULL as default value 
  m <- NULL
  
  # define set function
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  
  # define get function
  get <- function() x
  
  # define setmean function, assigns mean to m and return
  # super assignment operator <<- is used, which starts the closing framework, works it way up to the global environment
  # until it finds a variable called mean 
  # super assignment operator can only be used in functions
  setmean <- function(mean) m <<- mean
  
  # define getmean function, returns m var
  getmean <- function() m
  
  # create the list with names are set, get, setmean, getmean
  # and assign the functions to the names
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}


# function to get mean from cache or calculate
cachemean <- function(x, ...) {
  
  # get the mean value from x
  m <- x$getmean()
  
  # if mean is already calculated, then it will not be a null
  if(!is.null(m)) {
    message("getting cached data")
    
    # return cached mean, once return, this function ends
    return(m)
  }
  
  # else get the vector that is the input of makeVector
  data <- x$get()
  
  # calculate mean and store it into var m
  m <- mean(data, ...)
  
  # set the mean in setmean which uses a super assignment <<-
  x$setmean(m)
  
  # return calculate mean value
  m
}