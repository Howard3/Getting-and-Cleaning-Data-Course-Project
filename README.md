

## Generation from the UCI HAR Dataset
### Required Libraries
* plyr
* data.table

### Rerunning the code
1. source the **run_analysis.R** file
2. execute the imported **run_analysis()** function
  _optional_: The function will return a data.table to memory.

### run_analysis.R process explained
1. loads required libraries (data.table & plyr)
2. **inside of run_analysis** defines the convenience paste method %p% which is used extensively throughout the code.
3. Defines destination files, Destination Directories, and Source File (for downloading)
4. Downloads the file if the uncompressed directory has not been detected _if it's been detected, skip to step 6_
5. Unzips and deletes the original zip file
6. Read in the **features.txt** file provided from the dataset. These define the meaning of each measurement.
    * Will assign an index and measurement column name for quick reference later
7. Reads in the **activity_labels.txt** file for consumption later
    * Will assign an index and activity column names to the read data for quick reference
8. Defines read function
    1. Defines the working directory **wd**
    2. Reads the associated data files for each set _replace "type" below with the test or train respectively_
        * **subject_type.txt** to determine the subjects for each reading
        * **y_type.txt** to determine the activity done at the time
        * **x_type.txt** to receive all of the measurements observed.
    3. Extracts only the **standard deviation** and **mean** measurements recorded from the _x_type.txt_ dataset above.
    4. Defines the appropriate column names for the measurements extracted above from the **features.txt** file read earlier.
    5. Binds all of the data read into a single data.frame
9. Calls the read function twice. Once for **test** and once for **train**
10. Merges the two data sets together
11. Rewrites the activity column with **mutate** from dplyr to be clearly readable
12. Writes the data set to **tidy_data.csv**
13. Returns the data.table representation of the data.

## tidy_data.csv column names

```r
colnames(data)
```

```
##  [1] "subject.id"                  "activity"                   
##  [3] "tBodyAcc.mean...X"           "tBodyAcc.mean...Y"          
##  [5] "tBodyAcc.mean...Z"           "tBodyAcc.std...X"           
##  [7] "tBodyAcc.std...Y"            "tBodyAcc.std...Z"           
##  [9] "tGravityAcc.mean...X"        "tGravityAcc.mean...Y"       
## [11] "tGravityAcc.mean...Z"        "tGravityAcc.std...X"        
## [13] "tGravityAcc.std...Y"         "tGravityAcc.std...Z"        
## [15] "tBodyAccJerk.mean...X"       "tBodyAccJerk.mean...Y"      
## [17] "tBodyAccJerk.mean...Z"       "tBodyAccJerk.std...X"       
## [19] "tBodyAccJerk.std...Y"        "tBodyAccJerk.std...Z"       
## [21] "tBodyGyro.mean...X"          "tBodyGyro.mean...Y"         
## [23] "tBodyGyro.mean...Z"          "tBodyGyro.std...X"          
## [25] "tBodyGyro.std...Y"           "tBodyGyro.std...Z"          
## [27] "tBodyGyroJerk.mean...X"      "tBodyGyroJerk.mean...Y"     
## [29] "tBodyGyroJerk.mean...Z"      "tBodyGyroJerk.std...X"      
## [31] "tBodyGyroJerk.std...Y"       "tBodyGyroJerk.std...Z"      
## [33] "tBodyAccMag.mean.."          "tBodyAccMag.std.."          
## [35] "tGravityAccMag.mean.."       "tGravityAccMag.std.."       
## [37] "tBodyAccJerkMag.mean.."      "tBodyAccJerkMag.std.."      
## [39] "tBodyGyroMag.mean.."         "tBodyGyroMag.std.."         
## [41] "tBodyGyroJerkMag.mean.."     "tBodyGyroJerkMag.std.."     
## [43] "fBodyAcc.mean...X"           "fBodyAcc.mean...Y"          
## [45] "fBodyAcc.mean...Z"           "fBodyAcc.std...X"           
## [47] "fBodyAcc.std...Y"            "fBodyAcc.std...Z"           
## [49] "fBodyAccJerk.mean...X"       "fBodyAccJerk.mean...Y"      
## [51] "fBodyAccJerk.mean...Z"       "fBodyAccJerk.std...X"       
## [53] "fBodyAccJerk.std...Y"        "fBodyAccJerk.std...Z"       
## [55] "fBodyGyro.mean...X"          "fBodyGyro.mean...Y"         
## [57] "fBodyGyro.mean...Z"          "fBodyGyro.std...X"          
## [59] "fBodyGyro.std...Y"           "fBodyGyro.std...Z"          
## [61] "fBodyAccMag.mean.."          "fBodyAccMag.std.."          
## [63] "fBodyBodyAccJerkMag.mean.."  "fBodyBodyAccJerkMag.std.."  
## [65] "fBodyBodyGyroMag.mean.."     "fBodyBodyGyroMag.std.."     
## [67] "fBodyBodyGyroJerkMag.mean.." "fBodyBodyGyroJerkMag.std.."
```
