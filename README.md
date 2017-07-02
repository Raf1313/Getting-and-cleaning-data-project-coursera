# Getting-and-cleaning-data-project-coursera
Project for the coursera course "getting and cleaning data"

## run_analysis.R

The run_analysis.R script does the following:
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Process

 1. The code download the file if it doesn't exist and then unzip it. If it already exist, it just unzip it.
 2. For both the test and train dataset, it list files containing the data, read them and combine them to get two dataframe : one for the train set and the other for the test set.
 3. It merge the two dataframe in one called "Cleaned_data"
 4. It names the Cleaned_data dataframe according to the names provided in the "features" files.
 5. It select the mean and standard deviation features (according to the codeBook"
 6. Rename the variables names and the activity label
 7. Compute a new dataframe called MeanData and containing the mean of each variables grouped by activity
 8. Write the two dataFrame on the disk
