#reading file names
files=list.files("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset",recursive = TRUE)

#Reading training tables - xtrain / ytrain, subject train
xtrain=read.table("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset/train/X_train.txt",header = FALSE)
ytrain=read.table("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset/train/Y_train.txt",header = FALSE)
subject_train=read.table("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

#Reading the testing tables
xtest=read.table("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset/test/X_test.txt",header = FALSE)
ytest=read.table("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset/test/Y_test.txt",header = FALSE)
subject_test=read.table("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

#Read the features data
features=read.table("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset/features.txt",header = FALSE)
#Read activity labels data
activityLabels=read.table("C:/Users/TAMBEM01/Desktop/New folder/UCI HAR Dataset/activity_labels.txt",header = FALSE)

View(xtrain)
View(features)
nrow(features)
nrow(xtest)
ncol(xtest)
ncol(xtrain)
View(activityLabels)
View(subject_test)
View(subject_tain)
View(ytrain)
ncol(ytrain)
View(subject_test)

#2)
#Create Sanity and Column Values to the Train Data
colnames(xtrain)=features[,2]
colnames(ytrain) = "activityId"
colnames(subject_tain) = c('subjectId')
#Create Sanity and column values to the test data
colnames(xtest)=features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"
#Create sanity check for the activity labels value
colnames(activityLabels)=c('activityId','activityType')

#1)Create the main data table merging both train and test tables
merge_train=cbind(xtrain,subject_tain,ytrain)
names(merge_train)
merge_test=cbind(xtest,subject_test,ytest)
allCombined=rbind(merge_train,merge_test)
names(merge_test)

nrow(allCombined)
nrow(xtest)

#3)Extracts only the measurements on the mean and standard deviation for each measurement
column_names=colnames(allCombined)
mean_and_std = (grepl("activityId" , column_names) | grepl("subjectId" , column_names) | grepl("mean.." , column_names) | grepl("std.." , column_names))
setForMeanAndSD=allCombined[,mean_and_std==TRUE]
View(setForMeanAndSD)

#4)Uses descriptive activity names to name the activities in the data set
View(activityLabels)
LabeledData=merge(setForMeanAndSD,activityLabels,by = 'activityId',all.x = TRUE)
?merge
View(LabeledData)

#Creating Tidy Dataset
?aggregate
tidyData=aggregate(. ~subjectId+activityId,LabeledData,mean)
tidyData=tidyData[order(tidyData$subjectId,tidyData$activityId),]
View(tidyData)

#writing the ouput to a text file 
write.table(tidyData, "TidyDataSet.txt", row.name=FALSE)
