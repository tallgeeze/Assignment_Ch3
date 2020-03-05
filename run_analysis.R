##########loading########
library(tidyr)
library(dplyr)

##########extracting data###########

train_set <- readLines("train/X_train.txt")
train_label <- readLines("train/y_train.txt")
test_set <- readLines("test/X_test.txt")
test_label <- readLines("test/y_test.txt")
train_subject <-readLines("train/subject_train.txt")
test_subject <-readLines("test/subject_test.txt")


########merge####################

data_set_temp1 <- data.frame("subject"= train_subject, "data_set" = train_set, "data_label"= train_label, "data_tag" = replicate("train", n = length(train_set)),stringsAsFactors = F)
data_set_temp2 <- data.frame("subject"= test_subject , "data_set" = test_set, "data_label"= test_label, "data_tag" = replicate("test", n = length(test_set)),stringsAsFactors = F)
data_base <- rbind.data.frame(data_set_temp1, data_set_temp2)

##########calculating######
temp<-strsplit(data_base$data_set," ")
to_calculate<-temp[]
data_base$mean <- sapply(to_calculate[], function(x) mean(as.numeric(x), na.rm= T))
data_base$sd <- sapply (to_calculate[], function(x) sd(as.numeric(x),na.rm = T))

##########replace the status code with activity names###########
data_base$status <- gsub("1","WALKING",data_base$data_label)
data_base$status <- gsub("2","WALKING_UPSTAIRS",data_base$status)
data_base$status <- gsub("3","WALKING_DOWNSTAIRS",data_base$status)
data_base$status <- gsub("4","SITTING",data_base$status)
data_base$status <- gsub("5","STANDING",data_base$status)
data_base$status <- gsub("6","LAYING",data_base$status)

#########reshaping data& its name#########
tidy_data_set <- select(.data = data_base, c(subject,mean,sd,status,data_tag))
View(tidy_data_set)   
write.table(tidy_data_set, file = "tidy_data.txt", row.names = F)
####                                               ####
#### tidy_data_set is the cleaned data set, which  ####   
#### contains subject, mean of sensor data at each ####
#### observation and its standard diviation called ####
#### sd.  Status is  the  appropriate  label  of   ####
#### activities. data_tag is tag: train/test.      ####



######## thank you for your grading!     ##########