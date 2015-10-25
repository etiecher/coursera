# coursera

The run_analysis function was develop as an assignment to the Getting and Cleaning Data course
by John Hopkins University on Coursera. It works over a dataset of measurements of signals from the accelerometer 
and gyroscope of a Samsung Galaxy S smartphone carried by 30 different volunteers (subjects) performing six different 
activities (like walking and laying) during an experiment to analyze how these sensors would respond on these activities.

Details on the dataset may be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Detailes on the assignment may be found at
https://class.coursera.org/getdata-033/human_grading/view/courses/975117/assessments/3/submissions

The function starts preparing the conditions to R perform the analysis. It opens dplyr library, download all the
data (which included multiple folders and files) and unzip it to the R working directory.

The experiment divided the data recorded into two datasets: one used for training (./UCI HAR Dataset/train/x_train.txt)
and a second used to test the training data (./UCI HAR Dataset/test/x_test.txt). For the purpose of the assignment, 
the script merges the two datasets into one data frame called "complete".

The assignment requires to analyze only the mean and standard deviation measurements of the experiment. The "complete"
data frame doesn't contain descriptive column names. The script refers to another file (./UCI HAR Dataset/features.txt)
which contains this information. It first name every column in the "complete" data frame and then select only the desired
columns (the ones that contain "mean", "Mean" or "std" on their names). The main data frame with this new information is
called "complete_selected". Deserves note the fact that there were duplicate columns names from features.txt. Analizying
the data is possible to verify that the columns have different data and refers to different measurements.

Another missing information on the complete data frame is about the activities that each row refers to. The scrip refers
to another files (./UCI HAR Dataset/train/y_train.txt, ./UCI HAR Dataset/test/y_test.txt). It also changes the activity
code to its label based on one more file (./UCI HAR Dataset/activity_labels.txt). The main data frame with this new 
information is called "complete_act".

The assignment also requires as a fourth step to label the data set with appropriate names, but this was done on previous
steps.

The final requirement from the assignment is to present a data set the summarizes (group) the results by activity and
subject. For this, the script first adds the data from another separate files (./UCI HAR Dataset/train/subject_train.txt,
./UCI HAR Dataset/test/subject_test.txt) that registers which subject have each measurement. The main data frame with this
new information is called "complete_act_sub".

After that the script creates a data frame called tidy_complete that groups the measurements by subject and activity. This
data frame is summarized in  data frame called "summary", containing the mean for each group. Finally, this data frame is
exported to the "summary.txt", also available in the repository.
