
#setwd("H:/getting_assign/HARDataset")
library(dplyr)

#Reading Feature Data
## Reading training set 
x_train <- read.table("./train/X_train.txt")

## Reading testing set
X_test <- read.table("./test/X_test.txt")

## Merge all data
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


# Combine all data into single set
fin_all_data <- cbind(X_all_data,Y_all_data,sub_all_data)


# Extracts only the measurements on the mean and standard deviation for each measurement. 
keepcols <- grep("*mean*|*std*",features)
keepdata <- X_all_data[,keepcols]
# Combine all data into single set for mean and std keeping for further use
keep_fin_all_data <- cbind(keepdata,Y_all_data,sub_all_data)

#summary(keep_fin_all_data)

# Uses descriptive activity names to name the activities in the data set
## Read activity labels
act_labels <- read.table ("activity_labels.txt")

## Combine activities data with activity names
keep_fin_all_data1 <- merge(keep_fin_all_data,act_labels,by="V1",all.x=TRUE,sort=FALSE)

##Update Column names for activity columns (number and name)
names(keep_fin_all_data1) <- gsub("V1", "Activity_Number", names(keep_fin_all_data1))
names(keep_fin_all_data1) <- gsub("V2", "Activity_Names", names(keep_fin_all_data1))

summary(keep_fin_all_data1)


# Appropriately labels the data set with descriptive variable names
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

summary(keep_fin_all_data1)
tidy <- aggregate(keep_fin_all_data1, 
                by=list(Activity_group=keep_fin_all_data1$Activity_Names,
                        Subject_Group=keep_fin_all_data1$Subject_Number), FUN=mean)

# Deleting following columns since it is not useful anymore
tidy$Activity_Names <- NULL
tidy$Subject_Number <- NULL
tidy$Activity_Number <- NULL

#writing CSV
#write.csv(tidy,"tidy_data.csv")

#writing text file as requirement
write.table(tidy,"tidy_data.txt",row.names= FALSE)
