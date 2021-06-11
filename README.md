# Week4_GettingandCleaningData
Final peer-graded assignment

This document is to explain the steps I undertook to clean up the data for our final assignment of the course.



Step 1: load the libraries I will need for the process.

Step 2: set my work directory to the 'train' and 'test' folders in turn to extract the training and test data sets using the read.table() function.

Step 3: merge the datasets using the rbind function to create a single dataframe.

Step 4: load the 'features.txt' document, extracting the column featuring the names. Then using the colnames() function to simply replace its current contents with the descriptive labels from the 'features' document. Continue with downloading the 'activity_labels.txt' and the 'y_train.txt' + 'y_test.txt' docs, which contain data about the activities participants were engaging in. 

Step 5: Use the rbind() function to stick the test and train y-values together. These will later be merged with the larger dataset, but first all the digits (1-6) need to be replaced with descriptive labels, as requested by the assignment. 

Step 6: To replace numbers with descriptive labels in the activity vector, I use indexing to tap into the individual descriptive labels and save them as a series of variables going from a-f. I then use the gsub function to replace the digits within the vector of labels with the descriptive labels contained in these single-letter variables. I use mutate() to replace the numeric contents of the vector (so far called V1) with the letters. Then rename it to be called 'activities' to make understanding the dataframe a bit more straightforward. 

Step 7: Merge the resulting vector of descriptive activity labels with the main dataframe using cbin.data.frame()

Step 8: To create an independent dataset containing the average for each variable, activity, and feature, I next need to load up the subject data. I use setwd() and read.table() to set my working directory to the appropriate folders and extract the 'subject_test.txt' and 'subject_train.txt' data. I bind these together using rbind() and merge with the main daataframe using cbind(). I then rename that nexly added column (which is currently named V1) to 'subjects'. 

Step 9: After removing some duplicate columns, I use the aggregate() function to calculate average features for each feature, separately for each subject and activity.  This resulting table is called 'final_datatable'.
