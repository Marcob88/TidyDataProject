# # 0 # #  Downloading and unzipping dataset

if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/dataset.zip")
list.files("./data")
unzip(zipfile="./data/dataset.zip",exdir="./data")


# # 1. # # MERGING THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET 

 # # 1.1  # Loading the training files
x_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

 # # 1.2  #Loading the testing files
x_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")

 # #  1.3 # Loading activity labels and features
activityLabels<-read.table('./data/UCI HAR Dataset/activity_labels.txt')
features<-read.table('./data/UCI HAR Dataset/features.txt')

 # #  1.4 # Assingning column names
colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

 # # 1.5 # Merging the training and the test sets to create one data set
train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(train, test)

                     

# # 2. # # EXTRACTING ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

 # # 2.1 # Reading column names
colNames <- colnames(setAllInOne)

 # # 2.2 #  Creating a vector for defining ID, mean and standard deviation
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
                 )

 # # 2.3 # Making necessary subset (mean and standard deviation) from setAllInOne:
subset_mean_and_sd <- setAllInOne[ , mean_and_std == TRUE]



# # 3. # # Using descriptive activity names to name the activities in the data set

subset_activitynames <- merge(subset_mean_and_sd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# # 4.1 # # Labelling the data set with descriptive variable names

 # Step developed across 1.5, and 2.2-2.3 sections;

# # 5. # # CREATING A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT 

 # # 5.1 # Making second tidy data set

secTidySet <- aggregate(. ~subjectId + activityId, subset_activitynames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
     
 # # 5.2 # Writing secTidySet in txt file
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
