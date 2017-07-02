library(dplyr)
library(plyr)
# Download and unzip the data

if(!file.exists("Projectfile")){
    URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(URL, "/home/raf/R/Data Science Spécialization/Projetcfile", method = "curl")
    zipath<-"/home/raf/R/Data Science Spécialization/Projetcfile"
    outpath<-"~/R/Data Science Spécialization/Getting and cleaning data"
    unzip(zipath, exdir = outpath)
}else{
    zipath<-"/home/raf/R/Data Science Spécialization/Projetcfile"
    outpath<-"~/R/Data Science Spécialization/Getting and cleaning data"
    unzip(zipath, exdir = outpath)
}

# List the files in each directory and extract the paths 

files<-list.files("~/R/Data Science Spécialization/Getting and cleaning data/UCI HAR Dataset/test", full.names = TRUE)[-1]
files2<-list.files("~/R/Data Science Spécialization/Getting and cleaning data/UCI HAR Dataset/train", full.names = TRUE)[-1]

# Reading the files and making the data frame

MakeDataFrame<- function(files){
  data<-lapply(files, read.table)
  data<-do.call(cbind.data.frame, data)
}
test<-MakeDataFrame(files) ; train<-MakeDataFrame(files2) ; 

Cleaned_Data<-rbind(test, train)
rm(test, train)

# Naming the variables

name<-read.table("~/R/Data Science Spécialization/Getting and cleaning data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]
names(Cleaned_Data)<-c("Observation_Number", name,"Activity")

# Selecting the variables including means and standard deviation

x<-grep("mean()|std()", name)+1
Cleaned_Data<-Cleaned_Data[,c(1,x,563)]

#Renaming variables names

names(Cleaned_Data)<- gsub('-mean', 'Mean', names(Cleaned_Data))
names(Cleaned_Data)<- gsub('-std', 'Std', names(Cleaned_Data))
names(Cleaned_Data)<- gsub('[-()]', '', names(Cleaned_Data))

# Renaming the activity variables

Cleaned_Data$Activity<-as.character(Cleaned_Data$Activity)
Cleaned_Data$Activity<-gsub("1", "Walking", Cleaned_Data$Activity); Cleaned_Data$Activity<-gsub("2", "Walking_Upstairs", Cleaned_Data$Activity)
Cleaned_Data$Activity<-gsub("3", "Walking_Downstairs", Cleaned_Data$Activity); Cleaned_Data$Activity<-gsub("4", "Sitting", Cleaned_Data$Activity) 
Cleaned_Data$Activity<-gsub("5", "Standing", Cleaned_Data$Activity) ; Cleaned_Data$Activity<-gsub("6", "Laying", Cleaned_Data$Activity)

# Taking the mean of each columns in the data frame and storing it in a new dataFrame
MeanData<- Cleaned_Data  %>% group_by(Activity) %>%  summarise_at(vars(`tBodyAccMeanX`:`fBodyBodyGyroJerkMagMeanFreq`), mean)

write.table(Cleaned_Data, file="DataCleaned.txt")
write.table(MeanData, file="MeanDatacleaned.txt")