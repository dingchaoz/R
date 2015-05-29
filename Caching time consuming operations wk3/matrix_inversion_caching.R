## Put comments here that give an overall description of what your
## functions do
#Usage example :
#t <- makeCacheMatrix(matrix(10:13,nrow=2,ncol=2))
#t1 <- cacheSolve(t)

# function to create a list of functions
makeCacheMatrix <- function(x = matrix()) {
  
  # m is the var holds mean, is set NULL as default value 
  i <- NULL
  
  # define set function
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  
  # define get function
  get <- function() x
  
  # define setmean function, assigns mean to m and return
  # super assignment operator <<- is used, which starts the closing framework, works it way up to the global environment
  # until it finds a variable called mean 
  # super assignment operator can only be used in functions
  setinvers <- function(invers) i <<- invers
  
  # define getmean function, returns m var
  getinvers <- function() i
  
  # create the list with names are set, get, setmean, getmean
  # and assign the functions to the names
  list(set = set, get = get,
       setinvers = setinvers,
       getinvers = getinvers)
}


# function to get mean from cache or calculate
cacheSolve <- function(x, ...) {
  
  # get the mean value from x
  i <- x$getinvers()
  
  # if mean is already calculated, then it will not be a null
  if(!is.null(i)) {
    message("getting cached data")
    
    # return cached mean, once return, this function ends
    return(i)
  }
  
  # else get the vector that is the input of makeVector
  data <- x$get()
  
  # calculate mean and store it into var m
  i <- solve(data, ...)
  
  # set the mean in setmean which uses a super assignment <<-
  x$setinvers(i)
  
  # return calculate mean value
  i
}