# Getting-Cleaning-Data-Project
  This repository has three files, one R based script and two .txt file. The R script takes the raw data and analyses it, writing the mean_std_avg_all.txt file.  The CodeBook.txt file is a codebook for the variables. 
  
  The raw data is from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  
  The .txt file can be read into R with the following command:
  
  data_0<-read.table("mean_std_avg_all.txt",header = TRUE)

* This data has 36 rows, 6 for different activities, and 30 for different subjects.
* There are 81 different columns, 2 of these are for identification (Activity_or_Subject, Class), the other 79 are for the mean and standard deviation values.
