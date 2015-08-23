library(data.table)
library(dplyr)

run_analysis <- function() {
  # Convenience operator for the sake of quickly pasting items together below
  "%p%" <- function(x, y) {
    return(paste(x,y, sep=""))
  }

  destination_compressed_file <- "human_activity.zip"
  destination_uncompressed_files <- "UCI HAR Dataset"
  source_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  if (!file.exists(destination_uncompressed_files)) {
    # Verify the file doesn't exist and download it if necessary.
    download.file(source_url, destfile = destination_compressed_file)
    
    # Unpack the archive
    unzip(destination_compressed_file)
    
    # There's no need to keep the compressed file on the disk
    unlink(destination_compressed_file)
  } else {
    print(c('Skipping download/uncompress. Delete the following directory to download again: ', destination_uncompressed_files))
  }
  
  
  features <- fread(destination_uncompressed_files %p% '/features.txt')
  setnames(features, 1:2, c('index', 'measurement'))
  features$index = as.numeric(features$index)

  activity_labels <- fread(destination_uncompressed_files %p% '/activity_labels.txt')
  setnames(activity_labels, 1:2, c('index', 'activity'))
  setkey(activity_labels, 'index')

  # Accepts a type to determine if we're reading training or test files. This is blocked off as a sub-function
  #   merely for code reusability purposes.
  read_files <- function(type, label_increment_amount = 0) {
    # Define our set working data
    wd <- destination_uncompressed_files %p% "/" %p% type %p% "/"
    # Read the subject data
    subject_data <- read.table(wd %p%"subject_" %p% type %p% ".txt", col.names = "subject id")
    # Read the labels
    activities <- read.table(wd %p% "y_" %p% type %p% ".txt", col.names = "activity")
    # Read the measurement data
    measurement_data_file <- wd %p% "x_" %p% type %p% ".txt"
    measurement_data <- read.table(measurement_data_file, sep="", strip.white = FALSE, fill=TRUE, skipNul=FALSE, stringsAsFactors=FALSE)
    # Capture only standard deviation and mean measurements
    std_mean_features <- features[grep("-std()|-mean\\()", features$measurement)]
    measurement_data <- measurement_data[,std_mean_features$index]
    # Define the column names
    colnames(measurement_data) <- std_mean_features$measurement
    
    return(cbind(subject_data, activities, measurement_data))
  }
  
  table <- read_files('test')
  table2 <- read_files('train', label_increment_amount = max(table$label))
  final_table <- rbindlist(list(table, table2))
  
  # Apply the friendly activity label
  final_table <- mutate(final_table, activity=activity_labels[activity]$activity)
  
  print('writing tidy data set')
  write.csv(final_table, "tidy_data.csv")
  
  return(final_table)
}