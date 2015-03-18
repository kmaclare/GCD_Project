# Code Book for GCD Project

The original data set contained 561 measures of acceleromter data from Smarphones worn by 30 subjects performing 6 different activities

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The output data is only concerned with mean and standard deviation of each measure, and then further summarized to be the average of each mean & std
based on each subject across 6 different activities.

"Subject" "Activity" "Time-based Body Acceleration Mean X" "Time-based Body Acceleration Mean Y" "Time-based Body Acceleration Mean Z" "Time-based Body Acceleration Standard Deviaion X" ... etc.
Enjoy!
