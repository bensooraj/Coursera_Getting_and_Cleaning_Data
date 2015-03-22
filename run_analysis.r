//R File
rm(list=ls())
library(dplyr)

//
features = read.table("./UCI_HAR_Dataset/features.txt")
activity_labels <- read.table("./UCI_HAR_Dataset/activity_labels.txt")

X_train <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
Y_train <- read.table("./UCI_HAR_Dataset/train/y_train.txt")

subject_train <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")

X_test <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
Y_test <- read.table("./UCI_HAR_Dataset/test/y_test.txt")

subject_test <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")

//
colnames(X_train) <- features[,2]
colnames(Y_train) <- "activity"
colnames(subject_train) <- "subject"

//Combining
trainDataTemp <- cbind(Y_train, X_train)
trainDataFinal <- cbind(subject_train, trainDataTemp)

//test
colnames(X_test) <- features[,2]
colnames(Y_test) <- "activity"
colnames(subject_test) <- "subject"

//Combining
testDataTemp <- cbind(Y_test, X_test)
testDataFinal <- cbind(subject_test, testDataTemp)

//Joining the two datasets
mergedDataSet <- rbind(trainDataFinal, testDataFinal)

//Sorting
mergedDataSet <- mergedDataSet[order(mergedDataSet$subject, mergedDataSet$activity),]

//
selectColumns <- grep("subject|activity|mean|std", names(mergedDataSet))
mergedDataSet <- mergedDataSet[, selectColumns]

//
mergedDataSet$activity <- as.character(mergedDataSet$activity)

mergedDataSet$activity[mergedDataSet$activity == 1] <- "WALKING"
mergedDataSet$activity[mergedDataSet$activity == 2] <- "WALKING_UPSTAIRS"
mergedDataSet$activity[mergedDataSet$activity == 3] <- "WALKING_DOWNSTAIRS"
mergedDataSet$activity[mergedDataSet$activity == 4] <- "SITTING"
mergedDataSet$activity[mergedDataSet$activity == 5] <- "STANDING"
mergedDataSet$activity[mergedDataSet$activity == 6] <- "LAYING"
mergedDataSet$activity <- as.factor(mergedDataSet$activity)


//
names(mergedDataSet) <- gsub("^t", "timeDomain_", names(mergedDataSet))
names(mergedDataSet) <- gsub("^f", "frequencyDomain_", names(mergedDataSet))
names(mergedDataSet) <- gsub("std\\(\\)", "standardDeviation", names(mergedDataSet))
names(mergedDataSet) <- gsub("mean\\(\\)", "meanValue", names(mergedDataSet))
names(mergedDataSet) <- gsub("Freq\\(\\)", "Frequency", names(mergedDataSet))
names(mergedDataSet) <- gsub("BodyBody", "Body", names(mergedDataSet))
names(mergedDataSet) <- gsub("Acc", "Acceleration", names(mergedDataSet))
names(mergedDataSet) <- gsub("Gyro", "Gyroscope", names(mergedDataSet))
names(mergedDataSet) <- gsub("Mag", "Magnitude", names(mergedDataSet))

//
averagesMergedDataSet <- mergedDataSet %>% group_by(subject, activity) %>% summarise_each(funs(mean))

//
write.table(averagesMergedDataSet, "averagesMergedDataSet.txt", row.name=FALSE)

