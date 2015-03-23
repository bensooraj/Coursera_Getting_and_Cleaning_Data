##### Project Work | Cleaning the "Human Activity Recognition Using Smartphones Data Set"
#####[University Project Homepage](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) | Downloaded from [UCI HAR Dataset](https%3A%2F%2Fd396qusza40orc.cloudfront.net%2Fgetdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
---

##### Download the dataset:
```R
setInternet2(use = TRUE)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "UCI_HAR_Dataset.zip")
unzip("UCI_HAR_Dataset.zip")
file.rename("UCI HAR Dataset", "UCI_HAR_Dataset")
```

##### An excerpt from the UCI_HAR_Dataset/README.txt file:
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. ... The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The README.txt file contains useful information about the dataset and about the files contained in the unzipped folder.

##### Important note about the Dataset:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
----

##### Breakdown: run_analysis.r

<ul>
	<li>STEP 1: Merge the training and test datasets
		<ol>
			<li>Load the datasets and label-files using read.table()
				<ol>
					<li>Label files:
						<ul>
							<li>Load features.txt into features</li>
							<li>Load activity_labels.txt into activity_labels</li>
						</ul>
					</li>
					<li>Training sets:
						<ul>
							<li>Load X_train.txt into X_train</li>
							<li>Load y_train.txt into Y_train</li>
							<li>Load subject_train.txt into subject_train</li>
						</ul>
					</li>
					<li>Test sets:
						<ul>
							<li>Load X_test.txt into X_test</li>
							<li>Load y_test.txt into Y_test</li>
							<li>Load subject_test.txt into subject_test</li>
						</ul>
					</li>
				</ol>
			</li>
			<li>Name the columns:
				<ul>
					<li>Name X_train and  X_test columns (561 features) using the vector features[,2] (contains names for each of the features calculated @ 50Hz)</li>
					<li>Name Y_train and Y_test columns as "activity"</li>
					<li>Name subject_train and subject_test columns as "subject"</li>
				</ul>
			</li>
			<li>Combine the training and test dataset fragments
				<ul>
					<li>Column bind subject_train, Y_train and X_train</li>
					<li>Column bind subject_test, Y_test and X_test</li>
					<li>Row bind the above two datasets</li>
				</ul>
			</li>
			<li>Sort the merged dataset using subjects followed by activities</li>
		</ol>		
	</li>
	<li>STEP 2: Extract columns which measure standard deviation and mean
		<ol>
			<li>Use grep() and search for column indices with names containing "subject" or "activity" or "mean" or "std"</li>
			<li>Use the above indices and select columns from the merged dataset</li>
		</ol>
	</li>
	<li>STEP 3: Name the activities in the dataset
		<ol>
			<li>1 as WALKING</li>
			<li>2 as WALKING_UPSTAIRS</li>
			<li>3 as WALKING_DOWNSTAIRS</li>
			<li>4 as SITTING</li>
			<li>5 as STANDING</li>
			<li>6 as LAYING</li>
		</ol>
	</li>
	<li>STEP 4: Assign descriptive variable names to the features
		<ol>
			<li>Replace "t" (in the beginning of the feature name) with "timeDomain_"</li>
			<li>Replace "f" (in the beginning of the feature name) with "frequencyDomain_"</li>
			<li>Replace "std()" with "standardDeviation"</li>
			<li>Replace "mean()" with "meanValue"</li>
			<li>Replace "Freq()" with "Frequency"</li>
			<li>Replace "BodyBody" with "Body"</li>
			<li>Replace "Acc" with "Acceleration"</li>
			<li>Replace "Gyro" with "Gyroscope"</li>
			<li>Replace "Mag" with "Magnitude"</li>
		</ol>
	</li>
	<li>STEP 5: Create the tidy dataset
		<ol>
			<li>Average of each feature per activity for each subject/participant
				<ul>
					<li>Use group_by() and group the dataset with "subject" and "activity"</li>
					<li>Use summarise_each() to calculate the average of each feature</li>
				</ul>
			</li>
			<li>Use write.table(.., row.name=FALSE) to write the summarized dataset to a text file</li>
		</ol>
	</li>
</ul>

---

##### Credits: 
<img src="http://archive.ics.uci.edu/ml/assets/logo.gif" width="35%"/>     <img src="http://i.imgur.com/j4IiOPc.png" width="40%"/>
