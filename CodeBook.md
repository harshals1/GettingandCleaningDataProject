CodeBook File :- Peer Review Assignment
========================================================

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

#Reading Feature Data
Data is already downloaded and extracted into a folder

```r
#Set folder path and assigne Dataset folder as working directory
setwd("H:/getting_assign/HARDataset")
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.1.1
```

```
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
# Reading training set 
x_train <- read.table("./train/X_train.txt")

# Reading testing set
X_test <- read.table("./test/X_test.txt")

# Merge all data
X_all_data <- rbind(x_train,X_test)

## Label Features for data
features <- read.table ("features.txt")[,2]
names(X_all_data) <- features


# Reading activity Data
## Reading training set 
y_train <- read.table("./train/y_train.txt")

## Reading testing set
y_test <- read.table("./test/y_test.txt")

## Merge all data
Y_all_data <- rbind(y_train,y_test)


# Reading Subject Data
## Reading training set
sub_train <- read.table("./train/subject_train.txt")

## Reading testing set
sub_test <- read.table("./test/subject_test.txt")

## Merge all data
sub_all_data <- rbind(sub_train,sub_test)

## Label Subject Data
names(sub_all_data) <- "Subject_Number"

#Combine all data
# Combine all data into single set
fin_all_data <- cbind(X_all_data,Y_all_data,sub_all_data)

## Read activity labels
act_labels <- read.table ("activity_labels.txt")
#glimpse(fin_all_data)
```

# Extracts only the measurements on the mean and standard deviation for each measurement. 

```r
keepcols <- grep("*mean*|*std*",features)
keepdata <- X_all_data[,keepcols]
# Combine all data into single set for mean and std keeping for further use
keep_fin_all_data <- cbind(keepdata,Y_all_data,sub_all_data)

#refer to summary; document become lengthy if it is included, so commented out.
#glimpse(keep_fin_all_data)
```

# Uses descriptive activity names to name the activities in the data set

```r
## Combine activities data with activity names
keep_fin_all_data1 <- merge(keep_fin_all_data,act_labels,by="V1",all.x=TRUE,sort=FALSE)

##Update Column names for activity columns (number and name)
names(keep_fin_all_data1) <- gsub("V1", "Activity_Number", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("V2", "Activity_Names", names(keep_fin_all_data1))

#glimpse(keep_fin_all_data1)
```

# Appropriately labels the data set with descriptive variable names
 Information referred from Feturers_info.txt
 * "tbody" referes to Time.Body
 * "tgravity" refers to Time.Gravity
 * "fBody" refers to FFT.Body
 * "fgravity" refers to FFT.Gravity
 * "Mag"" refers to Magnitude
 * Corrected -Mean, -Std to Mean and Std respectively; also rRemoved () from column names.


```r
names(keep_fin_all_data1) <- gsub("tBody", "Time.Body", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("tGravity", "Time.Gravity", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("fBody", "FFT.Body-", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("fGravity", "FFT.Gravity-", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("Mag", "Magnitude", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("mag", "Magnitude", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("\\-mean\\(\\)", "Mean", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("\\-Mean\\(\\)", "Mean", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("\\-Std\\(\\)", "Std", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("\\-std\\(\\)", "Std", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("\\Freq\\(\\)", "Freq", names(keep_fin_all_data1))

#glimpse(keep_fin_all_data1)
```


# Create Tidy Dataset; with mean and write file

```r
#follwogin column produces warning; so removing, I can use activity_number
keep_fin_all_data1$Activity_Names <- NULL

tidy <- aggregate(keep_fin_all_data1, 
                by=list(Activity_group=keep_fin_all_data1$Activity_Number,
                        Subject_Group=keep_fin_all_data1$Subject_Number), FUN=mean)

# Deleting following columns since it is not useful anymore
tidy$Subject_Number <- NULL
tidy$Activity_Number <- NULL

#writing CSV
#write.csv(tidy,"tidy_data.csv")

#writing text file as requirement
write.table(tidy,"tidy_data.txt",row.names= FALSE)
```
