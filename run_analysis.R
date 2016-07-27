library(data.table)
# We will be reading in the data.
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

x_train<-read.table("train/X_train.txt")
y_train<-read.table("train/y_train.txt")
subject_train<-read.table("train/subject_train.txt")

x_test<-read.table("test/X_test.txt")
y_test<-read.table("test/y_test.txt")
subject_test<-read.table("test/subject_test.txt")

#Combining the train and test data
x_combined<-rbind(x_train,x_test)
y_combined<-rbind(y_train,y_test)
subject_combined<-rbind(subject_train,subject_test)

#Finding where the mean and std data is located.
indices_4_mean<-grep("mean",features$V2)
indices_4_std<-grep("std",features$V2)

#Extracting the data that has to do with mean and std 
measurement_4_mean<-x_combined[,indices_4_mean]
measurement_names_4_mean<-features[indices_4_mean,]
colnames(measurement_4_mean)<-measurement_names_4_mean$V2

measurement_4_std<-x_combined[,indices_4_std]
measurement_names_4_std<-features[indices_4_std,]
colnames(measurement_4_std)<-measurement_names_4_std$V2

#Combining the mean and std variables.  After that I am
all_necessary_measurements<-cbind(measurement_4_mean,measurement_4_std)
all_necessary_measurements_activity<-cbind(all_necessary_measurements,Activity_or_Subject=factor(y_combined$V1))
all_necessary_measurements_subjects<-cbind(all_necessary_measurements,Activity_or_Subject=factor(subject_combined$V1))

#All measurements
final_measurements<-cbind(Activity=y_new$V2,Subject=subject_combined$V1,all_necessary_measurements)

#Calculating the averages of the subjects
temporary_variable<-data.table(all_necessary_measurements_subjects)
averages_4_subjects<-temporary_variable[,lapply(.SD,mean),by=Activity_or_Subject]
averages_4_subjects<-averages_4_subjects[order(Activity_or_Subject)]

#Calculating the averages of the activities
temporary_variable_2<-data.table(all_necessary_measurements_activity)
averages_4_activities<-temporary_variable_2[,lapply(.SD,mean),by=Activity_or_Subject]
averages_4_activities<-averages_4_activities[order(Activity_or_Subject)]
averages_4_activities$Activity_or_Subject<-activity_labels$V2

#Combining the averages and activities to create the final dataset that will be extracted
averages_4_activities_2<-cbind(Class=factor("Activity"),averages_4_activities)
averages_4_subjects_2<-cbind(Class=factor("Subject"),averages_4_subjects)
averages_all<-rbind(averages_4_activities_2,averages_4_subjects_2)

#The final data.
write.table(averages_all,file="mean_std_avg_all.txt",row.names = FALSE)