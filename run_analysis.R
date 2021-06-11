##### Week 4 Getting and Cleaning Data final assessment #####

# Requirements: 
#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names. 
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject


### Step 1: loading libraries
library(tidyverse)
library(magrittr)
library(dplyr)


### Step 2: loading the training and test sets 

setwd("~/R/train")
train_data<-read.table("X_train.txt")

#setwd('..')
setwd("~/R/test")
test_data<-read.table("X_test.txt")

#### Step 3: merging the datasets

merged_data<-rbind(train_data,test_data)


### Step 4: labelling data with features and activities ##


setwd("~/R")
features<-read.table("features.txt")
colnames(merged_data) = features$V2

# loading activity label names #

setwd("~/R")
activities_names<-read.table("activity_labels.txt")
setwd("~/R/train")
train_labs<-read.table("y_train.txt")
setwd("~/R/test")
test_labs<-read.table("y_test.txt")

### Step 5: Merging the training and test set label data ##

activity_labs<-rbind(train_labs,test_labs)

### Step 6: Tapping into the descriptive labels and replacing the numeric values
### in the label vector above with the descriptive names ###


a = activities_names[1,2]
b = activities_names[2,2]
c = activities_names[3,2]
d = activities_names[4,2]
e = activities_names[5,2]
f = activities_names[6,2]


activity_labs %<>%
  mutate(V1 = gsub(1,a,V1),
         V1 = gsub(2,b,V1),
         V1 = gsub(3,c,V1),
         V1 = gsub(4,d,V1),
         V1 = gsub(5,e,V1),
         V1 = gsub(6,f,V1)) %>%
  rename(activities = V1)

### Step 7: merging the vector of descriptive activity labels with the main data frame ##

merged_data<-cbind.data.frame(merged_data,activity_labs)


### Creating a second, independent tidy data set with the average of each variable for each activity and each subject

### Loading up subject info ###

setwd("~/R/test")
test_ss<-read.table("subject_test.txt")

setwd("~/R/train")
train_ss<-read.table("subject_train.txt")

subjects<-rbind(train_ss,test_ss)
merged_data<-cbind(merged_data,subjects)

colnames(merged_data)[colnames(merged_data) == "V1"] <- "subjects"

### Some columns contain duplicate data; removing that here ###


duplicates_removed <-merged_data %>% subset(., select=which(!duplicated(names(.))))

### Final table with averages ###

final_datatable = aggregate(. ~ subjects + activities, data = duplicates_removed, FUN = mean)
