Data Science Coursera Project
===============================
Alonzo Castanon - Nov 18th, 2017

Project Details
-----
This project assumes the UCI HAR Dataset is downloaded and extracted, and run_analysis.r is placed in it's root directory ("./UCI HAR Dataset/run_analysis.r")

By running "run_analysis.r" in the proper directory, you are creating: "./UCI HAR Dataset/tidy.csv", a dataset made from "cleaned_raw", containing the average of each variable in it for each activity and each subject

Also included in this package is a file "codebook.md", which contains a description of the "tidy.csv".

Methodology
--------
*Keep in mind "run_analysis.R" is fairly well commented, if more specific information is necessary*

The script follows the following procedure:
1. Read Y data, namely "y_test.txt" and "y_train.txt"
2. Read X data, namely "X_test.txt" and "x_train.txt"
3. Read Subject data, namely "subject_test.txt" and "subject_train.txt"
4. Use cbind to combine all test data to one "test_data" frame (e.g. row 1 is is Y data, row 2 is subject data, all other rows are X data)
5. Repeat step 4 for a seperate "train_data" frame
6. Use "features.txt" to properly rename the columns in "test_data" and "train_data" to more descriptive names (e.g. "Activity", "Subject", "tBodyAcc-mean()-X", etc...)
7. Now that column names are equal, merge "test_data" and "train_data" to one "unified_data" frame using rbind
8. Use "activity_labels.txt" to replace Activity column with a descriptive character vector (1 -> WALKING, 2 -> WALKING_UPSTAIRS, etc...)
9. Use grep to drop columns not relating to mean, std, Activity, or Subject
10. Use aggregate to create a new dataset called "tidy" that is the mean of each variable in cleaned_data for each Activity for each Subject
11. Write out "tidy.csv" using write.csv