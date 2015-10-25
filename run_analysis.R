run_analysis <- function(){

  # NEXT STEPS
  # Guarantee that the final data is tidy
  # Guarantee that the script access the files without any intervention outsite R

  # This function was develop as an assignment to the Getting and Cleaning Data course
  # by John Hopkins University on Coursera. It works over a dataset of measurements 
  # of signals from the accelerometer and gyroscope of a Samsung Galaxy S smartphone.
  # Details on the dataset may be found at
  # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  # Detailes on the assignment may be found at
  # https://class.coursera.org/getdata-033/human_grading/view/courses/975117/assessments/3/submissions

  # PREPARATION
  library(dplyr)
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","getdata.zip")
  unzip("getdata.zip")
    
  # FIRST STEP
  # Merge two datasets: test measuraments and train measurements.
  test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  train <- read.table("./UCI HAR Dataset/train/x_train.txt")
  #Merges the test and train data sets into one complete dataset
  complete <- bind_rows(test,train)
  
  
  # SECOND STEP
  # Finds which columns from the data set contains the mean and standard deviation
  # for each measurement. It is not clear from course instructions what is 
  # considered "measurement". For the purpose of this exercise, I considered every
  # variable with the texts "mean", "Mean" and "std" as variables to be selected.
  
  # Imports variables codes and names
  features <- read.table("./UCI HAR Dataset/features.txt")
  # Name the columns on complete data frame
  names(complete) <- features$V2
  # Make every column with a different name
  names(complete) <- make.names(names(complete),unique = TRUE)
  # Return the variables codes for those names containing the string "mean"
  features_mean <- filter(features,grepl("mean",V2))
  # Return the variables codes for those names containing the string "Mean"
  features_Mean <- filter(features,grepl("Mean",V2))
  # Return the variables codes for those names containing the string "std".
  # Deserves note that exploring the database, no variable with "Std" was found.
  features_std <- filter(features,grepl("std",V2))
  # Binds all variables codes with "mean", "Mean" or "std" strings
  features_selected <- bind_rows(features_mean,features_Mean,features_std)
  # Select the desired columns
  complete_selected <- select(complete,features_selected$V1)

  # THIRD STEP
  # Include on the measurements datasets (train and test) the activity description
  act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  train_labels_code <- read.table("./UCI HAR Dataset/train/y_train.txt")
  test_labels_code <- read.table("./UCI HAR Dataset/test/y_test.txt")
  train_labels <- select(merge(train_labels_code,act_labels),V2)
  test_labels <- select(merge(test_labels_code,act_labels),V2)
  labels <- bind_rows(test_labels,train_labels)
  names(labels) <- "activity"
  complete_act <- bind_cols(complete_selected,labels)
  
  # FOURTH STEP
  # Change the variable names on the dataset from codes to descriptive names. All column names
  # were already changed on previous steps.

  # FIFTH STEP
  # Creates an independent tidy dataset with the average of each variable for 
  # each activity and each subject
  train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  complete_subjects <- bind_rows(test_subjects,train_subjects)
  names(complete_subjects) <- "subject"
  complete_act_sub <- bind_cols(complete_act,complete_subjects)
  
  tidy_complete <- group_by(complete_act_sub,activity,subject)

  summary <- summarise_each(tidy_complete, funs(mean))
  write.table(summary,"summary.txt",row.names = FALSE)
  print(summary)
}