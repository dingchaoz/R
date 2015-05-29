# Plot the 30-day mortality rates for heart attack

# define the path of file to read
file <- "C:/Users/ks692/Documents/Dingchao/Courses/R/Assignments/Hospital wk4/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"

# read the outcome data
outcome <- read.csv(file,colClasses="character")

# look at first few rows
head(outcome)

# convert the colum 11 heart attack mort rate to num
outcome[,11] <- as.numeric(outcome[,11])

# make a histogram
hist(outcome[,11])