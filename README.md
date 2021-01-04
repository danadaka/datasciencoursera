# datasciencoursera

The files other than the dataset related to the final project for the course "Getting and cleaning data" is in the folder "course3_cleaningdata". 
The dataset is in the folder "data".

course3_cleaningdata/run_analysis.R - the R script file with the analysis.

course3_cleaningdata/uci_har_summarised.txt - the tidy dataset which was requared to create.

course3_cleaningdata/code_book - the code book that explains the summarised dataset.

data/uci_har_dataset - the initial dataset.

The steps in the file "run_analysis.R":
1. Load the library "tidyverse".
2. Read the feature labels from the file "features.txt" to name the variables later on. Bind the names of the variables that are not contained there also.
3. Read the activity labels from the file "activity_labels.txt".
4. Read the files "subject_train", "X_train", "y_train", "subject_test", "X_test" and "y_test". Bind them all together.
5. Rename the variables of the dataset which contains the information about both train and test sets.
6. Select the columns of the created dataset which contains one of the words "mean", "std", "activity", and "subject".
7. Group by activity and subject columns and calculate the mean for all the variables.
8. Save the summarised dataset.
