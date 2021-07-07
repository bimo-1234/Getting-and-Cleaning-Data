#Merges the training and the test tests to create one data set
x<-rbind(x_train, x_test)
y<-rbind(y_train,y_test)
Subject<-rbind(subject_train,subject_test)
Merged_Data<-cbind(Subject,Y,X)
 #Extracts on;y the measurements on the mean and standard deviation for each measurement
TidyData<-Merged_Data%%select(subject, code, contains("mean"), contains("std"))
#Using descriptive activity names to name the activities in the dataset
TidyData$code<-activities[TidyData$code,2]

#Labelling the data set with descriptive variable names
names(TidyData)[2]= "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag","Magnitude", names(TidyData))
names(TidyData)<-gsub("^f"," frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody" , names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean" , names(TidyData),ignore.case=TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignoe.case=TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData),ignore.case=TRUE)                     
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#Step 5
FinalData<-TidyData %>%
group_by(subject,activity)%>%  
sumarise_all(funs(mean))  
write.table(FinalData, "FinalData,txt", row.name=FALSE)
