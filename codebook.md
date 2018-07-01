The first three columns of the dataset:
- "activity_label" is the descriptive of the activity performed
- "subject" is the id number for the human subject (30 total)
- "activity" is the the id number of the activity performed


All of the rest of the variables follow a pattern with the variable names:
-Each begins with either time or frequency
-Records are taken either from an accelerometer or a gyroscope
-Each represents either the mean or standard deviation of each measure

Data cleaning steps (from the runanalysis.R file)
- column names from the features.txt file are added and the subject and activity files are bound to the test and training files
- the test and training files are then bound together
- only variables for the mean or standard deviation are included
- activity names are added in and variables names are made more descriptive
- "datafinal" is the final tidy dataset
- "datafinal_mean" is the mean for each variable for each subject and activity

