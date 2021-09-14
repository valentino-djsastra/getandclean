# getandclean

run_analysis.R does following steps:
1. Download dataset from website (if it has not existed in the working directory).
2. Read training and test datasets then merge them into a master dataset contanining x (measurements), y (activity) and subject
3. Load feature, activity info and extract columns named 'mean'(-mean) and 'standard'(-std). 
4. Extract data by selected columns (from step 3), and merge x, y(activity) and subject data. 
5. Generate 'Tidy Dataset' comprising the average (mean) of each variable for each subject and each activity as "tidy_data.txt".
