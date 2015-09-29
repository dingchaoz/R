
library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# Load activity labels + features
# There are 6 Activities in total
activityLabels <- read.table("activity_labels.txt")
# Read the activity name as character instead of levels
activityLabels[,2] <- as.character(activityLabels[,2])
# There are 561 features in total, and our data set are only
# interested in the feature that is about mean or std
features <- read.table("features.txt")
# Read the feature name as character instead of levels
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
#Grep searches for matches to argument pattern within each element of char vector
# here we extract all features about mean and std, it returns the feature number
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
# Extract the feature names based on the numbers extracted
featuresWanted.names <- features[featuresWanted,2]
# Gsub performs replacement for all matches
# Here we replace -mean with Mean,-std with Std, -() with space
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


# Load the datasets
# Only load the data that are from the concerned features
# the train data sets original haev 561 rows, each row have 7352 obs
# We only read the concerned rows using featuresWanted which is a number vector
train <- read.table("train/X_train.txt")[featuresWanted]
# Read the actitivies numbers for the 7352 obs
trainActivities <- read.table("train/Y_train.txt")
# Read the subject who performed the 7352 activities, subject range from 1 to 30
trainSubjects <- read.table("train/subject_train.txt")
# Combine the subject performer number, activity number, and features(measurement)
# this train data set has 1+1+81 columns and 7352 rows(obs)
train <- cbind(trainSubjects, trainActivities, train)

## Same process methods as train data set applied to test data set
test <- read.table("test/X_test.txt")[featuresWanted]
testActivities <- read.table("test/Y_test.txt")
testSubjects <- read.table("test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
# Now the allData has 1+1+81 columns, 10299 rows(obs)
allData <- rbind(train, test)
# Appropriately names the columns of allData set
colnames(allData) <- c("subject", "activity", featuresWanted.names)

# turn activities & subjects into factors, which wil be used in melt function
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

#http://www.r-bloggers.com/melt/
# melt stacks a set of columns into one column of data
allData.melted <- melt(allData, id = c("subject", "activity"))
# dcast casts a molten data frame into an array or data frame
#http://127.0.0.1:14698/library/reshape2/html/cast.html
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)