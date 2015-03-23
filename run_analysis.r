// Coursera: Getting and Cleaning Data - Course Project Work
// Dataset: UCI Human Activity Recognition Using Smartphones Dataset v1.0
// The dataset was downloaded and unzipped to the folder "UCI_HAR_Dataset" in the working directory
// For the sake of reproducibility, stepst to download have been recorded in the README.md file
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
// The following R code:
// 1. Merges the training and the test sets to create one data set.
// 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
// 3. Uses descriptive activity names to name the activities in the data set
// 4. Appropriately labels the data set with descriptive variable names.
// 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
//    each variable for each activity and each subject.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////

// Removes all objects from the workspace
rm(list=ls())

// You need the dplyr library for using the group_by() and summarise_each() functions!
library(dplyr)

// STEP 1: Load the guns!
// Do not worry! All variables I have used are explained in the Codebook.md
features <- read.table("./UCI_HAR_Dataset/features.txt")
activity_labels <- read.table("./UCI_HAR_Dataset/activity_labels.txt")

// Loading the training sets
// Grab a cup of coffee if your system RAM is just 1GB; I had to :-/
X_train <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
Y_train <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
subject_train <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")

// Loading the test sets
X_test <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
Y_test <- read.table("./UCI_HAR_Dataset/test/y_test.txt")
subject_test <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")

// Assigns the 561 feature names to the X_train column names
colnames(X_train) <- features[,2]

// Y_train represents the 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, 
// SITTING, STANDING, LAYING) the subjects/participants performed. The values range from 1 to 6.
colnames(Y_train) <- "activity"

// subject_train represents the list of participants selected for the training set
colnames(subject_train) <- "subject"

// Combines the training sets Y_train, X_train and subject_train
trainDataTemp <- cbind(Y_train, X_train)                   // => Activities | 561 Features
trainDataFinal <- cbind(subject_train, trainDataTemp)      // => Subjects | Activities | 561 Features

// The test set brothers have to go through the furnace as well!
colnames(X_test) <- features[,2]
colnames(Y_test) <- "activity"
colnames(subject_test) <- "subject"

// Combines the test sets Y_test, X_test and subject_test
testDataTemp <- cbind(Y_test, X_test)
testDataFinal <- cbind(subject_test, testDataTemp)

// This union was inevitable
//
// Training set |"subject"|"activity"|"561 feature names"      |"subject" |"activity"|"561 feature names"|
//                             +                           =>  |   One Kickass Minutely Massive Dataset  |
// Testing set  |"subject"|"activity"|"561 feature names"      |----------|----------|-------------------|
//
mergedDataSet <- rbind(trainDataFinal, testDataFinal)

// I hate mess, so sorted the dataset by the subjects(1:30) and their activities(1:6)
mergedDataSet <- mergedDataSet[order(mergedDataSet$subject, mergedDataSet$activity),]

// STEP 2
// Returns the indices of the columns whose names match "subject" or "activity" or "mean" or "std"
selectColumns <- grep("subject|activity|mean|std", names(mergedDataSet))

// Selects the columns which measures Standard Deviation and Mean
mergedDataSet <- mergedDataSet[, selectColumns]

// STEP 3
// The "activity" column demanded to be named. So, I had to.
mergedDataSet$activity <- as.character(mergedDataSet$activity)
mergedDataSet$activity[mergedDataSet$activity == 1] <- "WALKING"
mergedDataSet$activity[mergedDataSet$activity == 2] <- "WALKING_UPSTAIRS"
mergedDataSet$activity[mergedDataSet$activity == 3] <- "WALKING_DOWNSTAIRS"
mergedDataSet$activity[mergedDataSet$activity == 4] <- "SITTING"
mergedDataSet$activity[mergedDataSet$activity == 5] <- "STANDING"
mergedDataSet$activity[mergedDataSet$activity == 6] <- "LAYING"
mergedDataSet$activity <- as.factor(mergedDataSet$activity)

// STEP 4
// I hope the following is self-explanatory. If not, you should not be here in the first place
names(mergedDataSet) <- gsub("^t", "timeDomain_", names(mergedDataSet))
names(mergedDataSet) <- gsub("^f", "frequencyDomain_", names(mergedDataSet))
names(mergedDataSet) <- gsub("std\\(\\)", "standardDeviation", names(mergedDataSet))
names(mergedDataSet) <- gsub("mean\\(\\)", "meanValue", names(mergedDataSet))
names(mergedDataSet) <- gsub("Freq\\(\\)", "Frequency", names(mergedDataSet))
names(mergedDataSet) <- gsub("BodyBody", "Body", names(mergedDataSet))
names(mergedDataSet) <- gsub("Acc", "Acceleration", names(mergedDataSet))
names(mergedDataSet) <- gsub("Gyro", "Gyroscope", names(mergedDataSet))
names(mergedDataSet) <- gsub("Mag", "Magnitude", names(mergedDataSet))

// STEP 5
// I preferred the wide approach.
// |   "subject"  |    "activity"      |          79 features          |
// |--------------|--------------------|-------------------------------|
// | 1 to 30      | 6 activities for   | Average of 79 features per    |
// | participants | each participant   | activity for each participant |
// |--------------|--------------------|-------------------------------|
//
averagesMergedDataSet <- mergedDataSet %>% group_by(subject, activity) %>% summarise_each(funs(mean))

// Presenting..... the averagesMergedDataSet.txt file in your working directory.
write.table(averagesMergedDataSet, "averagesMergedDataSet.txt", row.name=FALSE)
