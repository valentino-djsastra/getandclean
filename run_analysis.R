### Download files

if(!file.exists("./dataset")) {
      dir.create("./dataset")
}

datalink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(datalink, destfile ="./dataset/Dataset.zip")

unzip(zipfile="./dataset/Dataset.zip",exdir="./dataset")

### Merges the training and the test sets to create one data set

# Read Training data
sub_train <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt")

# Read Test data
sub_test <- read.table("./dataset/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./dataset/UCI HAR Dataset/test/y_test.txt")

# Read activity labels & feature 
actlabel <- read.table("./dataset/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./dataset/UCI HAR Dataset/features.txt")

### Appropriately labels the data set with descriptive variable names.
colnames(sub_train) <- "subject_Id"
colnames(x_train) <- features[,2]
colnames(y_train) <-"activity_Id"

colnames(sub_test) <- "subject_Id"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activity_Id"

colnames(actlabel) <- c('activity_Id', 'activity_Type')

# Merge training & test data
master_train <- cbind(x_train, y_train, sub_train)
master_test <- cbind(x_test, y_test, sub_test)
master_data <- rbind(master_train, master_test)

### Extracts only the measurements on the mean and standard deviation for each measurement

# Put column names in a vector
col_names <- colnames(master_data)

# Create vector for defining ID, mean and standard deviation:
MSD <- (grepl("activity_Id" , col_names) | grepl("subject_Id" , col_names) | 
              grepl("mean.." , col_names) | grepl("std.." , col_names))

# subset from Master Data
subset_MSD <- master_data[ , MSD == TRUE]

### Uses descriptive activity names to name the activities in the data set
Master_withact <- merge(subset_MSD, actlabel, by='activity_Id', all.x=TRUE)

# Creates a 2nd independent tidy data set with the average of each variable for each activity & subject.
tidy_Data <- aggregate(. ~subject_Id + activity_Id, Master_withact, mean)
tidy_Data <- tidy_Data[order(tidy_Data$subject_Id, tidy_Data$activity_Id),]

write.table(tidy_Data, "./tidy_data.txt", row.name=FALSE)
