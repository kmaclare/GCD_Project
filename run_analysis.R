# Coursera - Getting & Cleaning Data
# 
# Course Project

globaldf <- data.frame()
#Step 1.Merge the training and the test sets to create one data set.
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# build single data frame with labels, training, test data
  # subject column from rbind of subtrain & subtest
globaldf <- rbind(globaldf, subtrain)
globaldf <- rbind(globaldf, subtest)
  # activity column from rbind of ytrain & ytest
ytrain <- rbind(ytrain, ytest)
globaldf <- cbind(globaldf, ytrain)
  # data from rbind of 2nd variable of feature data (transpose?), xtrain & xtest
xtrain <- rbind(xtrain, xtest)
globaldf <- cbind(globaldf, xtrain)

colVector <- c()
for (i in 1:nrow(features)) {
    colVector <- c(colVector, as.character(features[i,2]))    
}
colVector <- c("Subject", "Activity", colVector)

# set column names of data frame
colnames(globaldf) <- colVector

#Step 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

# subset data frame: look for mean(), std() in feature name
subdf <- globaldf[,(grep("Subject|Activity|mean\\(\\)|std\\(\\)", colnames(globaldf))) ]

subdf$Subject <- as.factor(subdf$Subject)
subdf$Activity <- as.character(subdf$Activity)

#Step 3.Uses descriptive activity names to name the activities in the data set

# convert activity code in data frame to Activity name (of 6 activities)
for (j in 1:nrow(subdf)) {
    # activities df has number in column 1 to match subdf column 2 value
    temp <- as.numeric(subdf[j,2])
    subdf[j,2] <- as.character(activities[temp,2])
    # set column 2 value of subdf to text value in column 2 of activities df    
}

subdf$Activity <- as.factor(subdf$Activity)

#4.Appropriately labels the data set with descriptive variable names. 

# human readable names instead of "tBodyAcc-std()-Y"
colnames(subdf) <- gsub("-", " ", colnames(subdf))
colnames(subdf) <- sub("mean\\(\\)", "Mean", colnames(subdf))
colnames(subdf) <- sub("std\\(\\)", "Standard Deviaion", colnames(subdf))
colnames(subdf) <- sub("tBodyAcc", "Time-based Body Acceleration", colnames(subdf))
colnames(subdf) <- sub("tGravityAcc", "Time-based Gravity Acceleration", colnames(subdf))
colnames(subdf) <- sub("tBodyAccJerk", "Time-based Body Jerk Acceleration", colnames(subdf))
colnames(subdf) <- sub("tBodyGyro", "Time-based Body Gyroscope", colnames(subdf))
colnames(subdf) <- sub("tBodyGyroJerk", "Time-based Body Gyroscope Jerk", colnames(subdf))
colnames(subdf) <- sub("tBodyAccMag", "Time-based Body Acceleration Magnitute", colnames(subdf))
colnames(subdf) <- sub("tGravityAccMag", "Time-based Gravity Acceleration Magnitute", colnames(subdf))
colnames(subdf) <- sub("tBodyAccJerkMag", "Time-based Body Acceleration Jerk Magnitute", colnames(subdf))
colnames(subdf) <- sub("tBodyGyroMag", "Time-based Body Gyroscope Magnitute", colnames(subdf))
colnames(subdf) <- sub("tBodyGyroJerkMag", "Time-based Body Gyroscope Jerk Magnitute", colnames(subdf))
colnames(subdf) <- sub("fBodyAcc", "Frequency-based Body Acceleration", colnames(subdf))
colnames(subdf) <- sub("fBodyAccJerk", "Frequency-based Body Jerk Acceleration", colnames(subdf))
colnames(subdf) <- sub("fBodyGyro", "Frequency-based Body Gyroscope", colnames(subdf))
colnames(subdf) <- sub("fBodyAccMag", "Frequency-based Body Acceleration Magnitute", colnames(subdf))
colnames(subdf) <- sub("fBodyBodyAccJerkMag", "Frequecy-based Body-Body Acceleration Jerk Magnitute", colnames(subdf))
colnames(subdf) <- sub("fBodyBodyGyroMag", "Frequecy-based Body-Body Gyroscope Magnitute", colnames(subdf))
colnames(subdf) <- sub("fBodyBodyGyroJerkMag", "Frequency-based Body-Body Gyroscope Jerk Magnitute", colnames(subdf))

#5.From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

# subject  activity  avg(var1)  avg(var2) ....
# s1       WALKING
# s1       RUNNING

subdf.means <- aggregate(subdf[,c(3:ncol(subdf))], by=subdf[c("Subject", "Activity")], FUN=mean)
subdf.means <- subdf.means[order(subdf.means$Subject),]

# export data frame to text file
write.table(subdf.means, "output.txt", row.name=FALSE)

