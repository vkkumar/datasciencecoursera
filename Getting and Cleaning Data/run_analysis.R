# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#     for each activity and each subject.


library(dplyr)

fileDir = "~/Dropbox/Coursera/Getting and Cleaning Data/UCI HAR Dataset"

# Read in the test datasets, X_test, y_test and subject_test
setwd(file.path(fileDir, "test"))
X_test <- read.csv("X_test.txt", sep="", header=FALSE)
y_test <- read.csv("y_test.txt", sep="", header=FALSE)
subject_test <- read.csv("subject_test.txt", sep="", header=FALSE)

# Merge the test datasets into a single dataframe
test <- data.frame(subject_test, y_test, X_test)

# Read in the train datasets, X_train, y_train, subject_train
setwd(file.path(fileDir, "train"))
X_train <- read.csv("X_train.txt", sep="", header=FALSE)
y_train <- read.csv("y_train.txt", sep="", header=FALSE)
subject_train <- read.csv("subject_train.txt", sep="", header=FALSE)

# Merge test training datasets into a single dataframe
train <- data.frame(subject_train, y_train, X_train)

# Combine the training and test running datasets
runData <- rbind(train, test)

# Read in the measurement labels dataset and label the columns of runData
setwd(fileDir)
features <- read.csv("features.txt", sep="", header=FALSE)[ ,2]
features <- as.vector(features)
colnames(runData) <- c("subject_id", "activity_labels", features)

validFeature <- make.names(names=colnames(runData), unique=TRUE, allow_ = TRUE)
colnames(runData) <- validFeature

# Select only the columns that contain mean or standard deviations.
# Remove columns with strings "mean" with strings "freq" and "angle
filteredData <- select(runData, 
                       contains("subject"),
                       contains("label"),
                       contains("mean"),
                       contains("std"),
                       -contains("freq"),
                       -contains("angle"))

# Read in the activity labels dataset for joining with filteredData
setwd(file.path(fileDir))
activity_desc <- read.csv("activity_labels.txt", sep="", header=FALSE)
# glimpse(activity_desc)

# Replace the activity codes by their description provided in datatframe: activity_desc
activityDesc <- as.character(activity_desc[match(filteredData$activity_labels,
                                                 activity_desc$V1), 'V2'])
filteredData$activity_labels <- activityDesc
# glimpse(filteredData)

# Group the running data by subject and activity, then
# calculate the mean of every measurement.
filteredDataSummary <- filteredData %>%
  group_by(subject_id, activity_labels) %>%
  summarise_each(funs(mean))
# glimpse(filteredDataSummary)

# Write run.data to file
setwd(fileDir)
write.table(filteredDataSummary, file="run_data_summary.txt", row.name=FALSE)
