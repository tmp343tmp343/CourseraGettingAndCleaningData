## Course Project, 21 September 2014
## The data linked to from the course website represent data collected from the 
## accelerometers from the Samsung Galaxy S smartphone.

########### Part 1 ############
# Extract the names of all 561 variables measured
feature_names = read.table("./UCI HAR Dataset/features.txt", 
                           sep="", col.names=c("index", "name"))
## Setup the test data ##
# Extract the measurements for all the volunteers in the test group
test_data_orig = read.table("./UCI HAR Dataset/test/X_test.txt", 
               sep="", col.names=feature_names$name)

# Extract the id number (1-30) assigned to each volunteer in the test group
subject_test_orig = read.table("./UCI HAR Dataset/test/subject_test.txt", sep="")

# Extract the id number (1-6) assigned to each activity performed by the test group
activity_test_orig = read.table("./UCI HAR Dataset/test/y_test.txt", sep="")  

## Setup the train data ##
# Extract the measurements for all the volunteers in the train group
train_data_orig = read.table("./UCI HAR Dataset/train/X_train.txt", 
                            sep="", col.names=feature_names$name)

# Extract the number (1-30) assigned to each volunteer in the train group
subject_train_orig = read.table("./UCI HAR Dataset/train/subject_train.txt", sep="")

# Extract the id number (1-6) assigned to each activity performed by the train group
activity_train_orig = read.table("./UCI HAR Dataset/train/y_train.txt", sep="") 

## Merge the test and train data into one dataset ##
library(data.table)
DTtest=data.table(Volunteer=subject_test_orig$V1,Activity=activity_test_orig$V1,test_data_orig)
DTtrain=data.table(Volunteer=subject_train_orig$V1,Activity=activity_train_orig$V1,train_data_orig)
all_data=rbind(DTtest,DTtrain)

########### Part 2 ############
# Identify which of the 561 variables are the mean or standard deviation of measurements
mean_std<-c(grep("mean()",feature_names$name,fixed=TRUE),grep("std()",feature_names$name,fixed=TRUE))
mean_std<-mean_std+2 ## account for Volunteer and Activity columns 

# Create a new dataset that only contains the variables on the 
# mean and standard deviation for each measurement. 
mean_std_data<-subset(all_data,select=c(1:2,mean_std))

########### Part 3 ############
# Extract the names of all 6 activities performed
activity_names = read.table("./UCI HAR Dataset/activity_labels.txt", 
                           sep="", col.names=c("index", "name"))

# Construct a new column vector with the corresponding activity names  
Activity.Name<-character(length=10299)
for (i in 1:6) {
Activity.Name[grep(as.character(i),mean_std_data$Activity,fixed=TRUE)]<-as.character(activity_names$name[i])
}

# Replace Activity column with numeric values 
mean_std_data_activity_names<-cbind(subset(all_data,select=1),Activity.Name,subset(all_data,select=mean_std))

########### Part 4 ############
## Was already accomplished in Part 1.

########### Part 5 ############
tidy_data<-character()
for (i in 1:30){ ## loop through all 30 volunteers
        rows_needed1<-grep(i,mean_std_data_activity_names$Volunteer,fixed=TRUE)
        for (j in activity_names$name){ ## loop through all 6 activities
                rows_needed2<-grep(j,mean_std_data_activity_names$Activity.Name,fixed=TRUE)
                rows_needed<-intersect(rows_needed1,rows_needed2)
                rows_needed_logical<-logical(length=10299)
                for (k in rows_needed) {
                        rows_needed_logical[k]<-TRUE    
                }
                
                ## Create a matrix of all the measurements for Volunteer i and Activity j
                DT1<-data.matrix(subset(mean_std_data_activity_names,subset=rows_needed_logical,select=3:68))
                
                ## Consruct the tidy data by binding the measurement means for all volunteers and all activities 
                tidy_data<-rbind(tidy_data,cbind("Volunteer"=rep(i,66),"Activity"=rep(j,66),"Measurement Mean"=colMeans(DT1)))      
        } 
        
}
write.table(tidy_data,file="./tidy_data.txt")