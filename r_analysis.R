
## Download and unzip the files needed for the analisys
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "desired directory/files.zip")

run_analysis <- function(){
      
      library(plyr); library(dplyr); library(tidyr); library(stringr)
      
      # 1. Merges the training and the test sets to create one data set.
      
      
      
      ## read the files inside test
      #setwd(".../files/UCI HAR Dataset/test") if not in the working dir
      subject_test <- read.table("subject_test.txt")
      test_set <- read.table("X_test.txt")
      test_lables <- read.table("Y_test.txt")

      ## change the column names for lables and subject
      names(test_lables) <- c("lables")
      names(subject_test) <- c("subject")

      ## merge test set, lable, and subject
      test <- cbind(subject_test, test_lables, test_set)
      
      #switch to train directory and repeat the same step as above
      #setwd(".../files/UCI HAR Dataset/train") if the file is not in working dir
      subject_train <- read.table("subject_train.txt")
      train_set <- read.table("X_train.txt")
      train_label <- read.table("y_train.txt")
      names(train_label) <- c("lables"); names(subject_train) <- c("subject")
      train <- cbind(subject_train, train_label, train_set)
      
      ## merge both data set
      merged_data <- merge(train, test, all = TRUE)
      
      # 2.Extracts only the measurements on the mean and standard deviation for each measurement.
      
      ## switch directory if necesary, read the features file and extract the desired 
      ## values (means and standar deviations)
      features <- read.table("features.txt")
      features_num <- grep("(.*)mean\\()(.*)|(.*)std(.*)", features$V2)

      ## create a vector with the desired column numbers (label, subject, 
      ## and hte columns with means and standard deviations)
      columns <- c(1, 2, features_num + 2)

      ## filter the desired columns
      desired_data <- (merged_data[, columns])

      # 3.Uses descriptive activity names to name the activities in the data set.

      ##change "lables" column to a factor, then change levels name to desired 
      ## ones (used dplyr package to mutate lables column)
      desired_data <- mutate(desired_data, lables = as.factor(lables))
      levels(desired_data$lables) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

      # 4.Appropriately labels the data set with descriptive variable names
      ##
      variables <- c("subject", "lable", as.character(features[features_num, 2]))

      ## fix a small typo on the variables, the last 6 values have the word 
      ## "Body" writen twice
      variables[63:68] <- sub("Body", "", variables[63:68])
      names(desired_data) <- variables

      # 5.From the data set in step 4, creates a second, independent tidy data set with the 
      ## average of each variable for each activity and each subject.
      ##
      summarized_data <- desired_data %>% group_by(subject, lable) %>% summarise_each(funs(mean))
      tidy_data <- summarized_data %>% gather(variable, average, `tBodyAcc-mean()-X`:`fBodyGyroJerkMag-std()`)

      ## separate the variable column into dimension (x, y, z, and mag), and 
      ## value (mean or std)
      tidy_data$variable <- gsub("-", "_", tidy_data$variable)
      tidy_data$variable <- sub("Mag", "", tidy_data$variable)
      tidy_data <- separate(tidy_data, variable, c("Variable", "value","dimension"))
      
      View(tidy_data)
      
      ## to see an even more neet data set (optional)
      ## View(spread(tidy_data, dimension, average))
}


