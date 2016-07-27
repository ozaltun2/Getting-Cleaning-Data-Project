library(data.table)

features<-read.table("/Users/Bora/RStudio/Week-4/UCI_HAR_Dataset/features.txt")
activity_labels<-read.table("UCI_HAR_Dataset/activity_labels.txt")

x_train<-read.table("/Users/Bora/RStudio/Week-4/UCI_HAR_Dataset/train/X_train.txt")
y_train<-read.table("/Users/Bora/RStudio/Week-4/UCI_HAR_Dataset/train/y_train.txt")
subject_train<-read.table("/Users/Bora/RStudio/Week-4/UCI_HAR_Dataset/train/subject_train.txt")

x_test<-read.table("/Users/Bora/RStudio/Week-4/UCI_HAR_Dataset/test/X_test.txt")
y_test<-read.table("/Users/Bora/RStudio/Week-4/UCI_HAR_Dataset/test/y_test.txt")
subject_test<-read.table("/Users/Bora/RStudio/Week-4/UCI_HAR_Dataset/test/subject_test.txt")

x_combined<-rbind(x_train,x_test)
y_combined<-rbind(y_train,y_test)
subject_combined<-rbind(subject_train,subject_test)

indices_4_mean<-grep("mean",features$V2)
indices_4_std<-grep("std",features$V2)

measurement_4_mean<-x_combined[,indices_4_mean]
measurement_names_4_mean<-features[indices_4_mean,]
colnames(measurement_4_mean)<-measurement_names_4_mean$V2

measurement_4_std<-x_combined[,indices_4_std]
measurement_names_4_std<-features[indices_4_std,]
colnames(measurement_4_std)<-measurement_names_4_std$V2

all_necessary_measurements<-cbind(measurement_4_mean,measurement_4_std)
all_necessary_measurements_activity<-cbind(all_necessary_measurements,activity=factor(y_combined$V1))
all_necessary_measurements_subjects<-cbind(all_necessary_measurements,subject=factor(subject_combined$V1))

temporary_variable<-data.table(all_necessary_measurements_subjects)
averages_4_subjects<-temporary_variable[,lapply(.SD,mean),by=subject]
averages_4_subjects<-averages_4_subjects[order(subject)]

temporary_variable_2<-data.table(all_necessary_measurements_activity)
averages_4_activities<-temporary_variable_2[,lapply(.SD,mean),by=activity]
averages_4_activities<-averages_4_activities[order(activity)]
averages_4_activities$activity<-activity_labels$V2

