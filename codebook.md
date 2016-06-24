
      

      subject_test: a data frame that stores the test subject`s id
      
      test_set: a data frame that stores all the 561-feature vectors of the test group 
      
      test_lables: a data frame that stores the labels` id
      
      test: a merged data frame combining the columns of the test`s subject id, lable id, and feature vectors
      
      subject_train: a data frame that stores the train subject`s id
      
      train_set: a data frame that stores all the 561-feature vectors of the trainig group
      
      train_label: a data frame that stores the labels` id of the train group
      
      train: a merged data frame combining the columns of the test`s subject id, lable id, and feature vectors
      
      merged_data: a data frame that merges both train and test data frame
      
      features: is a data frame that store the names of the 561 feature vectors
      
      features_num: is an integer vector that stores the position of the vectors
      which are either standard deviations or means

      columns: it`s an numeric vector that store the number of desired columns

      desired_data: is a data frame with selected columns from the merged_data

      variables: is a character vector that store the columns/variables names

      summarized_data: is a grouped and summarized data frame with the average of each variable for each activity and each subject 
      
      tidy_data: is a tidy data frame with 6 columns, the key column is variable and the
      avarage collumn is the value, the variable column has been
      spread into variable name, value (mean or std), and dimension (x, y, z, or magnitud)



