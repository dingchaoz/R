myFun <- function() {
  x <- 8:1
  #browser() is similar to keyboard in matlab, which allows you to modify
  #variables while in executing function
  browser()
  y <- 
    1:8
  plot(y~x)
  lines(y~x)
  text(x,y, letters[1:8], pos=3)
}