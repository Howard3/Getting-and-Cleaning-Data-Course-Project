

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
##  [1] "X"                           "subject.id"                 
##  [3] "activity"                    "tBodyAcc.mean...X"          
##  [5] "tBodyAcc.mean...Y"           "tBodyAcc.mean...Z"          
##  [7] "tBodyAcc.std...X"            "tBodyAcc.std...Y"           
##  [9] "tBodyAcc.std...Z"            "tGravityAcc.mean...X"       
## [11] "tGravityAcc.mean...Y"        "tGravityAcc.mean...Z"       
## [13] "tGravityAcc.std...X"         "tGravityAcc.std...Y"        
## [15] "tGravityAcc.std...Z"         "tBodyAccJerk.mean...X"      
## [17] "tBodyAccJerk.mean...Y"       "tBodyAccJerk.mean...Z"      
## [19] "tBodyAccJerk.std...X"        "tBodyAccJerk.std...Y"       
## [21] "tBodyAccJerk.std...Z"        "tBodyGyro.mean...X"         
## [23] "tBodyGyro.mean...Y"          "tBodyGyro.mean...Z"         
## [25] "tBodyGyro.std...X"           "tBodyGyro.std...Y"          
## [27] "tBodyGyro.std...Z"           "tBodyGyroJerk.mean...X"     
## [29] "tBodyGyroJerk.mean...Y"      "tBodyGyroJerk.mean...Z"     
## [31] "tBodyGyroJerk.std...X"       "tBodyGyroJerk.std...Y"      
## [33] "tBodyGyroJerk.std...Z"       "tBodyAccMag.mean.."         
## [35] "tBodyAccMag.std.."           "tGravityAccMag.mean.."      
## [37] "tGravityAccMag.std.."        "tBodyAccJerkMag.mean.."     
## [39] "tBodyAccJerkMag.std.."       "tBodyGyroMag.mean.."        
## [41] "tBodyGyroMag.std.."          "tBodyGyroJerkMag.mean.."    
## [43] "tBodyGyroJerkMag.std.."      "fBodyAcc.mean...X"          
## [45] "fBodyAcc.mean...Y"           "fBodyAcc.mean...Z"          
## [47] "fBodyAcc.std...X"            "fBodyAcc.std...Y"           
## [49] "fBodyAcc.std...Z"            "fBodyAccJerk.mean...X"      
## [51] "fBodyAccJerk.mean...Y"       "fBodyAccJerk.mean...Z"      
## [53] "fBodyAccJerk.std...X"        "fBodyAccJerk.std...Y"       
## [55] "fBodyAccJerk.std...Z"        "fBodyGyro.mean...X"         
## [57] "fBodyGyro.mean...Y"          "fBodyGyro.mean...Z"         
## [59] "fBodyGyro.std...X"           "fBodyGyro.std...Y"          
## [61] "fBodyGyro.std...Z"           "fBodyAccMag.mean.."         
## [63] "fBodyAccMag.std.."           "fBodyBodyAccJerkMag.mean.." 
## [65] "fBodyBodyAccJerkMag.std.."   "fBodyBodyGyroMag.mean.."    
## [67] "fBodyBodyGyroMag.std.."      "fBodyBodyGyroJerkMag.mean.."
## [69] "fBodyBodyGyroJerkMag.std.."
```
