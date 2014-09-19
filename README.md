Readme File for Peer Review Assignment
=============================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

I have started with 
1) Setting working directory.
2) Reading all files from test and train directory.
3) Combined all data using "cbind""
4) Extracted Measures on mean and std; based on column names from extracted data.
5) Added activity names from "activity file" data extracted in step 2.
6) Updated column names appropriately by adding description.
7) Created tidy data set with average of each variable; grouping by activity and subject.

CodeBook file is also available as per requirement in repository.

Prerequsites:-
1) Data is already downloaded and extracted in the workign directory.
2) If you are running R code then; set appropriately your workign directory. Working directory will have all text files and traing/test folders respectively.
3) Install "dplyr" package. used glimpse function many time; which is commented out.