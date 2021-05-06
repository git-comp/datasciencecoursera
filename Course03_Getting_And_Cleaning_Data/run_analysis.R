library(reshape2)
library(data.table)

## download and unzip file
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")


# Load activityLabels, features
activityLabels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"), col.names = c("classLabels", "activityName"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt"), col.names = c("index", "featureNames"))

# extract wanted features with mean and std deviation from features, exclude Mean in brackets
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]

## remove brackets
measurements <- gsub('[()]', '', measurements)

# Load train dataset
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, featuresWanted, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))
trainSubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt"), col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)

# Load test dataset
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, featuresWanted, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt"), col.names = c("Activity"))
testSubjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt"), col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

# merge datasets
merged <- rbind(train, test)

# Replace classLabel (activityID) with more verbose description activityName
merged[["Activity"]] <- factor(merged[, Activity], levels = activityLabels[["classLabels"]], labels = activityLabels[["activityName"]])

# Convert SubjectNum from numeric to factor
merged[["SubjectNum"]] <- as.factor(merged[, SubjectNum])

# melt and cast
merged <- melt(merged, id = c("SubjectNum", "Activity"))
merged <- dcast(merged, SubjectNum + Activity ~ variable, mean)

# export to file
data.table::fwrite(x = merged, file = "tidyData.txt", quote = FALSE)