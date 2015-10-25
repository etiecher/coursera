# coursera

The run_analysis function was develop as an assignment to the Getting and Cleaning Data course
by John Hopkins University on Coursera. It works over a dataset of measurements 
of signals from the accelerometer and gyroscope of a Samsung Galaxy S smartphone carried by 30 different users
performing six different activities during an experiment to analyze how these sensors would respond to these
activities.

Details on the dataset may be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Detailes on the assignment may be found at
https://class.coursera.org/getdata-033/human_grading/view/courses/975117/assessments/3/submissions

The function starts preparing the conditions to R perform the analysis. It opens dplyr library, download all the
data and unzip it to local folders.

The provided file strucutures divides the data into two datasets: one used for training and a second used to test
the training data. For the purpose of the assignment, the script merges the two datasets into one called "complete"

The assignment requires to analyze only the measurements