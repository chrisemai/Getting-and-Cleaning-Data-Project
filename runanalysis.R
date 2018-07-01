###1
#Merges the training and the test sets to create one data set.
library(dplyr)

#set working directory
setwd("~/Desktop/Coursera/Data Cleaning/week4")

#start by reading in the files as txt format
activity_labels<-read.table("activity_labels.txt",header=FALSE) #this is the key for activity labels
features<-read.table("features.txt",header=FALSE) #column headers

#TEST
##read test data 
setwd("~/Desktop/Coursera/Data Cleaning/week4/test")

subject_test<-read.table("subject_test.txt",header=FALSE) 
x_test<-read.table("x_test.txt",header=FALSE)  
y_test<-read.table("y_test.txt",header=FALSE) 

#add labels to test dataframes
colnames(x_test) <- features[,2]
colnames(subject_test) <- "subject"
colnames(y_test) <- "activity"

#bind these three dataframes together
test_data<-bind_cols(subject_test, y_test, x_test) 


#TRAIN
##read train data 
setwd("~/Desktop/Coursera/Data Cleaning/week4/train")

subject_train<-read.table("subject_train.txt",header=FALSE) 
x_train<-read.table("x_train.txt",header=FALSE) 
y_train<-read.table("y_train.txt",header=FALSE) 

#add labels to training dataframes
colnames(x_train) <- features[ , 2]
colnames(subject_train) <- "subject"
colnames(y_train) <- "activity"

#bind these three dataframes together
train_data<-bind_cols(subject_train, y_train, x_train) 

#bind together test and training datasets 
data<-bind_rows(train_data,test_data)


###2
#Extracts only the measurements on the mean and standard deviation for each measurement.
strings <- c("mean", "std")
data2 <- data[ ,  grepl(paste(strings, collapse = "|"), names( data ) ) ] #gives mean and std rows
firstcols <- data[ , 1:2] #the first two columns (subject and activity)

#pulls together subject and activity columns with mean & std columns
datafinal <- bind_cols(firstcols, data2)


###3
#Uses descriptive activity names to name the activities in the data set
datafinal$activity_label <- activity_labels$V2[match(datafinal$activity,activity_labels$V1)] 

###4
#Appropriately labels the data set with descriptive variable names.
names(datafinal)

#replaces t and f at start of variables with time and frequency
names(datafinal) <- sub("^t", "time", names(datafinal))
names(datafinal) <- sub("^f", "frequency", names(datafinal))

#clean up other variable names
names(datafinal) <- sub("Acc", "Accelerometer", names(datafinal))
names(datafinal) <- sub("Gyro", "Gyroscope", names(datafinal))
names(datafinal) <- sub("Mag", "Magnitude", names(datafinal))

#final tidy dataset
datafinal

###5
#From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.
datafinal_mean <- datafinal %>% group_by(activity_label,subject) %>% summarize_all(funs(mean))

