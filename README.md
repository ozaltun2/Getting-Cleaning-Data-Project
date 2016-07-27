# Getting-Cleaning-Data-Project
  This repository has two files, one R based script and one .txt file.  The data is from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  The .txt file can be read into R with the following command:
      data_0<-read.table("mean_std_avg_all.txt",header = TRUE)

Markup: *This data has 36 rows, 6 for different activities, and 30 for different subjects.
        *There are 81 different columns, 2 of these are for identification (Activity_or_Subject, Class), the other 79 are for the mean and standard deviation values.
