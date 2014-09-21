CourseraGettingAndCleaningData
==============================

## Code Book

The run_analysis.R file is broken up into five parts corresponding to the five steps
given in the README.md file.

### Study Design
A full description of the data is available at the site where the data was originally obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
For this project the run_analysis.R script uses the following files

1. features.txt: contains the names of the 561 variables measured
2. activity_labels.txt: contains the names of the 6 activities performed
3. subject_test.txt: contains the id (1-30) of each volunteer in the test set
4. X_test.txt: contains the test data, which is 30 percent of the total dataset
5. y_test.txt: contains the id (1-6) of each activity performed in the test set
6. subject_train.txt: contains the id (1-30) of each volunteer in the train set
7. X_train.txt: contains the train data, which is 70 percent of the total dataset
8. y_train.txt: coontains the id (1-6) of each activity performed in the train set

### Important Variables in run_analysis.R

1. feature_names: a data frame containing the names of all 561 measurements
2. all_data: a data table containing the merged train and test data (10299 observations)
3. mean_std_data: a subset of all_data that contains only the mean and standard deviation of collected measurements (66 variables)
4. activity_names: a data frame containing the names of all 6 activities and their corresponding ids
5. mean_std_data_activity_names: the same as mean_std_data except that the activity ids are replaced by the activity names
6. tidy_data: a tidy dataset in which each row is only one observation and each column is only one variable; contains the mean of each variable in mean_std_data_activity_names for each volunteer for each activity

### Choices Made

I executed Part 4 within Part 1 because it made more sense to me to label the variables
with their measurement names right away. I used loops to create the tidy dataset, but there
is probably a more elegant way to do this.